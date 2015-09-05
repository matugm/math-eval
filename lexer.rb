class Token
  attr_reader :type, :value

  def initialize(type, value)
    @type, @value = type, value
  end

  def ==(other)
   value == other.value &&
   type  == other.type
  end
end

class Lexer
  RULES = {
    /\d+/   => :int,
    /[\/+\-*]/ => :op
  }

  def initialize
    @tokens = []
  end

  def parse(input)
    @buffer = StringScanner.new(input)

    until @buffer.eos?
      skip_spaces
      read_tokens
    end

    @tokens
  end

  def read_tokens
    RULES.each do |regex, type|
      match = @buffer.peek(10).match(regex)

      if match
        @tokens << Token.new(type, match[0])
        @buffer.skip_until(regex)
      end
    end
  end

  def skip_spaces
    @buffer.skip(/\s+/)
  end
end
