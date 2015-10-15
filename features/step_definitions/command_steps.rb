require 'fileutils'

Before do
  FileUtils.mkdir_p "#{__dir__}/../tmp"
end

After do
  FileUtils.rm_rf "#{__dir__}/../tmp", secure: true
end

Given /^run NEW command with an option "([^"]*)"$/ do |project|
  step %{I run `private-values new #{project}`}
end

Given /^run RM command with an option "([^"]*)"$/ do |project|
  step %{I run `private-values rm #{project}`}
end

Given /^run SET command with options "([^"]*)" and "([^"]*)"$/ do |arg1, value|
  step %{I run `private-values set #{arg1} #{value}`}
end

Given /^run GET command with no options/ do
  step %{I run `private-values get`}
end

Given /^run GET command with an option "([^"]*)"$/ do |arg1|
  step %{I run `private-values get #{arg1}`}
end

Given /^run PATH command with an option "([^"]*)"$/ do |project|
  step %{I run `private-values path #{project}`}
end

Given /^using "([^"]*)" for a rc file$/ do |rc_file|
  FileUtils.cp "#{__dir__}/../../fixtures/#{rc_file}",
               "#{__dir__}/../tmp/private-values.rc",
               preserve: true
end

Given /^a project named "([^"]*)"$/ do |project|
  step %{using "private-values.default.rc" for a rc file}
  step %{run NEW command with an option "#{project}"}
end
