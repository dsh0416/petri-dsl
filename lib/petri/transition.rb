class Petri::Transition
  attr_reader :label, :name, :consumption, :production

  def initialize(label, options={}, &block)
    raise TypeError unless label.is_a? Symbol
    @label = label

    @name = options[:name] || label.to_s
    raise TypeError unless name.is_a? String

    @consumption = []
    @production = []

    consume(options[:consume]) unless options[:consume].nil?
    produce(options[:produce]) unless options[:produce].nil?

    block.call(self) unless block.nil?
  end

  def consume(label, options={})
    @consumption << label if label.is_a? Symbol
    if label.is_a? Array
      for place in label
        raise TypeError unless place.is_a? Symbol
        @consumption << place
      end
    end
  end

  def produce(label, options={})
    raise TypeError unless (options[:with_guard].is_a? Symbol or options[:with_guard].nil?)
    guard = options[:guard]

    @production << {label: label, guard: guard} if label.is_a? Symbol
    if label.is_a? Array
      for place in label
        raise TypeError unless place.is_a? Symbol
        @production << {label: label, guard: guard}
      end
    end
  end

  def compile
    {
      label: @label,
      name: @name,
      consume: @consumption,
      produce: @production,
    }
  end
end
