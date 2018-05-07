# Ruby on Rails Tutorial sample application

This is the sample application for
[*Ruby on Rails Tutorial:
Learn Web Development with Rails*](http://www.railstutorial.org/)
by [Michael Hartl](http://www.michaelhartl.com/).

## Advanced login
#### 1. Plan for persistent sessions
  1. Create random string of digits for use as a remember token
  2. Place the token in the browser cookies with long expiration
  3. Save the hash digest to db
  4. Place an encrypted version of user id in browser cookies
  5. When presented with a cookie containing user_id, find user in db => compare remember token cookie with associated hash digest from db


## TODO
#### Chap 10:
  1. Test for friendly forwarding only forward to the given URL the first time
  2. Integration test for all layout links (10.3.1)


## License

All source code in the [Ruby on Rails Tutorial](http://railstutorial.org/)
is available jointly under the MIT License and the Beerware License. See
[LICENSE.md](LICENSE.md) for details.

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

For more information, see the
[*Ruby on Rails Tutorial* book](http://www.railstutorial.org/book).