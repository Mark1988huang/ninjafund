Given /^I am on the logon page$/ do
  visit '/logon'
end

Given /^the following users are registered?$/ do |table|
  table.hashes.each do |row|
    NinjaFund::Model::User.create :email => row['email'], :name => row['name'], :password => row['password']
  end
end

When /^I try and login with "([^\"]*)" and password "([^\"]*)"$/ do |username, password|
  fill_in 'username', :with => username
  fill_in 'password', :with => password
end

When /^I press Logon$/ do
  click_button "Log me in"
end

Then /^I should see my Dashboard$/ do
  current_path.should == '/'
end

Then /^I should see the Logon Page with an error$/ do
  current_path.should == '/logon'
  page.has_selector?('nNote nFailure')
end
