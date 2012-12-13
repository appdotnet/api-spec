---
title: "Post Streams"
---

# Post Streams

* TOC
{:toc}

## Retrieve Posts created by a User

Get the most recent [Posts](/docs/resources/post/) created by a specific [User](/docs/resources/user/) in reverse post order.

*Note: the User object is not returned for these Posts.*

<%= migration_warning ['response_envelope'] %>

### URL
> https://alpha-api.app.net/stream/0/users/[user_id]/posts

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
            <td>The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>.</td>
        </tr>
    </tbody>
</table>

*See [General Parameters](/docs/resources/post/#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/users/1/posts

~~~ js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
            "entities": {
                "mentions": [{
                    "name": "berg",
                    "id": "2",
                    "pos": 0,
                    "len": 5
                }],
                "hashtags": [{
                    "name": "newsocialnetwork",
                    "pos": 34,
                    "len": 17
                }],
                "links": [{
                    "text": "this new site",
                    "url": "https://join.app.net"
                    "pos": 20,
                    "len": 13
                }]
            },
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "47",
        "min_id": "1"
        "more": true
    }
}
~~~

## Retrieve Posts mentioning a User

Get the most recent [Posts](/docs/resources/post/) mentioning by a specific [User](/docs/resources/user/) in reverse post order.

<%= migration_warning ['response_envelope'] %>

### URL
> https://alpha-api.app.net/stream/0/users/[user_id]/mentions

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
            <td>The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>.</td>
        </tr>
    </tbody>
</table>

*See [General Parameters](/docs/resources/post/#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/users/2/mentions

~~~ js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
            "entities": {
                "mentions": [{
                    "name": "berg",
                    "id": "2",
                    "pos": 0,
                    "len": 5
                }],
                "hashtags": [{
                    "name": "newsocialnetwork",
                    "pos": 34,
                    "len": 17
                }],
                "links": [{
                    "text": "this new site",
                    "url": "https://join.app.net"
                    "pos": 20,
                    "len": 13
                }]
            },
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "36",
        "min_id": "1",
        "more": false
    }
}
~~~

## Retrieve tagged Posts

Return the 20 most recent [Posts](/docs/resources/post/) for a specific hashtag.

<%= migration_warning ['response_envelope'] %>

### URL
> https://alpha-api.app.net/stream/0/posts/tag/[hashtag]

### Parameters

*See [General Parameters](/docs/resources/post/#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/tag/newsocialnetwork

~~~ js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
            "entities": {
                "mentions": [{
                    "name": "berg",
                    "id": "2",
                    "pos": 0,
                    "len": 5
                }],
                "hashtags": [{
                    "name": "newsocialnetwork",
                    "pos": 34,
                    "len": 17
                }],
                "links": [{
                    "text": "this new site",
                    "url": "https://join.app.net"
                    "pos": 20,
                    "len": 13
                }]
            },
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "78",
        "min_id": "1",
        "more": false
    }
}
~~~

## Retrieve the Global stream

Return the 20 most recent [Posts](/docs/resources/post/) from the Global stream.

<%= migration_warning ['response_envelope'] %>

### URL
> https://alpha-api.app.net/stream/0/posts/stream/global

### Parameters

*See [General Parameters](/docs/resources/post/#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/stream/global

~~~ js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
            "entities": {
                "mentions": [{
                    "name": "berg",
                    "id": "2",
                    "pos": 0,
                    "len": 5
                }],
                "hashtags": [{
                    "name": "newsocialnetwork",
                    "pos": 34,
                    "len": 17
                }],
                "links": [{
                    "text": "this new site",
                    "url": "https://join.app.net"
                    "pos": 20,
                    "len": 13
                }]
            },
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "33",
        "min_id": "1",
        "more": true
    }
}
~~~

## Retrieve a User's personalized stream

Return the 20 most recent [Posts](/docs/resources/post/) from the current User and the Users they follow.

<%= migration_warning ['response_envelope'] %>

### URL
> https://alpha-api.app.net/stream/0/posts/stream

### Parameters

*See [General Parameters](/docs/resources/post/#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/stream

~~~ js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
            "entities": {
                "mentions": [{
                    "name": "berg",
                    "id": "2",
                    "pos": 0,
                    "len": 5
                }],
                "hashtags": [{
                    "name": "newsocialnetwork",
                    "pos": 34,
                    "len": 17
                }],
                "links": [{
                    "text": "this new site",
                    "url": "https://join.app.net"
                    "pos": 20,
                    "len": 13
                }]
            },
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "39",
        "min_id": "1",
        "more": true
    }
}
~~~

## Retrieve a User's unified stream

Return the 20 most recent [Posts](/docs/resources/post/) from the current user's [personalized stream](#retrieve-a-users-personalized-stream) and [mentions stream](#retrieve-posts-mentioning-a-user) merged into one stream.

<%= migration_warning ['response_envelope'] %>

### URL
> https://alpha-api.app.net/stream/0/posts/stream/unified

### Parameters

*See [General Parameters](/docs/resources/post/#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/stream/unified

~~~ js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
            "entities": {
                "mentions": [{
                    "name": "berg",
                    "id": "2",
                    "pos": 0,
                    "len": 5
                }],
                "hashtags": [{
                    "name": "newsocialnetwork",
                    "pos": 34,
                    "len": 17
                }],
                "links": [{
                    "text": "this new site",
                    "url": "https://join.app.net"
                    "pos": 20,
                    "len": 13
                }]
            },
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "39",
        "min_id": "1",
        "more": true
    }
}
~~~