require "bundler/gem_tasks"
require 'fileutils'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new("test") do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.warning = true
  t.verbose = true
end
