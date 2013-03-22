---
title: "Message Lifecycle"
---

# Message Lifecycle

* TOC
{:toc}

## Create a Message

Create a [Message](/docs/resources/message/) in the specified Channel.

Send a JSON document that matches the [Message schema](/docs/resources/message/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```text```, ```reply_to```, ```annotations```, ```entities```, and ```machine_only```.

If you would like to specify your own entities, please refer to the [user specified entites](/docs/meta/entities/#user-specified-entities) documentation, otherwise we will parse out links, hashtags, and mentions from the ```text``` field.

If you want to test how your text will be processed you can use the [text processor](/docs/resources/text-processor).

#### Creating Private Messages for use with net.app.core.pm Channels

To create private group messages for use in `net.app.core.pm` channels, you can specify the special `channel_id` of `pm`. With this parameter, the server will look for an extra field in the provided message object called `destinations` which is a list of user ids to send this message to. If a private message channel already exists between this group of users, its `channel_id` will be reused. Otherwise, a new channel will be created and the users specified in the `destinations` list will be auto-subscribed (according to their [subscription preferences](https://account.app.net/settings/messaging-permissions/)) and able to write to that channel. Note that the `destinations` value may include user ids in the form of "@username" or integer id.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "POST", "channels/[channel_id]/messages", "User", "public_messages</code> or <code>messages" %>

<%= url_params [
    ["channel_id", 'The id of the <a href="/docs/resources/channel/">Channel</a> in which to create the Message. Alternatively, you can specify <code>pm</code> to auto-create/reuse a <code>net.app.core.pm</code> <a href="/docs/resources/channel/#private-message">private message channel</a>.']
]%>

#### Generic Channel Example

> POST https://alpha-api.app.net/stream/0/channels/1/messages
>
> Content-Type: application/json
> 
> DATA {"text": "Hello channel!"}

~~~ js
{
    "data": {
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
    "meta": {
        "code": 200,
    }
}
~~~

#### PM Channel Example
> POST https://alpha-api.app.net/stream/0/channels/pm/messages
>
> Content-Type: application/json
> 
> DATA {"text": "Hello brand new channel!", "destinations": ["@berg", 1]}

~~~ js
{
    "data": {
        "channel_id": "2",
        "created_at": "2012-12-11T00:31:49Z",
        "entities": {
            "hashtags": [],
            "links": [],
            "mentions": []
        },
        "html": "<span itemscope=\"https://app.net/schemas/Post\">Hello channel!</span>",
        "id": "105",
        "machine_only": false,
        "num_replies": 0,
        "source": {
            "client_id": "UxUWrSdVLyCaShN62xZR5tknGvAxK93P",
            "link": "https://app.net",
            "name": "Test app"
        },
        "text": "Hello brand new channel!",
        "thread_id": "105",
        "user": {
            ...
        }
    },
    "meta": {
        "code": 200,
    }
}
~~~

## Delete a Message

Delete a message. The current user must be the same user who created the Message. It returns the deleted Message on success.

*Note: you can always delete a message you created even if you are no longer able to view the rest of the Channel anymore.*

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/docs/authentication/#making-authenticated-api-requests).*

<%= migration_warning ['response_envelope'] %>

<%= endpoint "DELETE", "channels/[channel_id]/messages/[message_id]", "User", "public_messages</code> or <code>messages" %>

<%= url_params [
    ["channel_id", "The id of the Channel this Message belongs to."],
    ["message_id", "The id of the Message to delete."]
]%>

#### Example

> DELETE https://alpha-api.app.net/stream/0/channels/1/messages/103

~~~ js
{
    "data": {
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
    "meta": {
        "code": 200,
    }
}
~~~

## Retrieve the Messages in a Channel

Retrieve a stream of the Messages in a channel. This endpoint responds to [pagination parameters](/docs/resources/post/#general-parameters).

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "channels/[channel_id]/messages", "User", "public_messages</code> or <code>messages" %>

<%= url_params [
    ["channel_id", "The id of the Channel to retrieve Messages from."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/channels/1/messages

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
        "marker": {
            "name": "channel:1"
        },
        "max_id": 103,
        "min_id": 95,
        "more": true
    }
}
~~~
