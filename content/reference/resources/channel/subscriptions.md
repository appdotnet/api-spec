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

<%= curl_example(:get, "channels", :channel, {:response => :paginated}) do |h|
    h["data"][0]["pagination_id"] = "146"
    h["meta"]["more"] = true
    h["meta"]["unread_counts"] = {
        "net.app.core.pm" => 5,
        "net.app.core.broadcast" => 3
    }
end %>

## Subscribe to a Channel

Subscribe to a Channel. This adds it to your [Channel stream](#get-current-users-subscribed-channels). If a user has [muted this Channel](/reference/resources/channel/muting/#mute-a-channel), this call will automatically unmute the Channel.

<%= general_params_note_for "channel" %>

<%= endpoint "POST", "channels/[channel_id]/subscribe", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to subscribe to."]
]%>

#### Example

<%= curl_example(:post, "channels/1/subscribe", :channel) do |h|
    h["data"]["you_subscribed"] = true
end %>

## Unsubscribe from a Channel

Unsubscribe from a Channel. This removes it from your [Channel stream](#get-current-users-subscribed-channels).

<%= general_params_note_for "channel" %>

<%= endpoint "DELETE", "channels/[channel_id]/subscribe", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to unsubscribe from."]
]%>

#### Example

<%= curl_example(:delete, "channels/1/subscribe", :channel) do |h|
    h["data"]["counts"]["subscribers"] -= 1
    h["data"]["you_subscribed"] = false
end %>

## Retrieve users subscribed to a Channel

Retrieve the users who are subscribed to a Channel.

<%= general_params_note_for "channel" %>

<%= pagination_note %>

<%= endpoint "GET", "channels/[channel_id]/subscribers", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to retrieve subscribers for."]
]%>

#### Example

<%= curl_example(:get, "channels/1/subscribers", :channel, {:response => :paginated}) do |h|
    h["meta"]["more"] = true
    h["data"][0]["pagination_id"] = "82"
end %>

## Retrieve user ids subscribed to a Channel

Retrieve all the user ids who are subscribed to a Channel.

<%= endpoint "GET", "channels/[channel_id]/subscribers/ids", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to retrieve subscriber ids for."]
]%>

#### Example

<%= curl_example(:get, "channels/1/subscribers/ids", ["1"]) %>

## Retrieve user ids subscribed to multiple Channels

For each requested Channel, retrieve the ids of all Users who are subscribed to that Channel. Up to 200 Channels may be requested at one time. Channels which do not exist or which the requesting user does not have authorization to view will not be returned.

<%= endpoint "GET", "channels/subscribers/ids", "User", "public_messages</code> or <code>messages"%>

<%= query_params [
    ["ids", "A comma separated list of Channel ids to retrieve subscriber ids for."]
]%>

#### Example

Channels 3 and 5 are omitted as if they are not visible or do not exist

<%= curl_example(:get, "channels/1/subscribers/ids?ids=1,2,3,5", {
    "1" => ["5", "10"],
    "2" => ["5", "20"]
}) %>
