require_relative 'wagon'

# создаем дочерний класс пассажирского вагона на основе класса вагон, разница лишь в том, что вызывая инстанцирование класса PassengerWagon мы сразу же получаем продвинутый вагон с типом "пассажирский"
class PassengerWagon < Wagon
  def initialize
    @type = "Passenger"
  end
end
