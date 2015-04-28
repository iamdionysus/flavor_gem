require "minitest_helper"

class FlavorGem::Minitest
  public :append_rakefile, :create_minitest_helper, :inject_minitest_gemspec
end

class TestMinitest < Minitest::Test
  def setup
    @minitest = FlavorGem::Minitest.new
  end

  test "should not append Rakefile when the minitest is already there" do
    msg = "minitest is already there in Rakefile\n"
    assert_output(msg) { @minitest.append_rakefile }
  end
  
  test "should append Rakefile" do
    # @minitest.append_rakefile
    # rakefile_to_add = File.read "lib/flavor_gem/template/Rakefile"
    # rakefile = File.read "Rakefile"
    # assert_match rakefile_to_add, rakefile
  end

  test "should generate minitest_helper.rb based on file existence" do
    original = "test/minitest_helper.rb"
    backup = "test/minitest_helper.rb.bak"
    template = "lib/flavor_gem/template/minitest_helper.rb"

    assert_when_minitest_does_not_exist original, backup, template
    assert_when_minitest_exists original, template
  end

  test "should generate gemspec based on minitest gem existence" do
    # TODO
    # assert_minitest_not_injected_when_it_exists    
    # assert_inject_minitest_when_it_does_not_exist
  end


  def assert_inject_minitest_when_it_does_not_exist
  end

  def assert_minitest_not_injected_when_it_exists
  end
  
  def assert_when_minitest_does_not_exist(original, backup, template)
    if File.exists? original
      File.rename original, backup
    end
    @minitest.create_minitest_helper
    assert File.exist?(original)
    assert_minitest_helper_match_template original, template
    # put it back
    File.rename backup, original
  end

  def assert_minitest_helper_match_template(minitest_helper, template)
    assert_match File.read(template), File.read(minitest_helper)
  end

  def assert_when_minitest_exists(original, template)
    if not File.exists?(original)
      @minitest.create_minitest_helper
    end
    @minitest.create_minitest_helper
    assert_minitest_helper_match_template original, template
    
    msg = "#{original} exists. Append to the file\n"
    assert_output(/#{msg}/) { @minitest.create_minitest_helper }
  end

end
