class Main
  def initialize(orders_file, updates_file)
    @orders = IO.read(orders_file).split("\n")
    @updates = IO.read(updates_file).split("\n")

    @orders_map = @orders.reduce({}) do |acc, order|
      first, second = order.split("|")
      acc[first] ? acc[first] << second : acc[first] = [second]
      acc
    end

    p @orders_map

    @unordered_list = []
  end

  def run_pt_one
    @updates.each.with_index.reduce(0) do |acc, (update, row)|
      splitted_update = update.split(",")
      ordered = true
      splitted_update.each_with_index do |char, index|
        if index > 0
          if !@orders_map[splitted_update[index - 1]] || !@orders_map[splitted_update[index - 1]].include?(char)
            @unordered_list << row
            ordered = false
            break
          end
        end
      end

      ordered ? acc += splitted_update[splitted_update.length / 2].to_i : acc
    end
  end

  def run_pt_two
    @unordered_list.reduce(0) do |acc, update_idx|
      splitted_update = @updates[update_idx].split(",")
      n = splitted_update.length
      sorted = false
      until sorted
        sorted = true
        (n-1).times do |j|
          if !@orders_map[splitted_update[j]] || !@orders_map[splitted_update[j]].include?(splitted_update[j+1])
            splitted_update[j], splitted_update[j+1] = splitted_update[j+1], splitted_update[j]
            sorted = false
          end
        end
      end

      middle_of_update = splitted_update[n / 2].to_i

      acc += middle_of_update
    end
  end
end

main = Main.new("day5_orders.txt", "day5_updates.txt")
main.run_pt_one
p main.run_pt_two
