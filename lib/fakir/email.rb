#!/usr/bin/ruby -w
# -*- ruby -*-

require 'pathname'

module Fakir
  # Returns an email address based on the given name. By default, uses "example.com" as the domain,
  # to not use actual existing email accounts. Returns "simple" email addresses, i.e., without
  # valid-yet-rare characters, such as "very.unusual.@.unusual.com"@example.com (per
  # https://en.wikipedia.org/wiki/Email_address). The email address is downcased and non-word
  # characters are removed. Randomly, a trailing number is added. Thus the formats are:
  #  - john.smith@example.com
  #  - jsmith@example.com
  #  - jsmith24@example.com
  #  - smithj@example.com
  #  - smithj17@example.com

  class EmailAddress < String
    def initialize firstname, lastname, domain = "example.com"
      fname = firstname.gsub Regexp.new('[^\w]'), ''
      lname = lastname.gsub Regexp.new('[^\w]'), ''
      addr = case rand(3)
             when 0
               # "john.smith"
               fname + "." + lname
             when 1
               # "jsmith", "jsmith31"
               fname[0] + lname + make_number(0.50, 100).to_s
             when 2
               # "smithj", "smithj31"
               lname + fname[0] + make_number(0.30, 100).to_s
             end
        super addr.downcase + "@" + domain
    end

    def make_number possibility, max
      rand < possibility ? rand(max) : nil
    end
  end
end
