class Main
  def initialize(input_file)
    @grid = IO.read(input_file).split("\n")
  end

  def run_pt_one
    antennas = {}
    (0...@grid.length).each do |row|
      (0...@grid[row].length).each do |col|
        char = @grid[row][col]
        if char != "."
          if antennas[char]
            antennas[char] << [row, col]
          else
            antennas[char] = [[row, col]]
          end
        end
      end
    end
    count = 0
    antennas.each do |key, value|
      value.each_cons(2) do |coord|
        p coord
        y_diff = coord[1][0] - coord[0][0]
        if coord[0][0] - y_diff >= 0 && coord[0][1] - 1 >= 0
          p coord[0][0] - y_diff
          count += 1
        end
        if coord[1][0] + y_diff >= @grid.length &&
             coord[1][1] + 1 >= @grid[0].length
          p coord[1][0] + y_diff
          count += 1
        end
      end
    end
    count
  end

  def run_pt_two
  end
end

main = Main.new("day8.txt")
p main.run_pt_one
p main.run_pt_two
