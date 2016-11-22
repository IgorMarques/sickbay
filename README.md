# Sickbay
Get the HTTP status of a bunch of URLs in a single JSON response. Ideal of monitoring a lot of services at once.

[![Code Climate](https://codeclimate.com/github/IgorMarques/sickbay/badges/gpa.svg)](https://codeclimate.com/github/IgorMarques/sickbay)
[![Test Coverage](https://codeclimate.com/github/IgorMarques/sickbay/badges/coverage.svg)](https://codeclimate.com/github/IgorMarques/sickbay/coverage)

```shell
$ curl -X GET 'http://localhost:9292?google=http://www.google.com.br&bing=http://www.bing.com'
```

```json
{
  "google": "200",
  "bing": "200"
}
```

## Why?

This app can be very useful for healthchecking multiple applications at the same time.

The app is also easily deployable on heroku on any other service of your preference.

## Setup

Assuming you have a proper Ruby workspace setted up, just run:

```shell
$ git clone http://github.com/IgorMarques/sickbay
$ cd sickbay
$ bundle install
```

## Running the Server

Since this is a sinatra app, you just need to run:

```shell
$ rackup
```

The output should be something similar to:

```shell
[2016-11-22 20:10:13] INFO  WEBrick 1.3.1
[2016-11-22 20:10:13] INFO  ruby 2.3.0 (2015-12-25) [x86_64-darwin16]
[2016-11-22 20:10:13] INFO  WEBrick::HTTPServer#start: pid=3389 port=9292
```

Simple as that :)

## Using the App

Just send a `GET` request with the URLs you want to check as params. Each key of the param will be returned as a key of the response JSON:

```shell
$ curl -X GET 'http://localhost:9292?google=http://www.google.com.br&bing=http://www.bing.com'
```

```json
{
  "google": "200",
  "bing": "200"
}
```

Sending invalid or unreachable URLs will get a '0' as status:

```shell
$ curl -X GET 'http://localhost:9292?some_bad_url=this_is_not_a_real_url'
```
```json  
{
  "some_bad_url": "0"
}
```                    

## Testing

This app uses [Rspec](https://github.com/rspec/rspec) for testing. To run the test suit:

```shell
$ rspec
```

## Contributing

Just fork the app and send a pull-request! Improvements are welcome :)
