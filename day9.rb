class Main
  def initialize(input_file)
    @disk_map = IO.read(input_file).split("")
  end

  def run_pt_one
    blocks = []
    char_count = 0

    # Create the initial sequence
    @disk_map.each_with_index do |char, index|
      if index % 2 == 0
        char.to_i.times { blocks << (index / 2).to_s }
      else
        char.to_i.times { blocks << "." }
      end
    end

    # Move numbers to the left
    left = 0
    right = blocks.length - 1

    while left < right
      left += 1 while blocks[left] != "."
      right -= 1 while blocks[right] == "."

      if left < right
        blocks[left], blocks[right] = blocks[right], blocks[left]
        left += 1
        right -= 1
      end
    end

    first_sequence = []
    blocks.each do |char|
      break if char == "."
      first_sequence << char
    end

    first_sequence.each_with_index.sum { |num, index| num.to_i * index }
  end

  def run_pt_two
  end
end

main = Main.new("day9.txt")
p main.run_pt_one
p main.run_pt_two
