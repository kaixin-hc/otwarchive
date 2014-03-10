# Set up a new/unsaved gift exchange

Given /^I have set up the gift exchange "([^\"]*)" with name "([^\"]*)"$/ do |challengename, name|
  step %{I am logged in as "mod1"}
    step "I have standard challenge tags setup"
    step %{I set up the collection "#{challengename}" with name "#{name}"}
    step %{I select "Gift Exchange" from "challenge_type"}
  click_button("Submit")
end

Given /^I have set up the gift exchange "([^\"]*)"$/ do |challengename|
  step %{I have set up the gift exchange "#{challengename}" with name "#{challengename.gsub(/[^\w]/, '_')}"}
end

Then /^"([^\"]*)" gift exchange should be correctly created$/ do |title|
  step %{I should see "Collection was successfully created"}
  step %{I should see "Setting Up the #{title} Gift Exchange"}
  step %{I should see "Offer Settings"}
  step %{I should see "Request Settings"}
  step %{I should see "If you plan to use automated matching"} 
  step %{I should see "Allow Any"}
end

Then /^I should see gift exchange options$/ do
  step %{I should see "Offer Settings"}
    step %{I should see "Request Settings"}
    step %{I should see "If you plan to use automated matching"}
    step %{I should see "Allow Any"}
end

# Create and save a gift exchange with some common options

Given /^I have created the gift exchange "([^\"]*)" with name "([^\"]*)"$/ do |challengename, name|
  step %{I have set up the gift exchange "#{challengename}" with name "#{name}"}
  step "I fill in gift exchange challenge options"
    step "I submit"
  step %{I should see "Challenge was successfully created"}  
end

Given /^I have created the gift exchange "([^\"]*)"$/ do |challengename|
  step %{I have created the gift exchange "#{challengename}" with name "#{challengename.gsub(/[^\w]/, '_')}"}
end

When /^I fill in gift exchange challenge options$/ do
  current_date = DateTime.current
  fill_in("Sign-up opens", :with => "#{current_date.months_ago(2)}")
    fill_in("Sign-up closes", :with => "#{current_date.years_since(1)}")
    select("(GMT-05:00) Eastern Time (US & Canada)", :from => "gift_exchange_time_zone")
    fill_in("Tag Sets To Use:", :with => "Standard Challenge Tags")
    fill_in("gift_exchange_request_restriction_attributes_fandom_num_required", :with => "1")
    fill_in("gift_exchange_request_restriction_attributes_fandom_num_allowed", :with => "1")
    fill_in("gift_exchange_request_restriction_attributes_freeform_num_allowed", :with => "2")
    fill_in("gift_exchange_offer_restriction_attributes_fandom_num_required", :with => "1")
    fill_in("gift_exchange_offer_restriction_attributes_fandom_num_allowed", :with => "1")
    fill_in("gift_exchange_offer_restriction_attributes_freeform_num_allowed", :with => "2")
    select("1", :from => "gift_exchange_potential_match_settings_attributes_num_required_fandoms")
end

Then /^"([^\"]*)" gift exchange should be fully created$/ do |title|
  step %{I should see a create confirmation message}
  step %{"#{title}" collection exists}
  step %{I should see "(Open, Unmoderated, Gift Exchange Challenge)"}
end

## Signing up

When /^I sign up for "([^\"]*)" with combination A$/ do |title|
  step %{I start signing up for "#{title}"}
    step %{I check the 1st checkbox with the value "Stargate Atlantis"}
    step %{I check the 2nd checkbox with value "Stargate SG-1"}
    step %{I fill in the 1st field with id matching "freeform_tagnames" with "Alternate Universe - Historical"}
    step %{I fill in the 2nd field with id matching "freeform_tagnames" with "Alternate Universe - High School"}
    click_button "Submit"

end

When /^I sign up for "([^\"]*)" with combination B$/ do |title|
  step %{I start signing up for "#{title}"}
    step %{I check the 1st checkbox with value "Stargate SG-1"}
    step %{I check the 2nd checkbox with the value "Stargate Atlantis"}
    step %{I fill in the 1st field with id matching "freeform_tagnames" with "Alternate Universe - High School, Something else weird"}
    step %{I fill in the 2nd field with id matching "freeform_tagnames" with "Alternate Universe - High School"}
    click_button "Submit"
end

When /^I sign up for "([^\"]*)" with combination C$/ do |title|
  step %{I start signing up for "#{title}"}
    step %{I check the 1st checkbox with the value "Stargate SG-1"}
    step %{I check the 2nd checkbox with the value "Stargate SG-1"}
    step %{I fill in the 1st field with id matching "freeform_tagnames" with "Something else weird"}
    step %{I fill in the 2nd field with id matching "freeform_tagnames" with "Something else weird"}
    click_button "Submit"
