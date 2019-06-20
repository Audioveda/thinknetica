=begin
Класс Train (Поезд):
+ Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
+ Может набирать скорость
+ Может возвращать текущую скорость
+ Может тормозить (сбрасывать скорость до нуля)
+ Может возвращать количество вагонов
+ Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
+ Может принимать маршрут следования (объект класса Route). 
+ При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Train
  # Может возвращать текущую скорость и количество вагонов
  attr_reader :number, :type, :route, :current_station_index, :speed, :wagons
  # Имеет номер (произвольная строка), тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса   
  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    
  end
  
  # Может набирать скорость
  def speed_up(speed)
    @speed += speed
  end
  
  # Может тормозить (сбрасывать скорость до нуля)
  def speed_down(speed)
    @speed -= speed
    self.stop if @speed < 0
  end
  def stop
    @speed = 0
    puts "train №#{@number} stopped"
  end

  # Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  def wagon_attach
    return unless @speed == 0
    @wagons += 1
  end
  def wagon_detach
    return unless @speed == 0
    @wagons -= 1 if @wagons > 0
  end
  
  # Может принимать маршрут следования (объект класса Route). 
  # При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  def take_route(route)
    @route = route
    @station_index = 0
    station.park_train(self)
    puts "train №#{@number} ready to go"
  end

  def station
    route.stations[@station_index]
  end
  
  #Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  def move_forward
    return if next_station.nil?
    station.send_train(self)
    next_station.park_train(self)
    @station_index += 1
  end

  def move_backward
    return if previous_station.nil?
    station.send_train(self)
    previous_station.park_train(self)
    @station_index -= 1
  end
  
  # может возвращать предыдущую станцию, текущую, следующую, на основе маршрута
  def next_station
    route.stations[@station_index + 1]
  end

  def previous_station
    return unless @station_index > 0
    route.stations[@station_index - 1]
  end
end
