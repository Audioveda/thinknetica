require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    @number = number
    @train_wagons = []
    @speed = 0
    @type = "Passenger"
  end

  def attachable_wagon?(wagon)
    wagon.is_a?(PassengerWagon)
  end
end
