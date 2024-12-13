class Main
  def initialize(input_file)
    @disk_map = IO.read(input_file).split("")
  end

  def run_pt_one
    blocks = []
    char_count = 0
    @disk_map.each_with_index do |char, index|
      if index % 2 == 0
        (0...char.to_i).each do |i|
          char_count += 1
          blocks << (index / 2).to_s
        end
      else
        (0...char.to_i).each { |i| blocks << "." }
      end
    end

    p "here"

    i = 0
    j = blocks.length - 1
    while i < j
      if blocks[i] == "." && blocks[j] != "."
        blocks[i] = blocks[j]
        blocks[j] = "."
        i += 1
        j -= 1
      else
        i += 1 if blocks[i] != "."
        j -= 1 if blocks[j] == "."
      end
    end

      first_sequence = []
      blocks.each do |char|
        break if char == "."
        first_sequence << char
      end

      first_sequence.each_with_index.sum do |num, index|
        num.to_i * index
      end
  end

  def run_pt_two
  end
end

main = Main.new("day9.txt")
p main.run_pt_one
p main.run_pt_two
