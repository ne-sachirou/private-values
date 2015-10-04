Given /^using "([^"]*)" for a rc file$/ do |rc_file|
  pending
end

Given /^run NEW command with an option "([^"]*)"$/ do |project|
  step %{I run `./private-values new #{project}`}
end
