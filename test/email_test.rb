#!/usr/bin/ruby -w
# -*- ruby -*-

require 'test/unit'
require_relative '../lib/fakir/email'

class EmailTest < Test::Unit::TestCase
  def run_email_test firstname, lastname, domain = nil
    dom = domain || "example.com"
    formats = Array.new
    formats << Regexp.new('john.smith@' + dom)
    formats << Regexp.new('jsmith@' + dom)
    formats << Regexp.new('jsmith\d+@' + dom)
    formats << Regexp.new('smithj@' + dom)
    formats << Regexp.new('smithj\d+@' + dom)
    
    100.times do 
      email = domain ? Fakir::EmailAddress.new(firstname, lastname, domain) : Fakir::EmailAddress.new(firstname, lastname)
      assert formats.find { |fmt| fmt.match(email) }, "email: #{email}"
    end
  end

  def test_default_domain_simple_name
    run_email_test "john", "smith"
  end

  def test_default_domain_uppercase_name
    run_email_test "John", "Smith"
  end

  def test_default_domain_non_alpha_characters
    run_email_test "Jo-hn", "S'mi.th"
  end

  def test_different_domain_simple_characters
    run_email_test "john", "smith", "foo.bar.com"
  end
end
