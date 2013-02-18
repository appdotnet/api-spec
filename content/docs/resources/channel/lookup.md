---
title: "Channel Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a Channel

Returns a specific [Channel](/docs/resources/channel/).

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "channels/[channel_id]", "User", "public_messages</code> or <code>messages"%>

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
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/channels/2

~~~ js
{
    "data": {
        "counts": {
            "messages": 42
        },
        "has_unread": false,
        "id": "2",
        "owner": {
            // user object of channel owner
        },
        "readers": {
            "any_user": false,
            "immutable": true,
            "public": false,
            "user_ids": [],
            "you": true
        },
        "recent_message_id": "480",
        "type": "net.app.core.pm",
        "writers": {
            "any_user": false,
            "immutable": true,
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

## Retrieve multiple Channels
Returns multiple Channels requested by id. At most 200 channels can be requested. Channels which do not exist or which the requesting user does not have authorization to view will not be returned.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "channels", "User", "public_messages</code> or <code>messages"%>

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
            <td>A comma separated list of Channel ids to retrieve.</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/channels?ids=1,2,6502

~~~ js
{
    "data": [
        {
            "counts": {
                "messages": 42
            },        
            "has_unread": false,
            "id": "1",
            "owner": {
                // user object of channel owner
            },
            "readers": {
                "any_user": false,
                "immutable": true,
                "public": false,
                "user_ids": [],
                "you": true
            },
            "recent_message_id": "3094",
            "type": "net.app.core.pm",
            "writers": {
                "any_user": false,
                "immutable": true,
                "public": false,
                "user_ids": [
                    "8"
                ],
                "you": true
            },
            "you_can_edit": true,
            "you_subscribed": true
        },
        {
            "counts": {
                "messages": 42
            },
            "has_unread": false,
            "id": "2",
            "owner": {
                // user object of channel owner
            },
            "readers": {
                "any_user": false,
                "immutable": true,
                "public": false,
                "user_ids": [],
                "you": true
            },
            "recent_message_id": "480",
            "type": "net.app.core.pm",
            "writers": {
                "any_user": false,
                "immutable": true,
                "public": false,
                "user_ids": [
                    "1"
                ],
                "you": true
            },
            "you_can_edit": true,
            "you_subscribed": true
        }
        // Note that channel 6502 is not present as it doesn't exist.
    ],
    "meta": {
        "code": 200
    }
}
~~~

## Retrieve my Channels
Returns a stream of all Channels the current user has created. This endpoint responds to [pagination parameters](/docs/resources/post/#general-parameters) and the [general channel parameters](/docs/resources/channel/#general-parameters).

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "users/me/channels", "User", "public_messages</code> or <code>messages"%>

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/users/me/channels

~~~ js
{
    "data": [
        {
            "counts": {
                "messages": 42
            },
            "has_unread": false,
            "id": "2",
            "owner": {
                // user object of channel owner
            },
            "readers": {
                "any_user": false,
                "immutable": true,
                "public": false,
                "user_ids": [],
                "you": true
            },
            "recent_message_id": "3094",
            "type": "net.app.core.pm",
            "writers": {
                "any_user": false,
                "immutable": true,
                "public": false,
                "user_ids": [
                    "8"
                ],
                "you": true
            },
            "you_can_edit": true,
            "you_subscribed": true
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": 2,
        "min_id": 1,
        "more": false
    }
}
~~~


## Retrieve number of unread PM Channels
Returns the current number of `net.app.core.pm` Channels where `has_unread: true` for the current user.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "users/me/channels/pm/num_unread", "User", "messages"%>

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/users/me/channels/pm/num_unread

~~~ js
{
    "data": 5,
    "meta": {
        "code": 200,
        "max_id": 2,
        "min_id": 1,
        "more": false
    }
}
~~~
