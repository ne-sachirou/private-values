require 'fileutils'

Before do
  FileUtils.mkdir_p "#{__dir__}/../tmp"
end

After do
  FileUtils.rm_rf "#{__dir__}/../tmp", secure: true
end

Given /^using "([^"]*)" for a rc file$/ do |rc_file|
  FileUtils.cp "#{__dir__}/../../fixtures/#{rc_file}",
               "#{__dir__}/../tmp/private-values.rc",
               preserve: true
end

Given /^run NEW command with an option "([^"]*)"$/ do |project|
  step %{I run `private-values new #{project}`}
end
