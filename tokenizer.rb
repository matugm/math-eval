require_relative 'token'

class Tokenizer
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
      token = @buffer.rest.match(regex)

      if token
        @tokens << Token.new(type, token[0])
        @buffer.skip_until(regex)
      end
    end
  end

  def skip_spaces
    @buffer.skip(/\s+/)
  end
end
