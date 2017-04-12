[![Build Status](https://travis-ci.org/Dpalazzari/johari_window_api.svg?branch=master)](https://travis-ci.org/Dpalazzari/johari_window_api)[![Code Climate](https://codeclimate.com/github/Dpalazzari/johari_window_api/badges/gpa.svg)](https://codeclimate.com/github/Dpalazzari/johari_window_api)

# Johari Window API

## Quick overview
This is a tool developed at the Turing School, based on the [Johari Window](https://en.wikipedia.org/wiki/Johari_window) Exercise developed in 1955 by Joseph Luft and Harrington Ingham. This particular portion of the app supplies an API and back-end database for the front-end [Johari Window Project.](https://github.com/lucyconklin/johari-window)

The production site can be located by clicking [here.](https://johariwindowapi.herokuapp.com/)

## Getting Started in Development Environment

To get this project running on your (mac) machine:

From the command line, in a directory of your choosing:

```
git clone git@github.com:Dpalazzari/johari_window_api.git
```

Install gems:

#### `bundle`

Create database, migrate the database, seed and load the schema with this line:

Required environmental variables:

#### `figaro install`

Then copy and paste `application.sample.yml` into `application.yml` and fill in environment variables with their correct values. Contact developers to get access to environment variables.

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
```javascript
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
```javascript
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

#### [`GET /users/:id`](http://johariwindowapi.herokuapp.com/api/v1/users/1)
For a given user id, this request will return the name, id, created_at, and updated_at for a given user. 

```javascript
{
  id: 1,
  name: "Mebble",
  created_at: "2017-03-29T00:37:58.779Z",
  updated_at: "2017-03-29T00:37:58.779Z"
}
```

#### `POST /:id/descriptions`
For a given user id, this request will create descriptions for the user. The response body will contain a status of 204 if the POST is successful, and a 304 if the POST fails.

JSON objects need to be posted to the API in this format:

```javascript
 { 
  :johari => ["religious", "shy", "able", "self-assertive"], 
  :describer_id => 2
 }
```

#### `POST /assignments`
For given groups of users, this request will create unique assignments between each pair of users (as long as there is not an open assignment between them).

JSON objects need to be posted to the API in this format:

```javascript
 { 
  group:   [
              [ {name: 'Drew', id: 0}, {name: 'Kyle', id: 1} ],
              [ {name: 'Lucy', id: 2}, {name: 'Annie', id: 3} ],
              [ {name: 'Drew', id: 0}, {name: 'Amy', id: 4}, {name: 'Kyle', id: 1} ]
            ] 
 }
```

#### `POST /users`

To create a user through our API, make a post request to this endpoint with the following JSON:

```javascript
  { 
    name: 'Drew', 
    github: 'Dpalazzari', 
    token: 'KLDShglskhg324235msfn'
  }
```
#### `GET /cohorts`

This will return JSON of all available cohorts.

```javascript
  [
    {"id"=>1, "name"=>"1610backend", "created_at"=>"2017-04-05", "updated_at"=>"2017-04-05},
    {"id"=>2, "name"=>"1610frontend", "created_at"=>"2017-04-05", "updated_at"=>"2017-04-05}
  ]
```

#### `GET /cohorts/:cohort_id/users`

For a given cohort, this endpoint will return JSON of all the users that belong to the cohort.

```javascript
  [
    {
      "id"=>1, "name"=>"Drew", "created_at"=>"2017-04-05", "updated_at"=>"2017-04-05", "cohort_id"=>11
    },
    {
      "id"=>2, "name"=>"Kyle", "created_at"=>"2017-04-05", "updated_at"=>"2017-04-05", "cohort_id"=>1
    }
  ]
```

#### `GET /users/by_github?name=:name`

For a given github username, this endpoint will return JSON of a matching user.

```javascript
  {
    "id"=>1, "name"=>"Drew", "github: "Dpalazzari", created_at"=>"2017-04-05", "updated_at"=>"2017-04-05", "cohort_id"=>11
  }
```

## Production Environment

Any server in production environment will need to compensate for CORS. Gem `gem 'rack-cors' ` in the gemfile adds a cors.rb file to config/initializers. 

Also, Your app will need an access_token from [Turing's Census App.](https://github.com/turingschool-projects/census)

## Customization
The seed file can be found in `/db/seeds.rb`. We made use of one of our favorite gems here: [Faker](https://github.com/stympy/faker). Check out the docs to see other possibilities and seed your own custom data for your test environment.

## Going Forward

- Our Johari Window API will pull all Turing student data down from Census. The Johari Window React App will authenticate users through github, which will allow the front-end app to send a github username to the census API and find each student's user object from the database. Turing students will need to sign in through the react APP just once to be added to the API database.

- We want two rake tasks:
    - Rake task that updates students with the cohort they are in.
    - Rake Task that generates a new access_token from Census (which expires every 90 days).
    
- These two Rake Tasks should make it easier for [Allison](https://github.com/allisonreusinger) to use.

## Primary Contributors

- [Drew Palazzari](https://github.com/Dpalazzari)
- [Annie Wolff](https://github.com/wlffann)
- [Lucy Conklin](https://github.com/lucyconklin)
- [Kyle Heppenstall](https://github.com/kheppenstall)
- [Amy Kintner](https://github.com/akintner)
