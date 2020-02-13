class Petri::Net
  def initialize(options={}, &block)
    @places = []
    @transitions = []
    @start = nil
    @end = nil
    block.call(self)
  end

  def add_place(place, options={})
    entity = place if place.is_a? Petri::Place
    entity = Petri::Place.new(place, options)

    @places << entity unless @places.include?(entity)
    entity
  end

  def start_place(label, options={})
    place = add_place(label, options)
    @start = place.label
  end

  def end_place(label, options={})
    place = add_place(label, options)
    @end = place.label
  end

  def transition(label, options={}, &block)
    raise TypeError unless label.is_a? Symbol
    raise ArgumentError if @transitions.include? label
    @transitions << Petri::Transition.new(label, options, &block)
  end

  def compile
    {
      places: @places.map { |place| place.compile },
      transitions: @transitions.map { |transition| transition.compile },
      start_place: @start,
      end_place: @end,
    }
  end
end
