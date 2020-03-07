# frozen_string_literal: true

require 'cucumber'
require 'cucumber/rake/task'
require 'erubis'
require 'fileutils'
require 'rubocop/rake_task'

def stack(options)
  stack_cmd = ['stack']
  stack_cmd << '--system-ghc' if system('which ghc') && system('which cabal')
  sh((stack_cmd + options).join(' '))
end

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
  stack %w[build]
  FileUtils.mkdir 'bin' unless File.exist? 'bin'
  FileUtils.cp `stack exec which private-values`.chomp, 'bin/', preserve: true
end

desc 'Format'
task format: [:"rubocop:auto_correct"] do
  sh 'npx prettier --write --parser markdown src/README.md.erb'
end

desc 'Install bin'
task :install do
  FileUtils.cp 'bin/private-values', '/usr/local/bin/', preserve: true
end

desc 'Rus tests'
task test: %i[rubocop features] do
  stack %w[test]
  stack %w[exec hlint -- . -c]
  sh 'yamllint .github/workflows/*.yml' if system('which yamllint')
end

desc 'Update deps'
task :update do
  sh 'bundle update'
  puts 'Update Haskell (stack/cabal) dependencies manually!'
end
