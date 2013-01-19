---
title: "Message Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a Message

Returns a specific [Message](/docs/resources/message/).

*Note: you can always retrieve a message you created even if you are no longer able to view the rest of the Channel anymore.*

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "channels/[channel_id]/messages/[message_id]", "User", "public_messages</code> or <code>messages" %>

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
            <td><code>channel_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The channel id</td>
        </tr>
        <tr>
            <td><code>message_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The message id</td>
        </tr>
    </tbody>
</table>

### Example

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

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "channels/messages", "User", "public_messages</code> or <code>messages" %>

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
            <td>A comma separated list of Message ids to retrieve.</td>
        </tr>
    </tbody>
</table>

### Example

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

Retrieve a stream of the Messages the current user has created. This endpoint responds to [pagination parameters](/docs/resources/post/#general-parameters).

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "channels/messages/me", "User", "public_messages</code> or <code>messages" %>

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/channels/messages/me

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
