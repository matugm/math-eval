require 'strscan'

require_relative 'lexer'
require_relative 'parser'
require_relative 'engine'

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
  parser = ExpressionParser.new(expression)
  ast    = parser.run

  # Evaluation
  evaluator = EvaluatorEngine.new(ast)
  evaluator.run
end