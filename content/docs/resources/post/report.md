---
title: "Report"
---

# Report

* TOC
{:toc}

## Report a Post

Report a post as spam. This will mute the author of the post and send a report to App.net.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "POST", "posts/[post_id]/report", "User" %>

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
            <td><code>post_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The post id</td>
        </tr>
    </tbody>
</table>

### Example

> POST https://alpha-api.app.net/stream/0/posts/1/report

~~~ js
{
    "data": {
        "id": "2",
        "user": {
            ...
        },
        "created_at": "2012-09-13T21:26:19Z",
        "entities": {
            "hashtags": [],
            "links": [],
            "mentions": [{
                "name": "berg",
                "id": "2",
                "pos": 3,
                "len": 5
            }]
        },
        "text": ">> @berg: a really insightful post that must be shared with the world"
        "html": ">> <span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span>: a really insightful post that must be shared with the world",
        "source": {
            "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
            "name": "Clientastic for iOS",
            "link": "http://app.net"
        },
        "machine_only": false,
        "reply_to": null,
        "thread_id": "2",
        "num_replies": 0,
        "num_reposts": 0,
        "num_stars": 0,
        "you_reposted": false,
        "you_starred": false
        "repost_of": {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "a really insightful post that must be shared with the world",
            "html": "a really insightful post that must be shared with the world",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 1,
            "num_stars": 0,
            "entities": {
                "mentions": [],
                "hashtags": [],
                "links": []
            },
            "you_reposted": true,
            "you_starred": false
        },
    },
    "meta": {
        "code": 200,
    }
}
~~~