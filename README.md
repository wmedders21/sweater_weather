# Sweater Weather API

![ruby](https://img.shields.io/badge/Ruby-2.7.4-red)
![rails](https://img.shields.io/badge/Rails-5.2.8-red)

## Table of Contents
- [Background](#background)
- [Schema](#schema)
- [Endpoints](#endpoints)
- [Requirements](#requirements)
- [Setup](#setup)

## Background

**Sweater Weather API** consumes external API services and exposes endpoints for a weather application frontend. 

This Rails Api application is the final solo project during MOD 3 at [Turing School of Software and Design](https://www.turing.edu)

Implemented features include:
 - Basic authentication for user registration and login.
 - Issuing a required API key upon registration.
 - Search current, 5 day, and next 8 hours weather forecasts for a location in one call.
 - Find a relevant background image for a location
 - Plan a road trip between two locations. Receive estimated travel time and a weather report for the destination based on ETA.

The external services consumed are: 
 - OpenWeather One Call API
 - MapQuest Geocoding API
 - MapQuest Directions API
 - Microsoft Bing Image Search API  

## Database Schema

![image](https://user-images.githubusercontent.com/93014155/173714088-bd4ad818-6d9d-4ae2-b236-39bbb874fbd5.png)


## Endpoints

- Search weather forecast by location
```shell
GET /api/v1/forecast?location=atlanta,ga
```
---
```
  {
    "data": {
        "id": "null",
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2022-06-14T21:10:36.000-04:00",
                "sunrise": "2022-06-14T06:26:34.000-04:00",
                "sunset": "2022-06-14T20:49:16.000-04:00",
                "temperature": 85.06,
                "feels_like": 93.63,
                "humidity": 72,
                "uvi": 0,
                "visibility": 10000,
                "conditions": "scattered clouds",
                "icon": "03n"
            },
            "daily_weather": [
                {
                    "date": "2022-06-14",
                    "sunrise": "2022-06-14T06:26:34.000-04:00",
                    "sunset": "2022-06-14T20:49:16.000-04:00",
                    "max_temp": 97.09,
                    "min_temp": 79.11,
                    "conditions": "light rain",
                    "icon": "10d"
                },
                {...} etc (5 days total)
                ],
                
            "hourly_weather": [
                {
                    "time": "21:00:00",
                    "temperature": 85.06,
                    "conditions": "light rain",
                    "icon": "10n"
                },
               {...} etc (8 hours total)
            ]
        }
    }
}
```

- Find a background image for a location
```shell
GET /api/v1/backgrounds?location=atlanta,ga
```
---
```
{
    "data": {
        "id": "null",
        "type": "image",
        "attributes": {
            "image": {
                "name": "Atlanta, Georgia, USA Skyline | Legal Executive Institute",
                "image_url": "http://www.legalexecutiveinstitute.com/wp-content/uploads/2019/02/SEMA19-Image.jpeg",
                "credit": {
                    "source": "http://www.legalexecutiveinstitute.com/events/the-15th-annual-southeastern-ma-private-equity-forum/atlanta-georgia-usa-skyline/",
                    "author": "Legal Executive Institute",
                    "logo": "https://www.bing.com/th?id=ODF.Vr1XrhRx0qOyTZHcVP930Q&pid=Api"
                }
            }
        }
    }
}
```

- Register User
```shell
POST api/v1/users
Content-Type: application/json
Accept: application/json
body: {
  "email": "hello@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
---
```
{
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "hello@example.com",
            "api_key": "SOME API KEY"
        }
    }
}
```

- Login User
```shell
POST api/v1/sessions
Content-Type: application/json
Accept: application/json
body: {
  "email": "hello@example.com",
  "password": "password"
}
```
---
```
{
    "data": {
        "id": "1",
        "type": "users",
        "attributes": {
            "email": "hello@example.com",
            "api_key": "SOME API KEY"
        }
    }
}
```

- Road Trip
```shell
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json
body: {
  "origin": "Atlanta, GA",
  "destination": "Cincinnati, OH",
  "api_key": "SOME API KEY"
}
```
---
```
{
    "data": {
        "id": "null",
        "type": "roadtrip",
        "attributes": {
            "start_city": "Atlanta, GA",
            "end_city": "Cincinnati, OH",
            "travel_time": "7 hours, 4 minutes",
            "weather_at_eta": {
                "temperature": 74.3,
                "conditions": "clear sky"
            }
        }
    }
}
```

## Requirements

### API
[OpenWeather One Call API](https://openweathermap.org/api/one-call-api) follow instructions to get API key for v2.5.
[MapQuest Geocoding API](https://developer.mapquest.com/documentation/geocoding-api) follow instructions to get API key.
[MapQuest Directions API](https://developer.mapquest.com/documentation/directions-api) you only need the one key for MapQuest.
[Microsoft Bing Image Search](portal.azure.com) You need to set up a API key for Bing through Azure.


## Setup
1. Clone this repository on your local machine.

2. Install required Gems utilizing Bundler: <br>
- In terminal, use Bundler to install any missing Gems. If Bundler is not installed, first run the following command.
```shell
$ gem install bundler
```

- If Bundler is already installed or after it has been installed, run the following command.
```shell
$ bundle install
```

3. Database Migration<br>
- Before using the web application you will need to setup your databases locally by running the following command
```shell
$ rails db:{drop,create,migrate,seed}
```
4. Setup Figaro
```shell
$ bundle exec figaro install
```
- That will create an `config/application.yml` file.

- Add your api keys to new this new file.
```shell
#config/application.yml
mapquest_key: <your mapquest key here>
open_weather_key: <your open weather key here>
bing_images_key: <your azure key here>
```

5. Startup and Access<br>
- Finally, in order to use the web app you will have to start the server locally and access the app through a web browser.

- Start server
```shell
$ rails s
```

- Open Postman and [import this collection](https://github.com/wmedders21/sweater_weather/blob/main/Sweater%20Weather.postman_collection.json) to get started.
