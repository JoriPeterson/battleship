class Ship
  attr_reader :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length
  end

  # def health
  #   @health = @length - hits
  # end


end
