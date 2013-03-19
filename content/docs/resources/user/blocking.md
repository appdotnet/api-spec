---
title: "User Blocking"
---

# Blocking

* TOC
{:toc}

## Block a User

Block a user from seeing your App.net content. This means the user will not be able to see, star, reply to, or repost your content. This user will also effectively be muted for you. This will automatically unfollow both users from each other.

In most cases, [muting a user](/docs/resources/user/muting/#mute-a-user) is probably sufficient since that hides all of a user's content from you. If a user is aggressively reposting or starring your content, blocking them will prevent them from interacting with your content at all.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "POST", "users/[user_id]/block", "User", "follow" %>

### Data

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>user_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The id of the User to block. You can also specify <code>@username</code> as a <code>user_id</code>.</td>
        </tr>
    </tbody>
</table>

### Example

> POST https://alpha-api.app.net/stream/0/users/1/block

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
        "you_blocked": true,
        "you_follow": false,
        "you_muted": false
    },
    "meta": {
        "code": 200
    }
}
~~~

## Unblock a User

Allow a blocked user to interact with my content.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/docs/authentication/#making-authenticated-api-requests).*

<%= migration_warning ['response_envelope'] %>

<%= endpoint "DELETE", "users/[user_id]/block", "User", "follow" %>

### Parameters

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>user_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The id of the User to unblock. You can also specify <code>@username</code> as a <code>user_id</code>.</td>
        </tr>
    </tbody>
</table>

### Example

> DELETE https://alpha-api.app.net/stream/0/users/1/block

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
        "you_blocked": false,
        "you_follow": false,
        "you_muted": false,
    },
    "meta": {
        "code": 200
    }
}
~~~

## List blocked Users

Retrieve a list of blocked users. If you have a [user token](/docs/authentication/#access-tokens) you can request blocked users for the current user by using `me` as the requested user id. If you have an [app token](/docs/authentication/#access-tokens) you can request blocked users for any user that has authorized your app.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "users/[user_id]/blocked", "Any" %>

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/users/me/blocked

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
            "you_blocked": true,
            "you_follow": false,
            "you_muted": false,
        },
        ...
    ],
    "meta": {
        "code": 200
    }
}
~~~


## Retrieve blocked User IDs for multiple Users

Returns a list of blocked User ids for each User id requested. At most 200 User ids can be requested.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "users/blocked/ids", "App" %>

### Parameters

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>ids</code></td>
            <td>Required</td>
            <td>string</td>
            <td>A comma separated list of User ids to retrieve blocked User ids for</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/users/blocked/ids?ids=1,2

~~~ js
{
    "data": {
        "1": [
            "3",
            "29"
        ],
        "2": []
    },
    "meta": {
        "code": 200
    }
}
~~~