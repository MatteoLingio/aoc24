class Main
  def initialize(input_file)
    @input = IO.read(input_file)
  end

  def run_pt_1
    @input
      .scan(/mul\(\d{1,3},\d{1,3}\)/)
      .reduce(0) do |acc, match|
        acc + match.scan(/\d{1,3}/).map(&:to_i).reduce(:*)
      end
  end

  def run_pt_2
    active = true
    @input
      .scan(/mul\(\d{1,3},\d{1,3}\)|do\(\)|don\'t\(\)/)
      .reduce(0) do |acc, match|
        active = false if match.start_with?("don't")
        active = true if match.start_with?("do")
        if active && match.start_with?("mul")
          acc + match.scan(/\d{1,3}/).map(&:to_i).reduce(:*)
        else
          acc
        end
      end
  end
end

main = Main.new("day3.txt")
puts main.run_pt_1
puts main.run_pt_2
