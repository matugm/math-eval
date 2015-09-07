require 'strscan'

require_relative 'lexer'
require_relative 'parser'

class Calculator
  def evaluate(string)
    calc(string)
  end
end

def calc(expression)
  # If the input is just one number don't bother evaluating it
  if expression.scan(/\d+/).size == 1
    return expression.to_i
  end

  # Parsing
  lexer  = Lexer.new
  tokens = lexer.parse(expression)

  # Evaluation
  evaluator = ExpressionParser.new(tokens)
  evaluator.run
end
