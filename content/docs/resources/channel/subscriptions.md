---
title: "Channel Subscriptions"
---

# Channel Subscription

* TOC
{:toc}

## Get current user's subscribed channels

Retrieve an "inbox" of the channels the user is currently subscribed to. This stream is ordered like an inbox with the stream containing the most recent post first.

The `meta` response will contain unread counts for common channel types.

<%= general_params_note_for "channel" %>

<%= pagination_note %>

<%= endpoint "GET", "channels", "User", "public_messages</code> or <code>messages"%>

#### Example

> GET https://alpha-api.app.net/stream/0/channels

~~~ js
{
    "data": [
        {
            "counts": {
                "messages": 42
            },
            "has_unread": true,
            "id": "1",
            "owner": {
                ...
            },
            "readers": {
                "any_user": false,
                "immutable": true,
                "public": false,
                "user_ids": [],
                "you": true
            },
            "type": "net.app.core.pm",
            "writers": {
                "any_user": false,
                "immutable": true,
                "public": false,
                "user_ids": [
                    "1",
                ],
                "you": true
            },
            "you_can_edit": false,
            "you_subscribed": true
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": 146,
        "min_id": 123,
        "more": true,
        "unread_counts": {
            "net.app.core.pm": 5,
            "net.app.core.broadcast": 3
        }
    }
}
~~~

## Subscribe to a Channel

Subscribe to a Channel. This adds it to your [Channel stream](#get-current-users-subscribed-channels). If a user has [muted this Channel](/docs/resources/channel/muting/#mute-a-channel), this call will automatically unmute the Channel.

<%= general_params_note_for "channel" %>

<%= endpoint "POST", "channels/[channel_id]/subscribe", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to subscribe to."]
]%>

#### Example

> POST https://alpha-api.app.net/stream/0/channels/1/subscribe

~~~ js
{
    "data": {
        "counts": {
            "messages": 42
        },
        "has_unread": false,
        "id": "1",
        "owner": {
            ...
        },
        "readers": {
            "any_user": false,
            "immutable": false,
            "public": false,
            "user_ids": [],
            "you": true
        },
        "type": "com.example",
        "writers": {
            "any_user": false,
            "immutable": false,
            "public": false,
            "user_ids": [
                "1"
            ],
            "you": true
        },
        "you_can_edit": true,
        "you_subscribed": true
    },
    "meta": {
        "code": 200
    }
}
~~~

## Unsubscribe from a Channel

Unsubscribe from a Channel. This removes it from your [Channel stream](#get-current-users-subscribed-channels).

<%= general_params_note_for "channel" %>

<%= endpoint "DELETE", "channels/[channel_id]/subscribe", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to unsubscribe from."]
]%>

#### Example

> DELETE https://alpha-api.app.net/stream/0/channels/1/subscribe

~~~ js
{
    "data": {
        "counts": {
            "messages": 42
        },
        "has_unread": false,
        "id": "1",
        "owner": {
            ...
        },
        "readers": {
            "any_user": false,
            "immutable": false,
            "public": false,
            "user_ids": [],
            "you": true
        },
        "type": "com.example",
        "writers": {
            "any_user": false,
            "immutable": false,
            "public": false,
            "user_ids": [
                "1"
            ],
            "you": true
        },
        "you_can_edit": true,
        "you_subscribed": false
    },
    "meta": {
        "code": 200
    }
}
~~~

## Retrieve users subscribed to a Channel

Retrieve the users who are subscribed to a Channel.

<%= general_params_note_for "channel" %>

<%= pagination_note %>

<%= endpoint "GET", "channels/[channel_id]/subscribers", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to retrieve subscribers for."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/channels/1/subscribers

<%= paginated_response(:user) do |h|
    h["meta"]["more"] = true
    h["meta"]["max_id"] = 82
    h["meta"]["min_id"] = 82
end %>

## Retrieve user ids subscribed to a Channel

Retrieve all the user ids who are subscribed to a Channel.

<%= endpoint "GET", "channels/[channel_id]/subscribers/ids", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to retrieve subscriber ids for."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/channels/1/subscribers

~~~ js
{
    "data": [
        "1",
        ...
    ],
    "meta": {
        "code": 200,
    }
}
~~~

## Retrieve user ids subscribed to multiple Channels

For each requested Channel, retrieve the ids of all Users who are subscribed to that Channel. Up to 200 Channels may be requested at one time. Channels which do not exist or which the requesting user does not have authorization to view will not be returned.

<%= endpoint "GET", "channels/subscribers/ids", "User", "public_messages</code> or <code>messages"%>

<%= query_params [
    ["ids", "A comma separated list of Channel ids to retrieve subscriber ids for."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/channels/subscribers/ids?ids=1,2,3,5

~~~ js
{
    "data": {
        "1": [
            "5",
            "10"
        ],
        "2": [
            "5",
            "20"
        ] // channels 3 and 5 are omitted as if they are not visible or do not exist
    },
    "meta": {
        "code": 200,
    }
}
~~~
