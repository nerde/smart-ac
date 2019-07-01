# frozen_string_literal: true

Given("I am authenticated with {string} \/ {string}") do |email, password|
  visit new_user_session_path

  fill_in 'Email', with: email
  fill_in 'Password', with: password

  click_on 'Sign In'
end
