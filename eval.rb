
class PostfixEvaluator
  def run(tokens)
    @numbers = []

    tokens.each do |token|
      push_number(token)        if token.type == :int
      evaluate_operation(token) if token.type == :op
    end

    @numbers.last.value
  end

  private

  def push_number(token)
    @numbers << token
  end

  def evaluate_operation(token)
    right_num = @numbers.pop
    left_num  = @numbers.pop

    raise 'Invalid postfix expression' unless right_num && left_num

    result = evaluate(left_num.value, right_num.value, token)
    @numbers << Token.new(:int, result)
  end

  def evaluate(left_num, right_num, operation)
    case operation.value
    when '+' then left_num + right_num
    when '-' then left_num - right_num
    when '*' then left_num * right_num
    when '/' then left_num / right_num
    end
  end
end
