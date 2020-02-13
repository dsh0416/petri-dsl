# Petri::Dsl

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'petri-dsl'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install petri-dsl

## Usage

```ruby
require 'petri'

network = Petri::Net.new do |net|
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

puts network.compile

# {:places=>[{:label=>:start, :name=>"Start"}, {:label=>:end, :name=>"End"}, {:label=>:leader_approved, :name=>"Leader Approved"}, {:label=>:rejected, :name=>"Rejected"}, {:label=>:hr_approved, :name=>"HR Approved"}], :transitions=>[{:label=>:leader_evaluate, :name=>"Leader Evaluate", :consume=>[:start], :produce=>[{:label=>:leader_approved, :guard=>:approved}, {:label=>:rejected, :guard=>:rejected}]}, {:label=>:hr_evaluate, :name=>"HR Evaluate", :consume=>[:leader_approved], :produce=>[{:label=>:hr_approved, :guard=>:approved}, {:label=>:rejected, :guard=>:rejected}]}, {:label=>:report_back, :name=>"Report Back", :consume=>[:hr_approved], :produce=>[{:label=>:end, :guard=>nil}]}, {:label=>:resend_request, :name=>"Resend Request", :consume=>[:rejected], :produce=>[{:label=>:start, :guard=>:resend}, {:label=>:end, :guard=>:discard}]}], :start_place=>:start, :end_place=>:end}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/petri-dsl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/petri-dsl/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Petri::Dsl project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/petri-dsl/blob/master/CODE_OF_CONDUCT.md).
