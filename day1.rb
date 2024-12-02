class Main
  def initialize(input_file)
    input = IO.read(input_file).split("\n")
    @lists =
      input.reduce([[], []]) do |(l1, l2), line|
        ids = line.split(" ")
        l1 << ids[0]
        l2 << ids[1]
        [l1, l2]
      end
  end

  def run_pt_1
    @lists[0] = @lists[0].sort
    @lists[1] = @lists[1].sort
    @lists[0]
      .zip(@lists[1])
      .reduce(0) { |acc, (id1, id2)| acc = acc + (id1.to_i - id2.to_i).abs }
  end

  def run_pt_2
    list2_map =
      @lists[1].reduce({}) do |acc, id|
        if acc[id]
          acc[id] = acc[id] + 1
        else
          acc[id] = 1
        end
        acc
      end

    @lists[0].reduce(0) do |acc, id|
      acc = list2_map[id] ? acc + (id.to_i * list2_map[id].to_i) : acc
      acc
    end
  end
end

main = Main.new("day1.txt")
puts main.run_pt_1

main = Main.new("day1.txt")
puts main.run_pt_2
