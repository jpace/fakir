#!/usr/bin/ruby -w
# -*- ruby -*-

module Fakir
  # Returns not-quite-random numbers: if +window+ is nil, then an instance will never return the
  # same number. If +window+ is an integer N, then a random number will not be returned within N
  # invocations of +rand+. Thus with +window+ == 2, the same number won't be returned twice in a
  # row. If +number+ is 5, then the same number will not be returned within 5 subsequent invocations
  # of +rand+ times than +max+. If +number+ is 1, then the number can be repeated subsequently.
  class Random
    def initialize max, window = nil
      raise "window #{window} should be less than maximum #{max}" if window && window >= max
      @used = Array.new
      @max = max
      @window = window
    end

    def rand
      iters = 0
      while iters < @max ** 4
        num = Kernel::rand @max
        if @used.include?(num)
          iters += 1
        else
          @used << num
          if @window
            @used = @used.drop [ @used.length - @window + 1, 0 ].max
          end
          return num
        end
      end
      nil
    end
  end
end
