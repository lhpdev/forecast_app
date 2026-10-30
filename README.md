# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version: 3.3.5 +

- Rails version: 8.1.4

- System dependencies:

  In order to fetch a Forecast by zipcode/address I needed to rely on two different free APIs: one for grabbing the lat, and long from a informed
  address/zipcode (Nominatim API) and with that info in hands then I needed to call OpenMeteo to fetch its respective forecast for current day:

  Free Location Seach API: https://nominatim.openstreetmap.org
  Free Weather Forecast API search: https://open-meteo.com/

  I have decided to take use these APIs as both are public and do not require API key and very easy to work with.

- Database creation
  bin/rails db:create

- Database initialization
  bin/rails db:mibrate

- Configuration:
  Simply run: bin/dev

  It will start the server running on localhost:3000

- How to run the test suite
  rspec

- Considerations:
  For sake of time, I ended up using a simple form which didn't provide any address suggestion for users to select.
  An improvement I would do for a production version of this app would be integration a google places feature like where
  based on users input we would provide a suggested real location. This would avoid unecessary request for unrealistic places

  Additionally I asked AI to write the .svg icons to use in this application.
