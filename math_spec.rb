require_relative 'math.rb'

describe Calculator do
  it 'can do basic operations' do
    expect(subject.evaluate("3+4")).to eq 7
  end

  it 'can do multiplication' do
    expect(subject.evaluate("9*4")).to eq 36
  end

  it 'can do division' do
    expect(subject.evaluate("20 / 2")).to eq 10
  end

  it 'can do more complicated math' do
    expect(subject.evaluate("3 + 4 + 4 + 2 * 2 * 2 + 10" )).to eq 29
    expect(subject.evaluate("21 + 3 / 2 * 1 + 7 * 3 + 8 * 1 - 1 + 12 + 5 + 15 * 3")).to eq 112
  end
end

describe Lexer do
  let(:lex) { Lexer.new }

  it 'can parse a single number' do
    token = lex.parse('3').first

    expect(token.type).to eq :int
    expect(token.value).to eq 3
  end

  it 'can parse a plus operator' do
    token = lex.parse('+').first

    expect(token.type).to eq :op
    expect(token.value).to eq '+'
  end

  it 'can parse an expression' do
    tokens = lex.parse('25 * 10')

    expected_tokens = [
      Token.new(:int, '25'),
      Token.new(:op, '*'),
      Token.new(:int, '10')
    ]

    expect(tokens).to eq expected_tokens
  end
end

describe ExpressionParser do
  let(:parser) {
    tokens = [
      Token.new(:int, '25'),
      Token.new(:op, '*'),
      Token.new(:int, '10'),
      Token.new(:op, '+'),
      Token.new(:int, '5')
    ]

    ExpressionParser.new(tokens)
  }

  it 'can convert an expression from infix to postfix notation' do
    expect(parser.run).to eq "25 10 * 5 +"
  end
end
