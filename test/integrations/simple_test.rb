require "test_helper"

class Petri::IntegrationSimpleTest < Minitest::Test
  def setup
    @network = Petri::Net.new do |net|
      net.start_place :start
      net.end_place :end

      net.transition :t1, consume: :start, produce: :p1
      net.transition :t2, consume: :p1, produce: :end
    end

    @compiled = @network.compile
  end

  def test_start_and_end
    assert_equal @compiled[:start_place], :start
  end
end
