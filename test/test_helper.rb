$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'kori'
require 'pry'
require 'pry-byebug'
require 'pry-doc'
require 'pry-power_assert'
require 'minitest/reporters'

Minitest::Reporters.use!

require 'minitest/autorun'
