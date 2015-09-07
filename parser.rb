
class ExpressionParser
  def initialize(tokens)
    @tokens = tokens
  end

  def run
    @high_prio = []
    @low_prio  = []

    @tokens.each_with_index do |token, idx|
      next unless token.type == :int

      # right operator
      operator = @tokens[idx+1]

      left_operator = @tokens[idx-1]

      # Last number
      unless operator
        if left_operator.value == '*' || left_operator.value == '/'
          @high_prio << token
        else
          @low_prio << token
          @low_prio << left_operator
        end

        break
      end

      if operator.value == '*' || operator.value == '/'
        @high_prio << token
        @high_prio << operator
      elsif left_operator.value == '*' || left_operator.value == '/'
        @high_prio << token
      else
        @low_prio << token
        @low_prio << operator
      end
    end

    #show_stack

    eval_high
    eval_low
  end

  def eval_high
    @high_prio.each_with_index do |tok, idx|
      next unless tok.type == :int

      left_val = @high_prio.pop

      op = @high_prio.pop
      @high_prio << tok and break unless op

      right_val = @high_prio.pop
      break unless right_val

      case op.value
      when '*' then @high_prio << (Token.new(:int, left_val.value * right_val.value))
      when '/' then @high_prio << (Token.new(:int, right_val.value / left_val.value))
      end
    end

    @low_prio << (@high_prio.empty? ? (Token.new(:int, '0')) : @high_prio.last)
  end

  def eval_low
    @low_prio.each_with_index do |tok, idx|
      next unless tok.type == :int

      left_val = @low_prio.pop

      op = @low_prio.pop
      @low_prio << tok and break unless op

      right_val = @low_prio.pop
      break unless right_val

      case op.value
      when '+' then @low_prio << (Token.new(:int, right_val.value + left_val.value))
      when '-' then @low_prio << (Token.new(:int, right_val.value - left_val.value))
      end
    end

    eval_low if @low_prio.size == 3

    @low_prio.empty? ? 0 : @low_prio.last.value
  end

  def show_stack
    puts "-" * 40
    p @high_prio
    puts "-" * 40
    p @low_prio
  end
end
