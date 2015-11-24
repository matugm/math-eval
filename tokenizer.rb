require_relative 'token'

class Tokenizer
  RULES = {
    /\d+/      => :int,
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
    RULES.each { |regex, type| find_token(regex, type) }
  end

  def find_token(regex, type)
    token = @buffer.scan(regex)
    @tokens << Token.new(type, token) if token
  end

  def skip_spaces
    @buffer.skip(/\s+/)
  end
end
