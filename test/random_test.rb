#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require_relative '../lib/fakir/random'

class RandomTest < Test::Unit::TestCase
  def run_window_test max, window
    rnd = Fakir::Random.new max, window
    nums = 20.times.collect { rnd.rand }
    puts "nums: #{nums}"
    nums.each_with_index do |num, idx|
      puts "num: #{num}"
      puts "idx: #{idx}"
      prev = nums[0 ... idx].rindex num
      puts "prev: #{prev}"
      if prev
        puts "idx - prev: #{idx - prev}"
        assert idx - prev >= window, "idx - prev: #{idx - prev}; window: #{window}"
      end
      puts ""
    end
  end

  def xtest_window_1
    run_window_test 3, 1
  end
  
  def xtest_window_2
    run_window_test 3, 2
  end

  def test_no_window
    run_window_test 3, nil
  end
  
  def xtest_invalid_window
    assert_raises RuntimeError, "window 10 should be less than maximum 10" do
      Fakir::Random.new 10, 10
    end
  end
end
