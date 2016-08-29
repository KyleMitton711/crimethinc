# Magazine, A CrimethInc. production

Ruby on Rails app that powers http://crimethinc.com


## Development

### tl;dr

```
git clone https://github.com/CrimethIncDotCom/magazine.git
cd magazine
./script/bootstrap
./script/setup
./script/server
```

## Development Scripts

Magazine uses the [Scripts to Rule Them All](http://githubengineering.com/scripts-to-rule-them-all) pattern.
See also: https://github.com/github/scripts-to-rule-them-all

`/script` is a collection of scripts for development on an OS X / macOS computer.
Development setup on a Windows or Linux computer may vary.

All of the scripts assume that you already have installed:

- [Homebrew](http://brew.sh)
- Xcode command line tools

### Bootstrap script

The `bootstrap` script is the first time development environment configuration for this app.
You should only need to run this script once.
It will install the proper Ruby and Postgresql database versions.

Clone this repo.

```
git clone https://github.com/CrimethIncDotCom/magazine.git
cd magazine
```

Then run the `bootstrap` script.

```
./script/bootstrap
```

If that fails for you, [file an issue](https://github.com/CrimethIncDotCom/magazine/issues)
with as much detail about your setup and any errors you got from the script.

### Setup script

After you've `bootstrap`ed, you'll need to `setup`.
The `setup` setups the Rails environment (creates, migrates and seeds databases, then clears logs and tmp).

```
./script/setup
```

### Server script

The `server` script starts the Rails server on port `3000`
(using **Foreman** which uses the `Procile` which uses **Puma**.)

```
./script/setup
```

### Update script

Periodically, you can run the `update` script to check for new versions of dependencies and to update the database schema. If you ever get a `PendingMigrationError`, run this script to migrate your database.

```
./script/update
```

### Test script

Run the test suite using the `test` script.

```
./script/test
```

### Console script

If you need to use the app's console (in any environment), use the `console` script.

```
./script/console
```

If you need to use the console on a remote instance fo the app, specific its enviorment name as the first argument.

```
./script/console production
```

Or

```
./script/console staging
```

### CI Build script

Setup environment for CI to run tests. This is primarily designed to run on the continuous integration server.

```
./script/cibuild
```


## Deploy to Heroku

Click this button to easily deploy to Heroku. (You must have a Heroku account.)

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)


## Authors

* Shane Becker / [@veganstraightedge](https://github.com/veganstraightedge)
* ( add yourself )


## Contributing

See [CONTRIBUTING.md](https://github.com/CrimethIncDotCom/magazine/blob/master/CONTRIBUTING.md).

If you find bugs, have feature requests or questions, please
[file an issue](https://github.com/CrimethIncDotCom/magazine/issues).


## Code of Conduct

Everyone interacting in the CrimethInc.'s project's codebases, issue trackers, chat rooms, and mailing lists is expected to follow the
[CrimethInc. development code of conduct](https://github.com/CrimethIncDotCom/magazine/blob/master/CODE_OF_CONDUCT.md).


## License

**PUBLIC DOMAIN**

Your heart is as free as the air you breathe. <br>
The ground you stand on is liberated territory.

In legal text, **Magazine, A CrimethInc. production** is dedicated to the public domain
using Creative Commons -- CC0 1.0 Universal.

[http://creativecommons.org/publicdomain/zero/1.0](http://creativecommons.org/publicdomain/zero/1.0 "Creative Commons &mdash; CC0 1.0 Universal")
