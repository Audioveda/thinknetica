=begin
Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
     + Создавать станции
     - Создавать поезда
     - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
     - Назначать маршрут поезду
     - Добавлять вагоны к поезду
     - Отцеплять вагоны от поезда
     - Перемещать поезд по маршруту вперед и назад
     - Просматривать список станций и список поездов на станции
=end

#require 'pry'
require_relative 'station'
require_relative 'route'
require_relative './trains/train'
require_relative './trains/cargo_train'
require_relative './trains/passenger_train'
require_relative './wagons/wagon'
require_relative './wagons/cargo_wagon'
require_relative './wagons/passenger_wagon'

# это наш основной класс железной дороги 
class Main
  
  # мы можем читать в главном классе станции, маршруты, поезда и вагоны, которые хранятся внутри него в виде массивов заполненных инстансами других классов соответственно 
  attr_reader :stations, :routes, :trains, :wagons

  # при запуске основного класса создаем в нем пустышки массивов для станций, маршрутов, поездов и вагонов
  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
  end
  
  # метод вызова основного меню
  def run
    
    # бесконечно крутим меню пользователя пока он не выйдет из него ответив 0 
    loop do

      # вызываем спрятанный метод показывающий список главного меню и ждем реакцию юзера
      show_main_menu
      choice = gets.chomp
      
      # кейсим выбор пользователя и углубляемся в меню, вызывая соответствующий спрятанный метод в нашем классе
      case choice.to_i
      when 1 then work_with_stations
      when 2 then work_with_routes
      when 3 then work_with_trains
      when 4 then work_with_wagons
      when 0 then break
      else puts "Я не знаю чего ты хочешь"
      end
    end
  end

  def seed 
    create_station("Санкт-Петербург")
    create_station("Москва")
    create_station("Пермь")
    create_station("Новосибирск")
  end

  # закрываем внутренние вызовы методов работы с меню, никого не волнует как у нас тут всё внутри работает. Снаружи можно только запуститься методом run 
  private
  
  # работаем со станциями таким же лупом давая юзеру возможность выбрать следующий метод по вкусу либо выйти
  def work_with_stations
    loop do
      show_stations_menu
      choice = gets.to_i
      case choice
      when 1 then create_station
      when 2 then stations_list
      when 3 then describe_one_station
      when 0 then break
      else error_index
      end
    end
  end

  # метод, который просто выводит на экран список возможного выбора в подменю работы со станциями и больше ничего не делает
  def show_stations_menu
    puts "ГЛАВНОЕ МЕНЮ > СТАНЦИИ"
    puts "1 - создание станции"
    puts "2 - просмотра списка станций"
    puts "3 - работа с конкретной станцией"
    puts "0 - выйти назад в главное меню"
  end

  # креативный метод, который инстанцирует экземпляр класса station (после того как юзер даст название станции, если не было передано) и закидывает этот инстанс в массив основного класса main @stations (так происходит рождение новой станции)
  def create_station(title)
    if title.nil?
      puts "Please enter station name"
      title = gets.chomp
      station = Station.new(title)
    else
      station = Station.new(title)
    end
    @stations << station
  end

  # ридер метод выводящий на экран список всех текущих станций  
  def stations_list
    show_collection(@stations)
  end

  def describe_one_station
    puts "Please choice Station from the list bellow:"
    station = select_from_collection(@stations)
    puts station
    puts "Поезда на станции #{station.name}:"
    show_collection(station.trains)
  end

  # метод выводящий интерфейс списка меню ГЛАВНОЕ МЕНЮ > МАРШРУТЫ
  def show_routes_menu
    puts "ГЛАВНОЕ МЕНЮ > МАРШРУТЫ"
    puts "Введите 1 для создания маршрута"
    puts "Введите 2 чтобы увидеть список всех маршрутов"
    puts "Введите 3 чтобы рассмотреть конкретный маршрут"
    puts "Введите 4 чтобы добавить станцию к марщруту"
    puts "Введите 5 чтобы удалить станцию из марщрута"
    puts "Введите 0 чтобы выйти в предыдущее меню"
  end

  # метод вызывающий подменю работы с маршрутами 
  def work_with_routes
    loop do
      show_routes_menu
      choice = gets.to_i
      case choice
      when 1 then create_route
      when 2 then route_list
      when 3 then show_route
      when 4 then add_station_to_route
      when 5 then remove_station_from_route
      when 0 then break
      else error_index
      end
    end
  end
  
  # метод создающий маршрут
  def create_route
    
    # проверяем есть ли у нас как минимум две станции 
    loop do
      break if @stations.length >= 2
      puts "у вас сейчас #{@stations.length} станций, а для создания маршрута необходимо иметь минимум две станции. Давайте сделаем еще:"
      create_station
    end
    
    # если прошли проверку на наличие двух станций - можем задать начало и конец маршрута
    puts "Введите номер первой станции выбрав ее из списка"
    first_station_index = select_from_collection(@stations)
    puts "Введите номер последней станции выбрав ее из списка"
    last_station_index = select_from_collection(@stations)
    
    # когда начальная и конечные станции заданы - создаем маршрут и добавляем его в список маршрутов
    route = Route.new(first_station_index, last_station_index)
    @routes << route
  end

  def add_station_to_route
    puts "Выберите индекс маршрута"
    route = select_from_collection(@routes)
    puts "Выберите индекс станции"
    station = select_from_collection(@stations)
    return if route.nil? || station.nil?
    route.add_station(station)
  end

  def remove_station_from_route
    puts "Выберите индекс маршрута"
    route = select_from_collection(@routes)
    puts "Выберите индекс станции"
    station = select_from_collection(route.stations)
    route.del_station(station)
  end

  def show_route
    puts "Выберите индекс маршрута"
    route = select_from_collection(@routes)
    puts "Станции Маршрута"
    show_collection(route.stations)
  end

  def route_list
    puts "Все маршруты"
    @routes.each do |route|
      puts route
      puts "Станции этого маршрута"
      show_collection(route.stations)
    end
  end
  # Trains
  def all_trains
    puts "Все поезда"
    show_collection(@trains)
  end

  def create_train
    puts "Выберите тип: 1 - грузовой, 2 - пассажирский"
    case gets.to_i
    when 1 then create_cargo_train
    when 2 then create_passenger_train
    else puts "Нет такого типа. Попробуйте еще раз"
    end
  end

  def create_passenger_train
    puts "Введите номер поезда"
    number = gets.chomp
    train = PassengerTrain.new(number)
    @trains << train
  end

  def create_cargo_train
    puts "Введите номер поезда"
    number = gets.chomp
    train = CargoTrain.new(number)
    @trains << train
  end

  def describe_one_train
    puts "Выберите поезд по индексу"
    train = select_from_collection(@trains)
    puts "Номер объекта -#{train}"
    puts "Тип поезда - #{train.type}"
    puts "Номер Поезда - #{train.number}"
    if train.train_wagons == 0
      puts "Нет Вагонов"
    else
      puts "Количество вагонов - #{train.train_wagons}"
    end

    if train.route == nil
      puts "Поезд в Депо"
    else
      puts "Текущая станция - #{train.current_station.title}"
      puts "Маршрут - #{train.route}"
    end
  end

  def set_route_to_train
    puts "Выберите поезд"
    train = select_from_collection(@trains)
    puts "Выберите индекс маршрута"
    route = select_from_collection(@routes)
    train.take_route(route)
  end

  def add_wagon_to_train
    puts "Выберите поезд по индексу"
    train = select_from_collection(@trains)
    puts "Выберите вагон по индексу"
    wagon = select_from_collection(@wagons)
    if train.train_wagons.include?(wagon)
      puts "Этот Вагон уже есть в данном составе"
    else
      train.add_wagon(wagon)
    end
  end

  def remove_wagon_from_train
    puts "Выберите поезд по индексу"
    train = select_from_collection(@trains)
    puts "Выберите вагон по индексу"
    wagon = select_from_collection(train.train_wagons)
    train.del_wagon(wagon)
    show_collection(train.train_wagons)
  end

  def move_train_forward
    puts "Выберите поезд по индексу"
    train = select_from_collection(@trains)
    train.go_front
  end

  def move_train_backward
    puts "Выберите поезд по индексу"
    train = select_from_collection(@trains)
    train.go_back
  end

  def show_trains_menu
    puts "Введите 1 для создания поезда"
    puts "Введите 2 чтобы увидеть список всех поездов"
    puts "Введите 3 чтобы рассмотреть конкретный поезд"
    puts "Введите 4 чтобы назначать маршрут поезду"
    puts "Введите 5 чтобы добавить вагоны к поезду"
    puts "Введите 6 чтобы отцепить вагоны от поезда"
    puts "Введите 7 чтобы переместить поезд по маршруту вперед"
    puts "Введите 8 чтобы переместить поезд по маршруту назад"
    puts "Введите 0 чтобы выйти в предыдущее меню"
  end

  def work_with_trains
    loop do
      show_trains_menu
      choice = gets.to_i
      case choice
      when 1 then create_train
      when 2 then all_trains
      when 3 then describe_one_train
      when 4 then set_route_to_train
      when 5 then add_wagon_to_train
      when 6 then remove_wagon_from_train
      when 7 then move_train_forward
      when 8 then move_train_backward
      when 0 then break
      else error_index
      end
    end
  end
  # WAGONS
  def show_wagons_menu
    puts "Введите 1 для создания вагона"
    puts "Введите 2 чтобы увидеть список всех вагоноы"
    puts "Введите 3 чтобы рассмотреть конкретный вагон"
    puts "Введите 0 чтобы выйти в предыдущее меню"
  end

  def work_with_wagons
    loop do
      show_wagons_menu
      choice = gets.to_i
      case choice
      when 1 then create_wagon
      when 2 then all_wagons
      when 3 then describe_one_wagon
      when 0 then break
      else error_index
      end
    end
  end

  # создание вагонов
  def create_wagon
    puts "Выберите тип: 1 - грузовой, 2 - пассажирский"
    case gets.to_i
    when 1 then create_cargo_wagon
    when 2 then create_passenger_wagon
    else puts "Нет такого типа. Попробуйте еще раз"
    end
  end

  def create_passenger_wagon
    wagon = PassengerWagon.new
    @wagons << wagon
  end

  def create_cargo_wagon
    wagon = CargoWagon.new
    @wagons << wagon
  end

  def all_wagons
    puts "Все вагоны"
    show_collection(@wagons)
  end

  def describe_one_wagon
    puts "Выберите вагон по индексу"
    wagon = select_from_collection(@wagons)
    puts "Номер объекта -#{wagon}"
    puts "Тип вагона - #{wagon.type}"
  end

  def show_collection(collection)
    collection.to_enum.with_index(1).each do |item, index|
      puts "#{index} - #{item.info}"
    end
  end

  def show_main_menu
    line
    puts "ГЛАВНОЕ МЕНЮ :"
    puts "1 - Станции"
    puts "2 - Маршруты"
    puts "3 - Поезда"
    puts "4 - Вагоны"
    puts "0 - выход из программы"
    line
  end

  def error_index
    puts "Выбор не был распознан"
  end
  
  # метод, который выводит список доступных элементов в каком нибудь списке, который мы даем методу на вход
  def select_from_collection(collection)
    
    # отображаем элементы списка, в котором нужно выбрать элемент
    show_collection(collection)
    
    # запрашиваем юзера какой элемент он хотел бы выбрать
    index = gets.to_i - 1
    
    # выбрасываем если юзер ввел какую то позицию что являетсмя отрицательной
    return if index < 0

    collection[index]
  end
  
  def line
    puts "========================"
  end



end

# инстанцируем новую железную дорогу и запускаем на ней меню пользователя, можно начинать играть
railway = Main.new
railway.seed
railway.run

