# frozen_string_literal: true

require 'cucumber'
require 'cucumber/rake/task'
require 'erubis'
require 'fileutils'
require 'rubocop/rake_task'

Cucumber::Rake::Task.new :features do |t|
  t.cucumber_opts = 'features --format pretty'
end

RuboCop::RakeTask.new

desc 'Build this project'
task :build do
  readme = Erubis::Eruby.new(File.read("#{__dir__}/src/README.md.erb", mode: 'r:utf-8')).result(
    help: File.read("#{__dir__}/src/Help.txt", mode: 'r:utf-8').strip
  )
  File.open("#{__dir__}/README.md", 'w:utf-8') { |f| f.write readme }
  puts 'README.md has built.'
  sh 'stack build'
  FileUtils.mkdir 'bin' unless File.exist? 'bin'
  FileUtils.cp `stack exec which private-values`.chomp, 'bin/', preserve: true
end

desc 'Install bin'
task :install do
  FileUtils.cp 'bin/private-values', '/usr/local/bin/', preserve: true
end

desc 'Rus tests'
task test: %i[rubocop features] do
  sh 'stack test'
  sh 'stack exec hlint -- . -c'
end

desc 'Update deps'
task :update do
  sh 'bundle update'
  puts 'Update Haskell (stack/cabal) dependencies manually!'
end
