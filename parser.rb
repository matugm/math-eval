
class ExpressionParser
  def initialize(tokens)
    @tokens = tokens
  end

  def run
    @output     = []
    @operators  = []

    @tokens.each_with_index do |token, idx|
      @output << token if token.type == :int

      if token.type == :op
        while @operators.last && (token.priority <= @operators.last.priority.to_i)
          @output << @operators.pop
        end

        @operators << token
      end
    end

    @output += @operators

    @output.map { |t| t.value }.join(" ")
  end

  def show_stack
    puts "-" * 40
    p @output
    puts "-" * 40
    p @operators
  end
end
