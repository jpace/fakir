#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require_relative '../lib/fakir/array'

class ArrayTest < Test::Unit::TestCase
  def test_within_data_limit
    ary = %w{ this is a test }
    puts "ary: #{ary}"
    fary = Fakir::Array.new ary
    rands = 4.times.collect { |n| fary.rand }
    puts "rands: #{rands}"
    assert_equal ary.sort, rands.sort
  end

  def test_over_data_limit
    ary = %w{ this is a test }
    fary = Fakir::Array.new ary
    rands = 4.times.collect { |n| fary.rand }
    puts "rands: #{rands}"
    assert_raises RuntimeError, "array is empty" do
      fary.rand
    end
  end

  def test_reset_at_data_limit
    ary = %w{ this is a test }
    fary = Fakir::Array.new ary
    rands = 4.times.collect { |n| fary.rand }
    fary.rand_reset
    rands = 4.times.collect { |n| fary.rand }
    fary.rand_reset
    rands = 4.times.collect { |n| fary.rand }
  end
end
