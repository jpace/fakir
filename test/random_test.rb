#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require_relative '../lib/fakir/random'

class RandomTest < Test::Unit::TestCase
  def assert_not_in_window nums, num, idx, window
    if num
      prev = nums[0 ... idx].rindex num
      if prev
        assert_not_nil window, "prev: #{prev}"
        diff = idx - prev
        assert diff >= window, "diff: #{diff}; window: #{window}"
      end
    end
  end

  def run_window_test max, window
    rnd = Fakir::Random.new max, window
    nums = 20.times.collect { rnd.rand }
    puts "nums: #{nums}"
    nums.each_with_index do |num, idx|
      assert_not_in_window nums, num, idx, window
    end
  end

  def test_window_1
    run_window_test 3, 1
  end
  
  def test_window_2
    run_window_test 3, 2
  end

  def test_no_window
    run_window_test 3, nil
  end
  
  def test_invalid_window
    assert_raises RuntimeError, "window 10 should be less than maximum 10" do
      Fakir::Random.new 10, 10
    end
  end
end
