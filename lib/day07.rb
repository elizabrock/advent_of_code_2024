class Day7
  def self.part1(input)
    equations = input.split(/\n/).map do |line|
      answer, operand_string = line.match(/(\d+): (.*)/).captures
      CalibrationEquation.new(answer.to_i, operand_string.split(/\s+/).map(&:to_i))
    end
    equations.keep_if(&:solvable?).sum(&:answer)
  end

  def self.part2(input)
    "TBD"
  end

  class CalibrationEquation
    attr_reader :answer
    OPERATORS = [:+, :*]

    def initialize(answer, operands)
      @answer = answer
      @operands = operands
    end

    def solvable?
      possible_calculations(@operands).any?{ |calculation| calculation == answer }
    end

    private

    def possible_calculations(operands)
      permute_possible_calculations(operands, nil)
    end

    def permute_possible_calculations(operands, progress)
      return progress if operands.empty?
      operand = operands[0]
      remaining_operands = operands[1..operands.length]
      if progress.nil?
        return permute_possible_calculations(remaining_operands, [operand])
      end
      progress = progress.map do |partial_answer|
        OPERATORS.map{ |operator|
          partial_answer.send(operator, operand) }
      end.flatten
      return progress if !remaining_operands
      permute_possible_calculations(remaining_operands, progress)
    end
  end

  private

  def self.parse_input(input)
  end
end
