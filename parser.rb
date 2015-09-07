# Convert an infix expression to postfix
# Uses the shunting yard algorithm

class ExpressionParser
  attr_reader :output

  def initialize(tokens)
    @tokens = tokens
    @output    = []
    @operators = []
  end

  def run
    @tokens.each_with_index do |token, idx|
      @output << token and next if token.type == :int

      while operator_priority_is_less_or_equal_than(token)
        @output << @operators.pop
      end

      @operators << token
    end

    @output += @operators.reverse

    self
  end

  def to_s
    @output.map { |t| t.value }.join(" ")
  end

  def operator_priority_is_less_or_equal_than(token)
    @operators.last && (token.priority <= @operators.last.priority.to_i)
  end

  def show_stack
    puts "-" * 40
    p @output
    puts "-" * 40
    p @operators
  end
end
