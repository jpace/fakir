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
      formats = Array.new
      formats << "%s.%s"
      formats << "%.1s%s"
      formats << "%2$s%1$.1s"
      formats << "%.1s%s%d"
      formats << "%2$s%1$.1s%3$d"
      
      formats.collect! { |fmt| fmt + "@" + domain }

      fname = clean_word firstname
      lname = clean_word lastname
      fidx = rand(formats.size)
      format = formats[fidx]
      args = [ fname, lname ]
      if format.count("%") >= 3
        args << rand(100)
      end
      addr = sprintf format, *args
      super addr
    end

    def clean_word str
      str.gsub(Regexp.new('[^\w]'), '').downcase
    end
  end
end
