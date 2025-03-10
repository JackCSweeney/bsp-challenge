class InputReader
  def self.get_matrix_size
    size = $stdin.gets.to_i
    validate_size_input(size)
  end

  def self.validate_size_input(size)
    raise ArgumentError.new("Invalid size: Size must be an odd number between 3 and 100") if size < 3 || size > 100 || size.even?
    
    size
  end
end