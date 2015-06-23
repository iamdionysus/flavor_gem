# added by "flavor-gem generate minitest"
require "minitest/autorun"

class Module
  def test(name, &block)
    define_method("test_#{name}", &block)
  end
end
