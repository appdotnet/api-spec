---
title: "User Following"
---

# Following

* TOC
{:toc}

## Follow a User

Returns the <a href="/docs/resources/user/">User</a> object of the user being followed. 

<%= migration_warning ['response_envelope'] %>

<%= endpoint "POST", "users/[user_id]/follow", "User", "follow" %>

<%= url_params [
  ["user_id","The user id to be followed. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> POST https://alpha-api.app.net/stream/0/users/1/follow

~~~ js
{
    "data": {
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
    },
    "meta": {
        "code": 200
    }
}
~~~

## Unfollow a User

Returns the <a href="/docs/resources/user/">User</a> object of the user being unfollowed.

*Remember, access tokens cannot be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/docs/authentication/#making-authenticated-api-requests).*

<%= migration_warning ['response_envelope'] %>

<%= endpoint "DELETE", "users/[user_id]/follow", "User", "follow" %>

<%= url_params [
  ["user_id","The user id to stop following. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> DELETE https://alpha-api.app.net/stream/0/users/1/follow

~~~ js
{
    "data": {
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
        "you_follow": false,
        "you_muted": false,
    },
    "meta": {
        "code": 200
    }
}
~~~

## List users a user is following

Returns a list of <a href="/docs/resources/user/">User</a> objects the specified user is following. Please note that the pagination is not based on user or post ids.

<%= migration_warning ['response_envelope','follow_pagination'] %>

<%= endpoint "GET", "users/[user_id]/following", "Any" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/2/following

~~~ js
{
    "data": [
        {
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
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": "2",
        "min_id": "1",
        "more": true
    }
}
~~~

## List users following a user

Returns a list of <a href="/docs/resources/user/">User</a> objects for users following the specified user. Please note that the pagination is not based on user or post ids.

<%= migration_warning ['response_envelope','follow_pagination'] %>

<%= endpoint "GET", "users/[user_id]/followers", "Any" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/2/followers

~~~ js
{
    "data": [
        {
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
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": "2",
        "min_id": "1",
        "more": true
    }
}
~~~

## List user ids a User is following

Returns an array of user ids the specified user is following.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "users/[user_id]/following/ids", "Any" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/1/following/ids

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

## List user ids of a User's followers

Returns an array of user ids for users following the specified user.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "users/[user_id]/followers/ids", "Any" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/1/followers/ids

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

