source "https://rubygems.org"

gem "rake", "~> 10.0"

group :development do
  gem "guard-rspec", require: false
  gem "wdm", ">= 0.1.0" if Gem.win_platform?
end

group :test do
  gem "rspec"
  gem "rubocop", require: false
  gem "coveralls", require: false
end

gemspec
