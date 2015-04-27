require 'minitest_helper'

class TestUtil < Minitest::Test
  test "sholud return all flavors in each type" do
    assert_kind_of Array, FlavorGem::ALL_FLAVORS
    assert_kind_of String, FlavorGem::ALL_FLAVORS_NAME
    all_flavors_name = FlavorGem::ALL_FLAVORS.join "|"
    assert_equal all_flavors_name, FlavorGem::ALL_FLAVORS_NAME
  end
end
