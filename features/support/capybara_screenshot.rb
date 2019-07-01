# frozen_string_literal: true

require 'capybara-screenshot/cucumber'
Capybara::Screenshot.prune_strategy = :keep_last_run
