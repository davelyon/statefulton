#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  ENV['SPEC_OPTS'] = "--format progress"
  spec.pattern = "spec/**/*_spec.rb"
end

task :default => [:spec]
