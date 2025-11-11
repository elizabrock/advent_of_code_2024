class Day7
  def self.part1(input)
    equations = parse_input(input)
    equations.keep_if(&:solvable?).sum(&:answer)
  end

  def self.part2(input)
    equations = parse_input(input)
    equations.map(&:enable_concatentation!)
    equations.keep_if(&:solvable?).sum(&:answer)
  end

  class CalibrationEquation
    attr_reader :answer
    CONCATENATION_OPERATOR = '||'

    def initialize(answer, operands)
      @answer = answer
      @operands = operands
      @operators = [:+, :*]
    end

    def enable_concatentation!
      @operators << CONCATENATION_OPERATOR
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
        @operators.map do |operator|
          if operator == CONCATENATION_OPERATOR
            (partial_answer.to_s + operand.to_s).to_i
          else
            partial_answer.send(operator, operand)
          end
        end
      end.flatten
      return progress if !remaining_operands
      permute_possible_calculations(remaining_operands, progress)
    end
  end

  private

  def self.parse_input(input)
    input.split(/\n/).map do |line|
      answer, operand_string = line.match(/(\d+): (.*)/).captures
      CalibrationEquation.new(answer.to_i, operand_string.split(/\s+/).map(&:to_i))
    end
  end
end
