require 'minitest_helper'

class TestUtil < Minitest::Test
  test "sholud return all flavors in each type" do
    assert_equal Array, FlavorGem::ALL_FLAVORS.class
    assert_equal String, FlavorGem::ALL_FLAVORS_NAME.class
    all_flavors_name = FlavorGem::ALL_FLAVORS.join "|"
    assert_equal all_flavors_name, FlavorGem::ALL_FLAVORS_NAME
  end
end
