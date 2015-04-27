require 'minitest_helper'

class TestRunner < Minitest::Test
  def setup
    @runner = FlavorGem::Runner.new
  end

  test "should say funky_name is not in flavors" do
    name = "funky_name"
    all_flavors_name = FlavorGem::ALL_FLAVORS_NAME
    msg = "flavor should be one of the [#{all_flavors_name}], not #{name}\n"
    assert_output(msg) { @runner.generate name }
  end
end
