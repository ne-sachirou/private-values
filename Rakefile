require 'cucumber'
require 'cucumber/rake/task'
require 'erubis'
require 'fileutils'

Cucumber::Rake::Task.new :features do |t|
  t.cucumber_opts = 'features --format pretty'
end

task :build do
  readme = Erubis::Eruby.new(File.read("#{__dir__}/src/README.md.erb", mode: 'r:utf-8')).result({
    help: File.read("#{__dir__}/src/Help.txt", mode: 'r:utf-8').strip,
  })
  File.open("#{__dir__}/README.md", 'w:utf-8'){|f| f.write readme }
  sh 'hlint . -c'
  sh 'stack build -j4'
  FileUtils.mkdir 'bin' unless File.exist? 'bin'
  FileUtils.cp `stack exec which private-values`.strip, 'bin', preserve: true
end

task test: [:features]
