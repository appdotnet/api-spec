# developers.app.net

This branch (new-docs) of the appdotnet/api-spec repo contains the source for [developers.app.net](http://developers.app.net/) and replaces the docs located on the master branch.

This documentation can be compiled using [nanoc](http://nanoc.stoneship.org/). 

All submissions are welcome. To submit a change, fork this repo, commit your changes, and send us a [pull request](http://help.github.com/send-pull-requests/).

## Building the docs

Ruby 1.9 is required to build the site.

To install nanoc and make sure you have all the necessary ruby gems, open a terminal and run

    $ bundle install

To compile the docs, run

    $ nanoc

Nanoc compiles the site into static files living in `./output`.

Once the docs are compiled, you can view the result using the adsf web server which is part of the install bundle:

    $ nanoc view
    $ open http://localhost:3000

If you want to have nanoc autocompile your changes, run

    $ nanoc watch

If you want to learn more about using nanoc, view the [nanoc documentation](http://nanoc.stoneship.org/docs/1-introduction/).
