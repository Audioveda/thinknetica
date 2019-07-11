
class Wagon
  attr_reader :type

  def initialize(type)
    @type = type
  end

  def info
    type
  end
end
