require "minitest_helper"

class FlavorGem::Minitest
  public :append_rakefile, :create_minitest_helper, :inject_minitest_gemspec
end

class TestMinitest < Minitest::Test
  def setup
    @minitest = FlavorGem::Minitest.new
  end

  test "should respond to generate" do
    assert_respond_to @minitest, :generate
  end

  test "sholud not generate minitest_helper.rb file" do
    refute @minitest.create_minitest_helper
  end
end
