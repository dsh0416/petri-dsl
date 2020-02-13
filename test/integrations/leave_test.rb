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

      net.transition :hr_evaluate, name: 'HR Evaluate', consume: :leader_approved do |t|
        t.produce :hr_approved, name: 'HR Approved', with_guard: :approved
        t.produce :rejected, with_guard: :rejected
      end

      net.transition :report_back, name: 'Report Back', consume: :hr_approved, produce: :end

      net.transition :resend_request, name: 'Resend Request', consume: :rejected do |t|
        t.produce :start, with_guard: :resend
        t.produce :end, with_guard: :discard
      end
    end

    @compiled = @network.compile
  end

  def test_compiled
    assert_equal(@compiled, {
      places: [
        {label: :start, name: "Start"},
        {label: :end, name: "End"},
        {label: :leader_approved, name: "Leader Approved"},
        {label: :rejected, name: "Rejected"},
        {label: :hr_approved, name: "HR Approved"}
      ],
      transitions: [
        {label: :leader_evaluate, name: "Leader Evaluate", consume: [:start], produce: [{label: :leader_approved, guard: :approved}, {label: :rejected, guard: :rejected}]},
        {label: :hr_evaluate, name: "HR Evaluate", consume: [:leader_approved], produce: [{label: :hr_approved, guard: :approved}, {label: :rejected, guard: :rejected}]},
        {label: :report_back, name: "Report Back", consume: [:hr_approved], produce: [{label: :end, guard: nil}]},
        {label: :resend_request, name: "Resend Request", consume: [:rejected], produce: [{label: :start, guard: :resend}, {label: :end, guard: :discard}]}],
      start_place: :start,
      end_place: :end})
  end
end
