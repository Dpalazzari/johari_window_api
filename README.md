[![Build Status](https://travis-ci.org/Dpalazzari/johari_window_api.svg?branch=master)](https://travis-ci.org/Dpalazzari/johari_window_api)[![Code Climate](https://codeclimate.com/github/Dpalazzari/johari_window_api/badges/gpa.svg)](https://codeclimate.com/github/Dpalazzari/johari_window_api)

# Johari Window API

## Quick overview
This is a tool developed at the Turing School, based on the [Johari Window](https://en.wikipedia.org/wiki/Johari_window) Exercise developed in 1955 by Joseph Luft and Harrington Ingham. This particular portion of the app supplies an API and back-end database for the front-end [Johari Window Project.](https://github.com/lucyconklin/johari-window)

## Getting Started

To get this project running on your (mac) machine:

From the command line, in a directory of your choosing:

```
git clone git@github.com:Dpalazzari/johari_window_api.git
```

Install gems:

#### `bundle`

Create database, migrate the database, seed and load the schema with this line:

#### `rails db:{create,migrate,schema:load}`

To seed the database

#### `rails db:seed`

To run test suite:

#### `rspec`

start the server to test out the endpoints.

#### `rails s`

## API Endpoints
All responses are in JSON.

#### [`GET /adjectives`](http://johariwindowapi.herokuapp.com/api/v1/adjectives)
This request will return a list of 56 adjectives as described by the original Johari Window. The response will look like this:
```
[
  "able",
  "accepting",
  ...
  "wise",
  "witty"
]
```
#### [`GET /:id/assignments`](http://johariwindowapi.herokuapp.com/api/v1/users/1/assignments)
For a given user id, this request will return the names and ids of people to be described. The format will look something like this:
```
[
  {
    user: {
        id: 70,
        name: "Rodrik Ryswell"
          },
    completed?: true
  },
  {
    user: {
        id: 119,
        name: "Jeyne Westerling"
          },
    completed?: false
  }
]
```
#### `POST /:id/descriptions`
For a given user id, this request will create descriptions for the user. The response body will contain a status of 204 if the POST is successful, and a 304 if the POST fails.

JSON objects need to be posted to the API in this format:

```
 { 
  :johari => ["religious", "shy", "able", "self-assertive"], 
  :describer_id => 2
 }
```

## Development Environment

## Production Environment

## Customization
The seed file can be found in `/db/seeds.rb`. We made use of one of our favorite gems here: [Faker](https://github.com/stympy/faker). Check out the docs to see other possibilities and seed your own custom data for your test environment.

## Common Issues

## Going Forward
