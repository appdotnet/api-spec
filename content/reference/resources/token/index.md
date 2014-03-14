---
title: "Token"
---

# Token

* TOC
{:toc}

## Retrieve current token

Returns info about the current [OAuth access token](/reference/authentication/#access-tokens). If the token is a user token the response will include a [User](/reference/resources/user/) object.

<%= endpoint "GET", "token", "Any" %>

#### Example (App Token)

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

<br>

#### Example (User Token)

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
            "follow"
        ],
        "limits": {
            "following": 40,
            "max_file_size": 10000000
        },
        "storage": {
            "available": 8787479688,
            "used": 1212520312
        },
        "user": {
            "id": "1", // note this is a string
            ...
        },
        "invite_link": "https://join.app.net/from/notareallink",
    },
    "meta": {
        "code": 200
    }
}
~~~

## Deauthorize current token

Deauthorize the current [OAuth access token](/reference/authentication/#access-tokens). This works for User tokens and App tokens.

<%= endpoint "DELETE", "token", "Any" %>

#### Example

Requested with a user access token:

> DELETE https://alpha-api.app.net/stream/0/token

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
            "follow"
        ],
        "limits": {
            "following": 40,
            "max_file_size": 10000000
        },
        "storage": {
            "available": 8787479688,
            "used": 1212520312
        },
        "user": {
            "id": "1", // note this is a string
            ...
        }
    },
    "meta": {
        "code": 200
    }
}
~~~

## Retrieve authorized User IDs for an app

Returns a list of ids of Users that have authorized an app. Must be requested using an [app access token](/reference/authentication/#access-tokens). 

<%= endpoint "GET", "apps/me/tokens/user_ids", "App" %>

#### Example

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

Returns a list of User tokens corresponding to an app token. Must be requested using an [app access token](/reference/authentication/#access-tokens). 

<%= pagination_note %>

<%= endpoint "GET", "apps/me/tokens", "App" %>

#### Example
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
            "limits": { ... },
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
            "limits": { ... },
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
