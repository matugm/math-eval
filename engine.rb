class EvaluatorEngine
  def initialize(ast)
    @ast = ast
    @total = 0
  end

  def run
    @total = nil
    @queue = []

    ast_pointer = @ast

    while ast_pointer.next
      @total = evaluate_subexpression(ast_pointer)
      ast_pointer = ast_pointer.next
    end

    @total
  end

  def evaluate_subexpression(exp)
    case exp.operation
    when '+' then exp.left_num + exp.next.left_num
    when '-' then exp.left_num - exp.next.left_num
    when '*' then exp.left_num * exp.next.left_num
    when '/' then exp.left_num / exp.next.left_num
    end
  end
end
