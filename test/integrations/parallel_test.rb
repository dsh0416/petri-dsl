require "test_helper"

class Petri::IntegrationParallelTest < Minitest::Test
  def setup
    @network = Petri::Net.new do |net|
      net.start_place :start
      net.end_place :end

      net.transition :t1, consume: :start, produce: [:p1, :p2]
      net.transition :t2, consume: :p1, produce: :p3
      net.transition :t3, consume: :p2, produce: :p4
      net.transition :t4, consume: [:p3, :p4], produce: :end
    end
  end
end
