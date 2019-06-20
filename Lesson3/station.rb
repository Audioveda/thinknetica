=begin
Класс Station (Станция):
+ Имеет название, которое указывается при ее создании
+ Может принимать поезда (по одному за раз)
+ Может возвращать список всех поездов на станции, находящиеся в текущий момент
+ Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
+ Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_reader :title, :trains
  
  def initialize(title)
    @title = title
    puts "«#{@title}» station is online"
    @trains = []
  end

  def park_train(train)
    @trains.push(train) unless @trains.include?(train)
    puts "train №#{train.number} on platform"
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.select {|train| train.type == type }.count
  end
end
