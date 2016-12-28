$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

if ENV['TRAVIS']
  begin
    require 'simplecov'
    SimpleCov.start
  rescue LoadError
  end
end

require 'kori'
require 'pry'
require 'pry-byebug'
require 'pry-doc'
require 'pry-power_assert'
require 'minitest/reporters'

Minitest::Reporters.use!

require 'minitest/autorun'
