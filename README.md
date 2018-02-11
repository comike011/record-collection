## Notes
The Spotify API key was intentionally included in this repository. Generally, this is bad practice, but felt acceptable for the purposes of app and its relative lack of sensitivity.

## Requirements
1. Install [Homebrew](brew.sh)
  ```
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  ```
2. Install [Postgres](http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/)
 + `brew install postgres`
 + Start Postgres: `postgres -D /usr/local/var/postgres`
 + In a new terminal tab, create a database: ``createdb `whoami` ``
 + Start a Postgres session: `psql`
 + Create user:
   ```
   CREATE ROLE record_collection superuser;
   ALTER ROLE record_collection WITH LOGIN;
   ```
 + Exit psql shell with ^D
 + Configure Postgres to auto start (if you want and are ona mac)
    ```
    mkdir -p ~/Library/LaunchAgents
    ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
    ```
3. Install [Redis](https://medium.com/@petehouston/install-and-config-redis-on-mac-os-x-via-homebrew-eb8df9a4f298#.z6qqkukv1)
 + `brew install redis`
 + Test your install: `redis-cli ping` (should result in PONG)
 + Set redis to autostart: `ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents` (if you want)
4. Set up the record colletion app
 + Set up git: https://help.github.com/articles/set-up-git/
 + Clone the [repo](https://github.com/comike011/record-collection)
5. Install `ruby` & `bundler` with [rbenv](https://cbednarski.com/articles/installing-ruby/)
 + `brew install rbenv`
 + `rbenv init`
 + Add the following to your .bash_profile or .zshenv
   ```
    export PATH="$HOME/.rbenv/bin:/usr/local/bin:$PATH"
    eval "$(rbenv init -)"
    ```
  + `source ~/.bash_profile` or `source ~/.zshenv`
  + Check the `Gemfile` for the current version of ruby and install it with rbenv
    ```
    rbenv install 2.4.3
    rbenv rehash
    rbenv global 2.4.3
    ```
  + From the root directory of your local repo, run `rbenv LOCAL 2.4.3`
  + Install bundler:
    ```
    gem install bundler
    rbenv rehash
    ```
## Running the app

+ Run bundler: `bundle install`
+ Create the database: `rake db:create:all`
+ Run the migrations: `rake db:migrate`
+ Run populate: `rake db:populate`
 + This will take a moment as it creates some smaple data for artists who had a lot of albums. Don't use this if you only want your own data.
+ Launch the application: `foreman start -p 3000`

## Access
+ Visit http://localhost:3000/

## Running the test suite
+ `rake db:test:prepare`
+ `rspec spec`

