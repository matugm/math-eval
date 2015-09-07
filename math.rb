require 'strscan'

require_relative 'lexer'
require_relative 'parser'
require_relative 'eval'

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

  # Convert to postfix notation
  parser  = ExpressionParser.new(tokens)
  postfix_exp = parser.run

  # Evaluate
  evaluator = PostfixEvaluator.new.run(postfix_exp.output)
end
