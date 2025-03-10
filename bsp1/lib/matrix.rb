class Matrix
  attr_reader :size, :grid

  def initialize(size, rows)
    @size = size
    @grid = rows.map {|row| row.chars}
    @princess_coords = []
    @robot_coords = []
  end

  def get_princess_coords
    for i in (0...@size) do
      for j in (0...@size) do
        if @grid[i][j] == 'p'
          return @princess_coords = [j, i]
        end
      end
    end
  end

  def get_robot_coords
    center = @size / 2
    @robot_coords = [center, center]
  end
end