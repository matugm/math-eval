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

  xit 'can do more complicated math' do
    expect(subject.evaluate("3 + 4 + 4 + 2 * 2 * 2" )).to eq 19
  end
end

describe Lexer do
  let(:lex) { Lexer.new }

  it 'can parse a single number' do
    token = lex.parse('3').first
    expect(token.type).to eq :int
  end
end
