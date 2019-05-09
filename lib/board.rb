class Board

  def initialize
  end

  def cells
    cells = {
     "A1" => @cell_1,
     "A2" => @cell_2,
     "A3" => @cell_3,
     "A4" => @cell_4,
     "B1" => @cell_5,
     "B2" => @cell_6,
     "B3" => @cell_7,
     "B4" => @cell_8,
     "C1" => @cell_9,
     "C2" => @cell_10,
     "C3" => @cell_11,
     "C4" => @cell_12,
     "D1" => @cell_13,
     "D2" => @cell_14,
     "D3" => @cell_15,
     "D4" => @cell_16
     }
   end
end

class Cell < Board

  @cell_1 = Cell.new
  @cell_2 = Cell.new
  @cell_3 = Cell.new
  @cell_4 = Cell.new
  @cell_5 = Cell.new
  @cell_6 = Cell.new
  @cell_7 = Cell.new
  @cell_8 = Cell.new
  @cell_9 = Cell.new
  @cell_10 = Cell.new
  @cell_11 = Cell.new
  @cell_12 = Cell.new
  @cell_13 = Cell.new
  @cell_14 = Cell.new
  @cell_15 = Cell.new
  @cell_16 = Cell.new

end
