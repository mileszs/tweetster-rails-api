Use the first two sections of [this guide](https://gorails.com/setup/osx/10.13-high-sierra) for getting Ruby setup on your machine– _Installing Ruby_ and _Configuring Git_. Then run the following command to pull down this bare Rails API project to get started:

```
git clone git@github.com:mileszs/tweetster-rails-api.git
```

To get this up and running, run the following commands in order:

```
cd tweetster-rails-api
bundle install
bundle exec rake db:create db:migrate db:seed
bundle exec rails server
```

At this point, you should have the Rails server up and running on port `3000`. You're ready to get cracking!

Side note: I like [this tool called HTTPie](https://httpie.org/doc) to quickly test endpoints via the command line. If you already have a favorite, please do use your favorite! Otherwise, this one is pretty straightforward. :-)

If you are using HTTPie, and your server started, run `http localhost:3000/tweets` on the command line. You should receive a JSON response!
