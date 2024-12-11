require "set"

class Main
  def initialize(input_file)
    @directions_map = {
      "^" => [0, -1],
      ">" => [1, 0],
      "v" => [0, 1],
      "<" => [-1, 0]
    }

    @grid = IO.read(input_file).split("\n").map { |row| row.split("") }
  end

  def run_pt_one
    current_x, current_y = starting_position_idx
    current_direction = @grid[current_y][current_x]

    current_direction_idx = @directions_map.keys.find_index(current_direction)
    direction_keys = @directions_map.keys.rotate(current_direction_idx)
    visited_positions = Set.new

    while current_x < @grid[0].length && current_x >= 0 &&
            current_y < @grid.length && current_y >= 0
      next_x, next_y =
        [
          current_x + @directions_map[current_direction][0],
          current_y + @directions_map[current_direction][1]
        ]

      if next_x < @grid[0].length && next_x >= 0 && next_y < @grid.length &&
           next_y >= 0
        if @grid[next_y][next_x] == "#"
          direction_keys = direction_keys.rotate!
          current_direction = direction_keys.first
        end
      end

      visited_positions.add([current_x, current_y])
      current_x += @directions_map[current_direction][0]
      current_y += @directions_map[current_direction][1]
    end

    visited_positions.size
  end

  def run_pt_two
    keys = @directions_map.keys
    sums = []

    (0...@grid.length).each do |j|
      (0...@grid[0].length).each { |x| sums = sums << walk(keys, j, x) }
    end

    sums.reduce(:+)
  end

  private

  def walk(keys, col, row)
    infinite_loops_counter = 0
    current_x, current_y = starting_position_idx
    current_direction = @grid[current_y][current_x]

    current_direction_idx = 0
    direction_keys = @directions_map.keys

    visited_states = Set.new
    while current_x < @grid[0].length && current_x >= 0 &&
          current_y < @grid.length && current_y >= 0

      current_state = [current_x, current_y, current_direction]

      if visited_states.include?(current_state)
        infinite_loops_counter = 1  # Found a loop
        break
      end

      visited_states.add(current_state)

      next_x = current_x + @directions_map[current_direction][0]
      next_y = current_y + @directions_map[current_direction][1]

      if next_x < @grid[0].length && next_x >= 0 && next_y < @grid.length && next_y >= 0
        if @grid[next_y][next_x] == "#" || (next_x == row && next_y == col)
          current_direction_idx = (current_direction_idx + 1) % 4
          current_direction = direction_keys[current_direction_idx]
        else
          current_x = next_x
          current_y = next_y
        end
      else
        break
      end
    end

    infinite_loops_counter
  end

  def starting_position_idx
    @starting_position_idx ||=
      @grid
        .each
        .with_index
        .reduce([0, 0]) do |acc, (row, row_idx)|
          col_idx =
            row
              .each
              .with_index
              .select { |char, col_idx| @directions_map.keys.include?(char) }
              .map(&:last)
              .first
          acc = col_idx ? [col_idx, row_idx] : acc
        end
  end
end

main = Main.new("day6.txt")
p main.run_pt_one
p main.run_pt_two
