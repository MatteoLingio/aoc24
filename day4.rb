require 'set'

class Main
  def initialize(input_file)
    @input = IO.read(input_file)
    @target_word = "XMAS"
    @directions_map = {
      "r" => [0, 1],
      "l" => [0, -1],
      "u" => [-1, 0],
      "d" => [1, 0],
      "ul" => [-1, -1],
      "ur" => [-1, 1],
      "dl" => [1, -1],
      "dr" => [1, 1]
    }
  end

  def run_pt_one
    words = @input.split("\n").map { |line| line.split("") }

    words.each.with_index.reduce(0) do |acc, (row, y)|
      acc + row.each.with_index.reduce(0) do |acc, (char, x)|
        if char == "X"
          acc + @directions_map.keys.reduce(0) do |acc, direction|
            acc + look_around(words, y, x, 0, direction)
          end
        else
          acc
        end
      end
    end
  end

  def run_pt_two
    words = @input.split("\n").map { |line| line.split("") }

    words.each.with_index.reduce(0) do |acc, (row, y)|
      acc + row.each.with_index.reduce(0) do |acc, (char, x)|
        if (char == "M" || char == "S") && look_for_x_mas(words, y, x)
          acc + 1
        else
          acc
        end
      end
    end
  end

  def look_around(words, y, x, current_target, direction)
      return 0 if y < 0 || y >= words.length
      return 0 if x < 0 || x >= words[y].length
      return 0 if words[y][x] != @target_word[current_target]
      return 1 if current_target == @target_word.length - 1

      total = 0

      dy, dx = @directions_map[direction]
      total += look_around(words, y + dy, x + dx, current_target + 1, direction)

      return total
  end

  def look_for_x_mas(words, y, x)
    return false if x + 1 >= words[y].length || y + 1 >= words.length || y + 2 >= words.length || x + 2 >= words[y].length

    up_left = words[y][x]
    up_right = words[y][x+2]
    middle = words[y+1][x+1]
    down_left = words[y+2][x]
    down_right = words[y+2][x+2]

    return false if middle != "A"
    return false if up_right != "S" && up_right != "M"
    return false if up_left == "S" && down_right != "M"
    return false if up_left == "M" && down_right != "S"
    return false if up_right == "S" && down_left != "M"
    return false if up_right == "M" && down_left != "S"
    return true
  end
end

main = Main.new("day4.txt")
p main.run_pt_one
p main.run_pt_two
