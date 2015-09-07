class Token
  attr_reader :type

  def initialize(type, value)
    @type, @value = type, value
  end

  def ==(other)
   value == other.value &&
   type  == other.type
  end

  def value
    @type == :int ? @value.to_i : @value
  end

  def priority
    return 1 if value == '+' || value == '-'
    return 2 if value == '*' || value == '/'
  end
end
