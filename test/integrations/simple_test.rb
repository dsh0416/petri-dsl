require "test_helper"

class Petri::IntegrationSimpleTest < Minitest::Test
  def setup
    @network = Petri::Net.new do |net|
      net.start_place :start, name: 'Start'
      net.end_place :end, name: 'End'

      net.transition :t1, consume: :start, produce: :p1
      net.transition :t2, consume: :p1, produce: :end
    end

    @compiled = @network.compile
  end

  def test_compiled
    assert_equal(@compiled, {
      places: [{label: :start, name: "Start"}, {label: :end, name: "End"}],
      transitions: [
        {label: :t1, name: "t1", consume: [:start], produce: [{label: :p1, guard: nil}]},
        {label: :t2, name: "t2", consume: [:p1], produce: [{label: :end, guard: nil}]}
      ],
      start_place: :start,
       end_place: :end,
    })
  end
end
