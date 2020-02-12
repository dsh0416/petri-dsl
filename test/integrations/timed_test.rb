require "test_helper"

class Petri::IntegrationTimedTest < Minitest::Test
  def setup
    @network = Petri::Net.new do |net|
      net.start_place :start
      net.end_place :end

      net.transition :t1, consume: :start, produce: :p
      net.transition :t2, consume: :p, produce: :end
      net.transition :t3, consume: :start, produce: :end
    end
  end
end
