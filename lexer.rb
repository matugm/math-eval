class Token
  attr_reader :type, :value

  def initialize(type, value)
    @type, @value = type, value
  end
end

class Lexer
  def initialize
    @tokens = []
  end

  def parse(input)
    @tokens << Token.new(:int, 3)
  end
end
