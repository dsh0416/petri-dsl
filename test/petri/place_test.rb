require "test_helper"

class Petri::PlaceTest < Minitest::Test
  def test_place_eql
    assert_equal Petri::Place.new(:foo), Petri::Place.new(:foo)
    refute_equal Petri::Place.new(:foo), Petri::Place.new(:bar)
    assert_equal Petri::Place.new(:foo, name: 'test'), Petri::Place.new(:foo)
  end
end
