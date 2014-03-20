---
title: "Channel Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a Channel

Returns a specific [Channel](/reference/resources/channel/).

<%= general_params_note_for "channel" %>

<%= endpoint "GET", "channels/[channel_id]", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to retrieve."]
]%>

#### Example

<%= curl_example(:get, "channels/1", :channel) %>

## Retrieve multiple Channels
Returns multiple Channels requested by id. At most 200 channels can be requested. Channels which do not exist or which the requesting user does not have authorization to view will not be returned.

<%= general_params_note_for "channel" %>

<%= endpoint "GET", "channels", "Any" %>

<%= query_params [
    ["ids", "A comma separated list of ids of Channels to retrieve."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/channels?ids=1,2,6502

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
        }
        // In this example, Channel 6502 is not present as it doesn't exist.
    ],
    "meta": {
        "code": 200
    }
}
~~~

## Retrieve my Channels
Returns a stream of all Channels the current user has created. 

<%= general_params_note_for "channel" %>

<%= pagination_note %>

<%= endpoint "GET", "users/me/channels", "User", "public_messages</code> or <code>messages"%>

#### Example

<%= curl_example(:get, "users/me/channels", :channel, {:response => :paginated}) %>

## Retrieve number of unread PM Channels
Returns the current number of `net.app.core.pm` Channels where `has_unread: true` for the current user.

<%= endpoint "GET", "users/me/channels/pm/num_unread", "User", "messages"%>

#### Example

<%= curl_example(:get, "users/me/channels/pm/num_unread", 5) %>

## Retrieve number of unread Broadcast Channels
Returns the current number of `net.app.core.broadcast` Channels where `has_unread: true` for the current user.

<%= endpoint "GET", "users/me/channels/broadcast/num_unread", "User", "messages"%>

#### Example

<%= curl_example(:get, "users/me/channels/broadcast/num_unread", 3) %>


## Mark all Broadcast Channels as read
Mark all `net.app.core.broadcast` Channels as read for the current user.

<%= endpoint "DELETE", "users/me/channels/broadcast/num_unread", "User", "messages"%>

#### Example

<%= curl_example(:delete, "users/me/channels/broadcast/num_unread", 0) %>
