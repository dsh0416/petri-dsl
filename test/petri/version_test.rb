require "test_helper"

class Petri::VersionTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Petri::VERSION
  end
end
