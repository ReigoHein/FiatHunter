# FiatHunter

Ruby on Rails application for getting past currency rate movement and potentially predict future movement.

## System requirements

* Ruby 2.5.1
* Postgresql
* Rails 5

## Dependencies

To install dependencies, run in a terminal inside project directory:
	bundle install

Some gem's might need system dependencies, for example pg needs postgresql installed on the system.

## Configuration

Configure ```config/database.yml``` to use local/remote postgresql server.

If the connection should work, run the migrations:
	rails db:migrate

If you are running FiatHunter.API locally, be sure to edit the configuration for it, found at ```config/rate_history.yml```.

## Running the application

To run the application, run:
	rails server

If no errors occured, the application should start by default on port 3000.