# Smart AC

Smart AC allows monitoring AC devices over time.

## API Endpoints

### `POST /devices`

Registers a new device. It returns an authentication token that allows the device to then send information for
monitoring.

Sample request body:

```json
{
  "name": "Sample Device",
  "serial_number": "12345",
  "firmware_version": "1.0"
}
```

Required fields:

* `serial_number`
* `firmware_version`

Sample successful response (status `201`):

```json
{
  "id": 1,
  "name": "Sample Device",
  "serial_number": "12345",
  "firmware_version": "1.0",
  "auth_token": "d3646be959da3ca215be13c683050f0d",
  "created_at": "2019-06-29T00:00:00.000-00:00"
}
```

Sample error response (status `422`):

```json
{
  "serial_number": ["can't be blank"],
  "firmware_version": ["can't be blank"]
}
```

Sample cURL command:

```
curl -X POST -d '{"name": "Sample Device", "serial_number": "12345", "firmware_version": "1.0"}' -H 'Content-Type: application/json' https://diego-smart-ac.herokuapp.com/devices
```

### `POST /device_snapshots`

Creates snapshots for a device. A snapshot is a set of information about a device at a given time.

It is required to provide the device's auth token as a request header, like: `Token: d3646be959da3ca215be13c683050f0d`

Sample request body (allows up to 500 entries):

```json
{
  "snapshots": [{
    "taken_at": "2019-06-29T00:00:00.000-00:00",
    "temperature_celsius": 25.53,
    "humidity_percentage": 43.32,
    "carbon_monoxide_ppm": 5.232,
    "status": "ok"
  }]
}
```

All fields are required.

Sample successful response (status `201`):

```json
[{
  "id": 1,
  "taken_at": "2019-06-29T00:00:00.000-00:00",
  "temperature_celsius": 25.53,
  "humidity_percentage": 43.32,
  "carbon_monoxide_ppm": 5.232,
  "status": "ok"
}]
```

Sample error response (status `422`):

```json
{
  "taken_at": ["can't be blank"],
  "temperature_celsius": ["can't be blank"],
  "humidity_percentage": ["can't be blank"],
  "carbon_monoxide_ppm": ["can't be blank"],
  "status": ["can't be blank"]
}
```

This endpoint returns status `404 - Not Found` if the token provided does not match any device.

It returns status `400 - Bad Request` if more than 500 items are sent at once.

Sample cURL command:

```
curl -X POST -H "Token: 502913748e00eaceb265d507c743c43e" -d '{"snapshots": [{"taken_at": "2019-06-29T00:00:00.000-00:00", "temperature_celsius": 25.53, "humidity_percentage": 43.32, "carbon_monoxide_ppm": 5.232, "status": "ok"}]}' -H 'Content-Type: application/json' https://diego-smart-ac.herokuapp.com/device_snapshots
```

## Web Admin

Default user/password is admin@smartac.com / 123456789 (make sure you run `rake db:seed`).

## Tests

This app is tested by using Cucumber. To run the test suite, simply call `bundle exec cucumber`.

## Things I would've done differently, given more time

* Split frontend and backend/api
  * Frontend in React
  * Backend in pure Rails API, Sinatra or even Go (team decision, I would vote for a Rails API)
* API documentation hosted by the app, probably built with Swagger
* Issue notifications would be live, either by using web sockets or by checking with backend every few minutes
* Test the graph queries with large amounts of data to make sure indexing is fine
* Consider a NoSQL solution for the database because of the volume of snapshots
  * Or dropping old data
