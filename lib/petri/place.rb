class Petri::Place
  attr_reader :label, :name
  def initialize(label, options={})
    raise TypeError unless label.is_a? Symbol

    name = options[:name] || label.to_s
    raise TypeError unless name.is_a? String

    @label = label
    @name = name
  end

  def compile
    {
      label: @label,
      name: @name,
    }
  end

  def eql?(other)
    return @label == other.label if other.is_a? Petri::Place
    false
  end

  alias_method :==, :eql?
end
