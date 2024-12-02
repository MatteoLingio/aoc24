class Main
  def initialize(input_file)
    @input = IO.read(input_file).split("\n")
  end

  def run_pt_1
    @input.reduce(0) do |counter, report|
      safe?(report.split(" ")) ? counter + 1 : counter
    end
  end

  def run_pt_2
    @input
      .each
      .with_index
      .reduce(0) do |counter, (report, report_idx)|
        report = report.split(" ")
        is_safe =
          safe?(report) ||
            report.each_with_index.any? do |level, index|
              new_report = report.dup
              new_report.delete_at(index)
              safe?(new_report)
            end

        is_safe ? counter + 1 : counter
      end
  end

  def safe?(report)
    starting_sign = sign(report[0].to_i - report[1].to_i)
    report
      .map(&:to_i)
      .each_cons(2)
      .all? do |level_slice|
        diff = level_slice[0] - level_slice[1]
        sign(diff) == starting_sign && diff.abs.between?(1, 3)
      end
  end

  def sign(number)
    return "++-"[number <=> 0]
  end
end

main = Main.new("day2.txt")
puts main.run_pt_1

main = Main.new("day2.txt")
puts main.run_pt_2
