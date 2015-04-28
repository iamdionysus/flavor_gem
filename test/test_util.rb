require 'minitest_helper'

class Mock < Thor
  include Thor::Actions
end

class TestUtil < Minitest::Test
  def setup
    @mock = Mock.new
    @test_file = "test/Rakefile"
    @test_template = "Rakefile"
  end
  test "sholud return all flavors in each type" do
    assert_kind_of Array, FlavorGem::ALL_FLAVORS
    assert_kind_of String, FlavorGem::ALL_FLAVORS_NAME
    all_flavors_name = FlavorGem::ALL_FLAVORS.join "|"
    assert_equal all_flavors_name, FlavorGem::ALL_FLAVORS_NAME
  end

  test "should return file_has_template?" do
    refute @mock.file_has_template?("lib/flavor_gem.rb", @test_template)
    assert @mock.file_has_template?(@test_file, @test_template)
    assert @mock.file_has_template?("test/minitest_helper.rb", "minitest_helper.rb")
  end

  test "appends template to file in each case" do
    not_append_when_file_exists_and_has_template    
    append_when_file_does_not_exist
    append_when_file_exists_but_no_template
  end

  def append_when_file_does_not_exist
    backup
    @mock.append_template_to_file "test/Rakefile", "Rakefile"
    assert @mock.file_has_template? "test/Rakefile", "Rakefile"
    restore
  end

  def append_when_file_exists_but_no_template
    backup
    File.open("test/Rakefile", "w") {}
    @mock.append_template_to_file "test/Rakefile", "Rakefile"
    assert @mock.file_has_template? "test/Rakefile", "Rakefile"
    restore
  end

  def not_append_when_file_exists_and_has_template
    refute @mock.append_template_to_file "test/Rakefile", "Rakefile"
    refute @mock.append_template_to_file "test/minitest_helper.rb", "minitest_helper.rb"    
  end

  def backup
    File.rename @test_file, "#{@test_file}.bak"
  end

  def restore
    File.rename "#{@test_file}.bak", @test_file
  end
end
