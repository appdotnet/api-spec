---
title: "Create a Post"
---

# Creating a Post via the API

<%= access_token_required_note %>

A [Post](/reference/resources/post) is the microblogging primitive of the App.net API. When a user creates a post, it appears in all of their follower's streams. Posts can have images, links, and annotations but at their simplest, they just contain a piece of text.

* TOC
{:toc}

## Create a post

The easiest way to create a post is to use [one of the API libraries](/docs/libraries).

Using [adnpy](/docs/libraries#python)
~~~ python
import adnpy

# Set the default access token for API calls.
adnpy.api.add_authorization_token('your access token here')

# Create a post
post = adnpy.api.create_post(data={'text':'Hello App.net from Python!'})
~~~

Or with the [adn](/docs/libraries#ruby) Ruby gem:

~~~ ruby
require 'adn'

ADN.token = 'your access token here'
post = ADN::Post.send_post(:text => "Hello App.net from Ruby!")
~~~

If you want to send the equivalent broadcast from the API without using a library, use this curl command:

~~~ sh
curl -X POST -H "Authorization: Bearer <YOUR ACCESS TOKEN>" \
    -H "X-adn-pretty-json: 1" -H "Content-Type: application/json" \
    --data-ascii '{
      "text": "Hello App.net from curl!",
    }' \
    \
    'https://alpha-api.app.net/stream/0/posts'
~~~
