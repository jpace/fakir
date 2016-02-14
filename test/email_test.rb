#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require_relative '../lib/fakir/email'

class EmailTest < Test::Unit::TestCase
  def test_default_domain_simple_name
    formats = Array.new
    formats << Regexp.new('john.smith@example.com')
    formats << Regexp.new('jsmith@example.com')
    formats << Regexp.new('jsmith\d+@example.com')
    formats << Regexp.new('smithj@example.com')
    formats << Regexp.new('smithj\d+@example.com')
    
    100.times do 
      firstname = "john"
      lastname = "smith"
      email = Fakir::EmailAddress.new firstname, lastname
      assert formats.find { |fmt| fmt.match(email) }
    end
  end
end
