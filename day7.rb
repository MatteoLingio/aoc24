require "set"

class Main
  def initialize(input_file)
    @equations = IO.read(input_file).split("\n")
  end

  def run_pt_one
    sum = 0
    @equations.each do |eq|
      result, operands = eq.split(":")
      operands = operands.strip.split(" ").map(&:to_i)
      operators = %w[+ * ||].repeated_permutation(operands.length - 1).to_a
      p eq
      results = operators.map do |op|
        acc_result = 0
        (0...operands.length).each do |idx|
          operator = op.shift

          if operands[idx+1] && acc_result == 0
            if operator == "||"
              acc_result = "#{operands[idx]}#{operands[idx + 1]}".to_i
            else
              acc_result = eval("#{operands[idx]}#{operator}#{operands[idx+1]}").to_i
            end
          elsif operands[idx+1]
            if operator == "||"
              acc_result = "#{acc_result}#{operands[idx + 1]}".to_i
            else
              acc_result = eval("#{acc_result}#{operator}#{operands[idx+1]}").to_i
            end
          end
        end
        acc_result
      end.filter { |res| res == result.to_i }.uniq
      if results.length > 0
        sum += results.reduce(:+)
      end
    end
    sum
  end

  def run_pt_two
  end
end

main = Main.new("day7.txt")
p main.run_pt_one
p main.run_pt_two
