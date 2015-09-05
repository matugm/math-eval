class Token
  attr_reader :type, :value

  def initialize(type, value)
    @type, @value = type, value
  end
end

class Lexer
  def parse(input)
    [Token.new(:int, 0)]
  end
end
