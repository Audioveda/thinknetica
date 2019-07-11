class Train
  attr_reader :number, :type, :train_wagons, :route, :speed, :current_station_index

  def increase_speed(speed)
    @speed += speed
  end

  def decrease_speed(speed)
    @speed -= speed
    @speed = 0 if @speed < 0
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    return unless @speed == 0
    return unless attachable_wagon?(wagon)
    @train_wagons << wagon
  end

  def del_wagon(wagon)
    return unless @speed == 0
    @train_wagons.delete(wagon)
  end

  def take_route(route)
    @route = route
    @current_station_index = 0
    current_station.park_train(self)
  end

  def current_station
    route.stations[@current_station_index]
  end

  def go_front
    return if next_station.nil?
    current_station.send_train(self)
    next_station.park_train(self)
    @current_station_index += 1
  end

  def go_back
    return if previous_station.nil?
    current_station.send_train(self)
    previous_station.park_train(self)
    @current_station_index -= 1
  end

  def next_station
    route.stations[@current_station_index + 1]
  end

  def previous_station
    return unless @current_station_index > 0
    route.stations[@current_station_index - 1]
  end

  def info
    self.number
  end
end
