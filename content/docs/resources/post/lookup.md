---
title: "Post Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a Post

Returns a specific [Post](/docs/resources/post/).

<%= general_params_note_for "post" %>

<%= endpoint "GET", "posts/[post_id]", "None" %>

<%= url_params [
    ["post_id","The id of the Post to retrieve."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/posts/1

~~~ js
{
    "data": {
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
    "meta": {
        "code": 200,
    }
}
~~~

## Retrieve multiple Posts

Returns multiple Posts requested by id. At most 200 posts can be requested.

<%= general_params_note_for "post" %>

<%= endpoint "GET", "posts", "Any" %>

<%= query_params [
    ["ids","A comma separated list of ids of Posts to retrieve."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/posts?ids=1,2,3

~~~ js
{
    "data": [
        {
            "id": "1", // note this is a string
            ...
        },
        {
            "id": "2",
            ...
        },
        {
            "id": "3",
            ...
        },
    ],
    "meta": {
        "code": 200,
    }
}
~~~