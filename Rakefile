require 'cucumber'
require 'cucumber/rake/task'
require 'fileutils'

Cucumber::Rake::Task.new :features do |t|
  t.cucumber_opts = 'features --format pretty'
end

task :build do
  sh 'stack build'
  FileUtils.cp `stack exec which private-values`.strip, 'bin', preserve: true
end

task test: [:features]
