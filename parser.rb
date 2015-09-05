
class SubExpression < Struct.new(:left_num, :operation, :next, :visited)
end

class ExpressionParser
  def initialize(expression)
    @buffer = StringScanner.new(expression)
    @depth  = 0
  end

  def run
    find_subexpressions
  end

  def find_expression
    Expression.new(
      find_number,
      find_operation,
      find_number,
      find_subexpressions,
      false
    )
  end

  def find_number
    return if @buffer.eos?
    skip_spaces

    num = @buffer.scan(/-?[^\+\-\*\/ )]+/)
    raise ArgumentError, "Number not found. #{@buffer.inspect}" unless num

    num.match('\.') ? num.to_f : num.to_i
  end

  def find_operation
    skip_spaces
    @buffer.getch
  end

  def find_subexpressions
    return if @buffer.eos?

    SubExpression.new(find_number, find_operation, find_subexpressions)
  end

  def skip_spaces
    @buffer.skip(/\s+/)
  end
end
