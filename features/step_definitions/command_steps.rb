# frozen_string_literal: true

require 'fileutils'

def on_wsl?
  File.exist?('/proc/sys/kernel/osrelease') && IO.read('/proc/sys/kernel/osrelease').include?('Microsoft')
end

Before do
  FileUtils.mkdir_p File.expand_path("#{__dir__}/../tmp")
end

After do
  # NOTE: `FileUtils.remove_entry_secure` cannot remove entries on WSL. So the tests should fail on WSL.
  FileUtils.rm_rf File.expand_path("#{__dir__}/../tmp"), secure: !on_wsl?
end

Given(/^run NEW command with an option "([^"]*)"$/) do |project|
  step %(I run `private-values new #{project}`)
end

Given(/^run RM command with an option "([^"]*)"$/) do |project|
  step %(I run `private-values rm #{project}`)
end

Given(/^run PROJECTS command/) do
  step %(I run `private-values projects`)
end

Given(/^run KEYS command with an option "([^"]*)"$/) do |project|
  step %(I run `private-values keys #{project}`)
end

Given(/^run SET command with options "([^"]*)" and "([^"]*)"$/) do |arg1, value|
  step %(I run `private-values set #{arg1} #{value}`)
end

Given(/^run GET command with an option "([^"]*)"$/) do |arg1|
  step %(I run `private-values get #{arg1}`)
end

Given(/^run PATH command with an option "([^"]*)"$/) do |project|
  step %(I run `private-values path #{project}`)
end

Given(/^using "([^"]*)" for a rc file$/) do |rc_file|
  FileUtils.cp "#{__dir__}/../../fixtures/#{rc_file}",
               "#{__dir__}/../tmp/private-values.rc",
               preserve: true
end

Given(/^a project named "([^"]*)"$/) do |project|
  step %(using "private-values.default.rc" for a rc file)
  step %(run NEW command with an option "#{project}")
end
