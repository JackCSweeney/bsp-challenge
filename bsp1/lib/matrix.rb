class Matrix
  attr_reader :size, :grid

  def initialize(size, rows)
    @size = size
    @grid = rows.map {|row| row.chars}
    @princess_coords = []
  end

  def get_princess_coords
    for i in (0...@size) do
      for j in (0...@size) do
        if @grid[i][j] == 'p'
          @princess_coords = [j, i]
          break
        end
      end
    end

    @princess_coords
  end
end