#!/usr/bin/ruby -w
# -*- ruby -*-

module Fakir
  # Extends the ::Array class to return random elements, where an element is returned only once.
  # +rand_reset+ resets the +rand+ method to return elements from the original array, i.e., to
  # possibly repeat elements from before +rand_reset+ was invoked.
  class Array < ::Array
    def initialize(*args)
      @used = ::Array.new
      rand_reset
      super
    end

    def rand_reset
      concat @used
      @used = ::Array.new
    end

    def rand
      if size == 0
        raise "error: cannot get random element from an empty array"
      end
      idx = Kernel::rand size
      val = delete_at idx
      @used << val
      val
    end
  end
end
