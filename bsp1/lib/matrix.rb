class Matrix
  attr_reader :size, :grid

  def initialize(size, rows)
    @size = size
    @grid = rows.map {|row| row.chars}
  end

end