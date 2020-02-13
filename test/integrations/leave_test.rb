require "test_helper"

class Petri::IntegrationLeaveTest < Minitest::Test
  def setup
    @network = Petri::Net.new do |net|
      net.start_place :start, name: 'Start'
      net.end_place :end, name: 'End'

      net.transition :leader_evaluate, name: 'Leader Evaluate', consume: :start do |t|
        t.produce :leader_approved, name: 'Leader Approved', with_guard: :approved
        t.produce :rejected, name: 'Rejected', with_guard: :rejected
      end

      net.transition :hr_evaluate, consume: :leader_approved do |t|
        t.produce :hr_approved, with_guard: :approved
        t.produce :rejected, with_guard: :rejected
      end

      net.transition :report_back, consume: :hr_approved, produce: :end

      net.transition :resend_request, consume: :rejected do |t|
        t.produce :start, with_guard: :resend
        t.produce :end, with_guard: :discard
      end
    end

    @compiled = @network.compile
  end

  def test_compiled
  end
end
