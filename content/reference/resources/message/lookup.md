---
title: "Message Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a Message

Returns a specific [Message](/reference/resources/message/).

*Note: you can always retrieve a message you created even if you are no longer able to view the rest of the Channel anymore.*

<%= general_params_note_for "message" %>

<%= endpoint "GET", "channels/[channel_id]/messages/[message_id]", "Varies" %>

<%= url_params [
    ["channel_id", "The id of the Channel containing the Message."],
    ["message_id", "The id of the Message to retrieve."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/channels/2/messages/480

~~~ js
{
    "data": {
        "channel_id": "2",
        "created_at": "2012-12-13T18:43:14Z",
        "entities": {
            "hashtags": [],
            "links": [],
            "mentions": []
        },
        "html": "<span itemscope=\"https://app.net/schemas/Post\">heh</span>",
        "id": "480",
        "machine_only": false,
        "num_replies": 0,
        "source": {
            "client_id": "zuETCrYwDQW7GtewwyWdv2p69vhg25RW",
            "link": "https://omega.app.net/",
            "name": "ADN \u03a9"
        },
        "text": "heh",
        "thread_id": "480",
        "user": {
            // full user object
        }
    },
    "meta": {
        "code": 200
    }
}
~~~

## Retrieve multiple Messages

Returns multiple Messages requested by id. At most 200 messages can be requested. Messages may be requested from more than one channel at a time. Messages which do not exist or which the requesting user does not have authorization to view will not be returned.

<%= general_params_note_for "message" %>

<%= endpoint "GET", "channels/messages", "Any" %>

<%= query_params [
    ["ids", "A comma separated list of ids of the Messages to retrieve."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/channels/messages?ids=480,481

~~~ js
{
    "data": [
        {
            "channel_id": "2",
            "created_at": "2012-12-13T18:43:14Z",
            "entities": {
                "hashtags": [],
                "links": [],
                "mentions": []
            },
            "html": "<span itemscope=\"https://app.net/schemas/Post\">heh</span>",
            "id": "480",
            "machine_only": false,
            "num_replies": 0,
            "source": {
                "client_id": "zuETCrYwDQW7GtewwyWdv2p69vhg25RW",
                "link": "https://omega.app.net/",
                "name": "ADN \u03a9"
            },
            "text": "heh",
            "thread_id": "480",
            "user": {
                // full user object
            }
        }
        // Note that message 481 is not returned because the requesting user does not have permission to see it.
    ],
    "meta": {
        "code": 200
    }
}
~~~

## Retrieve my Messages

Retrieve a stream of the Messages the current user has created.

<%= general_params_note_for "message" %>

<%= pagination_note %>

<%= endpoint "GET", "users/me/messages", "User", "public_messages</code> or <code>messages" %>

#### Example

> GET https://alpha-api.app.net/stream/0/users/me/messages

~~~ js
{
    "data": [
        {
            "channel_id": "1",
            "created_at": "2012-12-11T00:31:49Z",
            "entities": {
                "hashtags": [],
                "links": [],
                "mentions": []
            },
            "html": "<span itemscope=\"https://app.net/schemas/Post\">Hello channel!</span>",
            "id": "103",
            "machine_only": false,
            "num_replies": 0,
            "source": {
                "client_id": "UxUWrSdVLyCaShN62xZR5tknGvAxK93P",
                "link": "https://app.net",
                "name": "Test app"
            },
            "text": "Hello channel!",
            "thread_id": "103",
            "user": {
                ...
            }
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": 103,
        "min_id": 95,
        "more": true
    }
}
~~~
