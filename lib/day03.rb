class Day3
  def self.parse_input(input)
    commands = []
    input.scan(/(don't)\(\)|(do)\(\)|(mul)\((\d+),(\d+)\)/) do |match|
      command, left, right = match.compact
      commands << {name: command, args: [left.to_i, right.to_i]}
    end
    commands
  end

  def self.part1(input)
    parse_input(input)
      .filter{|command| command[:name] == 'mul'}
      .map{ |command| command[:args][0] * command[:args][1] }.sum
  end

  def self.part2(input)
    enabled = true
    parse_input(input).reduce(0) do |sum, command|
      case command[:name]
      when "do"
        enabled = true
      when "don't"
        enabled = false
      when "mul"
        if enabled
          sum += command[:args][0] * command[:args][1]
        end
      end
      sum
    end
  end
end