end

When /^I sign up for "([^\"]*)" with combination D$/ do |title|
  step %{I start signing up for "#{title}"}
    step %{I check the 1st checkbox with the value "Stargate Atlantis"}
    step %{I check the 2nd checkbox with the value "Stargate Atlantis"}
    step %{I fill in the 1st field with id matching "freeform_tagnames" with "Something else weird, Alternate Universe - Historical"}
    step %{I fill in the 2nd field with id matching "freeform_tagnames" with "Something else weird, Alternate Universe - Historical"}
    click_button "Submit"
end

When /^I sign up for "([^\"]*)" with a mismatched combination$/ do |title|
  step %{I start signing up for "#{title}"}
    step %{I check the 1st checkbox with the value "Bad Choice"}
    step %{I check the 2nd checkbox with the value "Bad Choice"}
    click_button "Submit"
end
  

When /^I sign up for "([^\"]*)" with combination SGA$/ do |title|
  step %{I start signing up for "#{title}"}
    step %{I fill in "challenge_signup_requests_attributes_0_tag_set_attributes_fandom_tagnames" with "Stargate Atlantis"}
    fill_in("challenge_signup_requests_attributes_0_title", :with => "SGA love")
    click_button "Submit"
end

When /^I sign up for "([^\"]*)" with combination SG-1$/ do |title|
  step %{I start signing up for "#{title}"}
    step %{I fill in "challenge_signup_requests_attributes_0_tag_set_attributes_fandom_tagnames" with "Stargate SG-1"}
    fill_in("challenge_signup_requests_attributes_0_title", :with => "SG1 love")
    click_button "Submit"
end

When /^I sign up for "([^\"]*)" with missing prompts$/ do |title|
  step %{I start signing up for "#{title}"}
    step %{I check the 1st checkbox with the value "Stargate Atlantis"}
    step %{I fill in the 1st field with id matching "freeform_tagnames" with "Something else weird"}
    click_button "Submit"
end

When /^I start to sign up for "([^\"]*)"$/ do |title|
  step %{I start signing up for "#{title}"}
    step %{I check the 1st checkbox with value "Stargate SG-1"}
end

## Matching

Given /^everyone has signed up for the gift exchange "([^\"]*)"$/ do |challengename|
  step %{I am logged in as "myname1"}
  step %{I sign up for "#{challengename}" with combination A}
  step %{I am logged in as "myname2"}
  step %{I sign up for "#{challengename}" with combination B}
  step %{I am logged in as "myname3"}
  step %{I sign up for "#{challengename}" with combination C}
  step %{I am logged in as "myname4"}
  step %{I sign up for "#{challengename}" with combination D}
end

Given /^I have generated matches for "([^\"]*)"$/ do |challengename|
  step %{I close signups for "#{challengename}"}
  step %{I follow "Matching"}
  step %{I follow "Generate Potential Matches"}
  step %{the system processes jobs}
    step %{I wait 3 seconds}
  step %{I reload the page}
  step %{all emails have been delivered}
end

Given /^I have sent assignments for "([^\"]*)"$/ do |challengename|
  step %{I follow "Send Assignments"}
  step %{the system processes jobs}
    step %{I wait 3 seconds}
  step %{I reload the page}
  step %{I should not see "Assignments are now being sent out"}
end

### Fulfilling assignments

When /^I start to fulfill my assignment$/ do
  step %{I am on my user page}
  step %{I follow "Assignments ("}
  step %{I follow "Fulfill"}
    step %{I fill in "Work Title" with "Fulfilled Story"}
    step %{I select "Not Rated" from "Rating"}
    step %{I check "No Archive Warnings Apply"}
    step %{I fill in "Fandom" with "Final Fantasy X"}
    step %{I fill in "content" with "This is a really cool story about Final Fantasy X"}
end

When /^I fulfill my assignment$/ do
  step %{I start to fulfill my assignment}
  step %{I press "Preview"}
    step %{I press "Post"}
  step %{I should see "Work was successfully posted"}
end

### WHEN we need the author attribute to be set
When /^I fulfill my assignment and the author is "([^\"]*)"$/ do |new_user|
  step %{I start to fulfill my assignment}
    step %{I select "#{new_user}" from "Author / Pseud(s)"}
  step %{I press "Preview"}
    step %{I press "Post"}
  step %{I should see "Work was successfully posted"}
end



When /^I have set up matching for "([^\"]*)" with no required matching$/ do |challengename|
  step %{I am logged in as "mod1"}
  step %{I have created the gift exchange "Awesome Gift Exchange"}
  step %{I open signups for "Awesome Gift Exchange"}
  step %{everyone has signed up for the gift exchange "Awesome Gift Exchange"}
end

