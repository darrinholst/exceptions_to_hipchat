# ExceptionsToHipchat

Sends exceptions to HipChat

## Installation

Add this line to your application's Gemfile:

    gem 'exceptions_to_hipchat'

## Usage

Rails 3: add as rack middleware to `application.rb'

    config.middleware.use ExceptionsToHipchat::Notifier,
        :api_token => "YOUR TOKEN",
        :room => "YOUR ROOM",
        :user => "USER MESSAGE WILL COME FROM (MAX 15 CHARACTERS)",
        :notify => Rails.env.production?

