class Day3
  def self.parse_input(input)
    output = []
    input.scan(/mul\((\d+),(\d+)\)/) do |left, right|
      output << [left.to_i, right.to_i]
    end
    output
  end

  def self.part1(input)
    parse_input(input).map{ |pair| pair[0] * pair[1] }.sum
  end

  def self.part2(input)
    "TBD"
  end
end
