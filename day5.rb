class Main
  def initialize(orders_file, updates_file)
    @orders = IO.read(orders_file).split("\n")
    @updates = IO.read(updates_file).split("\n")

    @orders_map = @orders.reduce({}) do |acc, order|
      first, second = order.split("|")
      acc[first] ? acc[first] << second : acc[first] = [second]
      acc
    end

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
      splitted_update = @updates[update_idx].split(",").sort! do |a, b|
        @orders_map[a] && @orders_map[a].include?(b) ? -1 : 1
      end

      acc += splitted_update[splitted_update.length / 2].to_i
    end
  end
end

main = Main.new("day5_orders.txt", "day5_updates.txt")
main.run_pt_one
main.run_pt_two
