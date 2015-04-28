require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'flavor_gem'
require 'flavor_gem/runner'



# added by flavor-gem generate minitest
require 'minitest/autorun'

class Module
  def test(name, &block)
    define_method("test_#{name}", &block)
  end
end
# added by flavor-gem generate minitest
require 'minitest/autorun'

class Module
  def test(name, &block)
    define_method("test_#{name}", &block)
  end
end
