#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require_relative '../lib/fakir'

class VersionTest < Test::Unit::TestCase
  def test_version
    assert_equal "0.0.1", Fakir::VERSION
  end
end
