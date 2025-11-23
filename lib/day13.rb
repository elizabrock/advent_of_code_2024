class Day13
  def self.part1(input)
    inputs = input.split(/\n{2,}/)
    machines = inputs.map{ |input| ClawMachine.new(input) }
    machines.map(&:minimum_win_cost).compact.sum
  end

  def self.part2(input)
    "TBD"
  end

  class ClawMachine
    attr_reader :a_x, :a_y, :b_x, :b_y, :goal_x, :goal_y

    def initialize(input)
      a_line, b_line, goal_line = input.split("\n")
      regex = /X.(\d+), Y.(\d+)/
      @a_x, @a_y = a_line.match(regex).captures.map(&:to_i)
      @b_x, @b_y = b_line.match(regex).captures.map(&:to_i)
      @goal_x, @goal_y = goal_line.match(regex).captures.map(&:to_i)
    end

    def cost_of(a_presses, b_presses)
      (a_cost * a_presses) + (b_cost * b_presses)
    end

    def a_cost
      3
    end

    def b_cost
      1
    end

    def is_solveable?
      minimum_win_cost != nil
    end

    def minimum_win_cost
      beyond_maximum_win_cost = cost_of(101, 101)
      minimum_win_cost_so_far = beyond_maximum_win_cost
      (0..100).each do |possible_a_presses|
        x_with_a = a_x * possible_a_presses
        y_with_a = a_y * possible_a_presses

        (0..100).each do |possible_b_presses|
          cost = cost_of(possible_a_presses, possible_b_presses)
          break if cost > minimum_win_cost_so_far

          trial_x = x_with_a + (b_x * possible_b_presses)
          trial_y = y_with_a + (b_y * possible_b_presses)
          break if trial_x > goal_x || trial_y > goal_y

          if trial_x == goal_x && trial_y == goal_y
            minimum_win_cost_so_far = cost
          end
        end
      end
      (minimum_win_cost_so_far < beyond_maximum_win_cost) ? minimum_win_cost_so_far : nil
    end
  end
end
