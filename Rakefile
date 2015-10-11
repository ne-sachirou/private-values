require 'cucumber'
require 'cucumber/rake/task'
require 'erubis'
require 'fileutils'

Cucumber::Rake::Task.new :features do |t|
  t.cucumber_opts = 'features --format pretty'
end

task :build do
  sh 'stack build'
  FileUtils.cp `stack exec which private-values`.strip, 'bin', preserve: true
  readme = Erubis::Eruby.new(File.read("#{__dir__}/src/README.md.erb", mode: 'r:utf-8')).result({
    help: File.read("#{__dir__}/src/Help.txt", mode: 'r:utf-8').strip,
  })
  File.open("#{__dir__}/README.md", 'w:utf-8'){|f| f.write readme }
end

task test: [:features]
