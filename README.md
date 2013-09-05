# developers.app.net

This branch (new-docs) of the appdotnet/api-spec repo contains the source for [developers.app.net](http://developers.app.net/) and replaces the docs located on the master branch.

This documentation can be compiled using [nanoc](http://nanoc.stoneship.org/).

All submissions are welcome. To submit a change, fork this repo, commit your changes, and send us a [pull request](http://help.github.com/send-pull-requests/).

## Building the docs

Ruby is required to build the site.

To install nanoc and make sure you have all the necessary ruby gems, open a terminal in the root of the api-spec checkout and run

    $ bundle install

To compile the docs for the first time, run

    $ bundle exec nanoc

Nanoc compiles the site into static files living in `./output`.

In general, the best way to work on the docs is like this:

    $ bundle exec nanoc view &
    $ bundle exec guard start

Guard will run and auto-generate new HTML output when you edit Markdown files, and the nanoc built-in webserver will be available on http://localhost:3000/

If you want to learn more about using nanoc, view the [nanoc documentation](http://nanoc.stoneship.org/docs/1-introduction/).
