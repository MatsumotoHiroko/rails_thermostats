# IoT thermostats API (Ruby on Rails)
Simple IoT API using Ruby on Rails

# requirement
Ruby 2.4+
Rails 5.2+
Redis 5.0+

# data structure
## Thermostat
| key | data type | validation |
|---|---|---|
| id | auto increment |  |
| household_token | text | not null, max length=1000 |
| location | string  | not null, max length=500 |
## Reading
| key | data type | validation |
|---|---|---|
| thermostat_id | foreign key | not null |
| number | auto increment | scoped sequential for thermostat_id |
| temperature | float | not null |
| humidity | float | not null |
| battery_charge | float | not null |

# methods
| url | description | arguments | return |
|---|---|---|---|
| POST /thermostats/:thermostat_id/readings/ | adding Reading | temperature, humidity, battery_charge  | number |
| GET /thermostats/:thermostat_id/readings/:id | get specific Reading | none  | all Reading's columns |
| GET /thermostats/:id | get Reading's collect data | none | chilerens as Reading of Thermostat's average, max, min from temperature, humidity,battery_charge  |

# get started
## inserts seed data
```
$ rails db:seed
```
## rails server launch
```
$ rails s
```
## stands up redis and sidekiq
```
$ redis-server
$ sidekiq -q default reading
```

# test the application
This sample is used [HTTPie](https://httpie.org/)
## POST /thermostats/:thermostat_id/readings/
```
$ http POST :3000/thermostats/1/readings temperature=1.0 humidity:=1.0 "battery_charge":=1.0
HTTP/1.1 202 Accepted
{
    "number": 1
}
```
## GET /thermostats/:thermostat_id/readings/:id
```
$ http :3000/thermostats/1/readings/1
HTTP/1.1 200 OK
{
    "battery_charge": 1.0,
    "created_at": "2018-12-23T11:33:09.533Z",
    "humidity": 1.0,
    "id": 1,
    "number": 1,
    "temperature": 1.0,
    "thermostat_id": 1,
    "updated_at": "2018-12-23T11:33:09.533Z"
}
```
## GET /thermostats/:id
```
$ http :3000/thermostats/1
HTTP/1.1 200 OK
{
    "battery_charge": {
        "average": 2.0,
        "maximum": 3.0,
        "minimum": 1.0
    },
    "humidity": {
        "average": 1.5,
        "maximum": 2.0,
        "minimum": 1.0
    },
    "temperature": {
        "average": 1.5,
        "maximum": 2.0,
        "minimum": 1.0
    }
}
```