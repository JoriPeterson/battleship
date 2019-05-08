class Ship
  attr_reader :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = @length
  end

  def hit
    @health -= 1
  end

  def sunk?
    if @health == 0
      p"your ship has sunk!"
    end
  end

end
