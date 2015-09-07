
class PostfixEvaluator
  def run(tokens)
    @numbers = []

    tokens.each do |token|
      @numbers << token if token.type == :int

      if token.type == :op
        right_num = @numbers.pop
        left_num  = @numbers.pop

        raise 'Invalid postfix expression' unless right_num && left_num

        result = evaluate(right_num.value, left_num.value, token)
        @numbers << Token.new(:int, result)
      end
    end

    @numbers.last.value
  end

  def evaluate(right_num, left_num, operation)
    case operation.value
    when '+' then left_num + right_num
    when '-' then left_num - right_num
    when '*' then left_num * right_num
    when '/' then left_num / right_num
    end
  end
end
