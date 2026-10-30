# README

Getting Started

This guide covers the steps required to set up and run the application locally.

# Requirements

- Ruby version: 3.3.5 +

- Rails version: 8.1.4

# System dependencies:

To retrieve weather forecasts based on a user's address or ZIP code, the application relies on two free, publicly available APIs:

Nominatim (OpenStreetMap) – Used to convert an address or ZIP code into geographic coordinates (latitude and longitude).

Open-Meteo – Uses those coordinates to retrieve the corresponding weather forecast for the current day.

I chose these services because they are free to use, publicly accessible, and do not require API keys, making them straightforward to integrate.

# Database Setup

- Database creation
  run: bin/rails db:create

- Database initialization
  run: bin/rails db:mibrate

# Running the Application

Start the development environment:
run: bin/dev

Once the application has started, it will be available at:

http://localhost:3000

# Running the Test Suite

To execute the test suite, run:
run: rspec

# Additional Notes and Considerations

For the sake of simplicity and to stay within the available development time, I implemented a basic address input form without autocomplete or location suggestions.

For a production-ready version, I would consider integrating a service such as Google Places API. This would allow users to receive real-time location suggestions as they type, helping ensure that submitted addres

# AI-Assisted Development

The SVG icons used throughout the application were generated with the assistance of AI.
