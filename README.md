# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version: 3.3.5 +

- Rails version: 8.1.4

- System dependencies:
  Free Location Seach API: https://nominatim.openstreetmap.org
  Free Weather Forecast API search: https://open-meteo.com/

I have decided to take use these APIs as both are public and do not require API key

- Configuration:
  bin/dev
  It will start the server running on localhost:3000

- Database creation
  bin/rails db:create

- Database initialization
  bin/rails db:mibrate

- How to run the test suite
  rails rspec

- ...

# avenue_code_test

Take Home Assessment

Requirements:
● Must be done in Ruby on Rails
● Accept an address as input
● Retrieve forecast data for the given zip code. This should include, at minimum, the current temperature (Bonus points - Retrieve high/low and/or extended forecast)
● Display the requested forecast details to the user
● Cache the forecast details for 30 minutes for all subsequent requests by zip codes.
● Display an indicator if the result is pulled from cache.

Assumptions:
● This project is open to interpretation
● Functionality is a priority over form
● If you get stuck, complete as much as you can
Submission:
● Use a public source code repository (GitHub, etc) to store your code
● Send us the link to your completed code
