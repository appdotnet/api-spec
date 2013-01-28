---
title: "Token"
---

# Token

* TOC
{:toc}

## Retrieve current token

Returns info about the current [OAuth access token](/docs/authentication/#access-tokens). If the token is a user token the response will include a [User](/docs/resources/user/) object.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "token", "Any" %>

### Parameters

None.

### Example

Requested with an app access token:

> GET https://alpha-api.app.net/stream/0/token

~~~ js
{
    "data": {
        "app": {
            "client_id": "LHYCvdgDuUXndfCfyqABAtezCJjjsVM2",
            "link": "http://foo.example.com",
            "name": "Test app"
        },
        "client_id": "LHYCvdgDuUXndfCfyqABAtezCJjjsVM2",
        "scopes": []
    },
    "meta": {
        "code": 200
    }
}
~~~

Requested with a user access token:

> GET https://alpha-api.app.net/stream/0/token

~~~ js
{
    "data": {
        "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
        "app": {
            "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
            "link": "http://foo.example.com",
            "name": "Bryan's app for testing"
        },
        "scopes": [
            "stream",
            "messages",
            "export",
            "write_post",
            "follow",
            "email"
        ],
        "storage": {
            "available": 8787479688,
            "used": 1212520312
        },
        "user": {
            "id": "1", // note this is a string
            "username": "mthurman",
            "name": "Mark Thurman",
            "description": {
               "text": "Hi, I'm Mark Thurman and I'm teaching you about the @appdotnet Stream #API.",
               "html": "Hi, I'm Mark Thurman and I'm <a href=\"https://github.com/appdotnet/api_spec\" rel=\"nofollow\">teaching you</a> about the <span itemprop=\"mention\" data-mention-name=\"appdotnet\" data-mention-id=\"3\">@appdotnet</span> Stream #<span itemprop=\"hashtag\" data-hashtag-name=\"api\">API</span>.",
               "entities": {
                   "mentions": [{
                       "name": "appdotnet",
                       "id": "3",
                       "pos": 52,
                       "len": 10
                   }],
                   "hashtags": [{
                       "name": "api",
                       "pos": 70,
                       "len": 4
                   }],
                   "links": [{
                       "text": "teaching you",
                       "url": "https://github.com/appdotnet/api-spec",
                       "pos": 29,
                       "len": 12
                   }]
                }
            },
            "timezone": "US/Pacific",
            "locale": "en_US",
            "avatar_image": {
                "height": 512,
                "width": 512,
                "url": "https://example.com/avatar_image.jpg",
                "is_default": false
            },
            "cover_image": {
                "height": 118,
                "width": 320,
                "url": "https://example.com/cover_image.jpg",
                "is_default": false
            },
            "type": "human",
            "created_at": "2012-07-16T17:23:34Z",
            "counts": {
                "following": 100,
                "followers": 200,
                "posts": 24,
                "stars": 76
            },
            "follows_you": false,
            "you_follow": true,
            "you_muted": false,
        }
    },
    "meta": {
        "code": 200
    }
}
~~~

## Retrieve authorized User IDs for an app

Returns a list of ids of Users that have authorized an app. Must be requested using an [app access token](/docs/authentication/#access-tokens). 

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "apps/me/tokens/user_ids", "App" %>

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/apps/me/tokens/user_ids

~~~ js
{
    "data": [
        "2",
        "3",
        ...
    ],
    "meta": {
        "code": 200,
    }
}
~~~

## Retrieve authorized User tokens for an app

Returns a list of User tokens corresponding to an app token. Must be requested using an [app access token](/docs/authentication/#access-tokens). 

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "apps/me/tokens", "App" %>

### Parameters

*See [General Parameters](/docs/resources/post/#general-parameters) for optional parameters you can use with this query.*

### Example
> GET https://alpha-api.app.net/stream/0/apps/me/tokens

~~~ js
{
    "data": [
        {
            "app": {
                "client_id": "tHkLXfGusVxJ3NtyMYdyvQ9Rh4ZbeL5n",
                "link": "https://example.com",
                "name": "app"
            },
            "client_id": "tHkLXfGusVxJ3NtyMYdyvQ9Rh4ZbeL5n",
            "scopes": [
                "basic"
            ],
            "storage": { ... },
            "user": {...}
        },
        {
            "app": {
                "client_id": "tHkLXfGusVxJ3NtyMYdyvQ9Rh4ZbeL5n",
                "link": "https://example.com",
                "name": "app"
            },
            "client_id": "tHkLXfGusVxJ3NtyMYdyvQ9Rh4ZbeL5n",
            "scopes": [
                "update_profile",
                "messages",
                "basic"
            ],
            "storage": { ... },
            "user": {...}
        }
    ],
    "meta": {
        "code": 200,
        "max_id": "10723",
        "min_id": "10697",
        "more": false
    }
}
~~~