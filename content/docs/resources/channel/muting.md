---
title: "Channel Muting"
---

# Channel Muting

* TOC
{:toc}

## Get current user's muted Channels

Retrieve a list of the channels the current user has muted. A user cannot be [auto-subscribed](/docs/basics/messaging/#subscriptions) to muted channels.

This endpoint is **not** paginated and does **not** respond to the [general channel parameters](/docs/resources/channel/#general-parameters).

<%= endpoint "GET", "users/me/channels/muted", "User", "public_messages</code> or <code>messages"%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/me/channels/muted

<%= collection_response(:channel) do |h|
    h["data"][0]["you_muted"] = true
end %>

## Mute a Channel

Mute a Channel. If a user doesn't want to see a channel until there is a new message, they should [unsubscribe from the channel](/docs/resources/channel/subscriptions/#unsubscribe-from-a-channel) instead of muting it. If a user mutes a channel, they will automatically be unsubscribed from it and cannot be [auto-subscribed](/docs/basics/messaging/#subscriptions) to it.

<%= general_params_note_for "channel" %>

<%= endpoint "POST", "channels/[channel_id]/mute", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to mute."]
]%>

#### Example

> POST https://alpha-api.app.net/stream/0/channels/1/mute

<%= response(:channel) do |h|
    h["data"]["you_muted"] = true
    h["data"]["you_subscribed"] = false
end %>

## Unmute a Channel

Unmute a Channel. This allows you to be resubscribed to the channel (but it does not happen automatically).

<%= general_params_note_for "channel" %>

<%= endpoint "DELETE", "channels/[channel_id]/mute", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to unmute."]
]%>

#### Example

> DELETE https://alpha-api.app.net/stream/0/channels/1/mute

<%= response(:channel) do |h|
    h["data"]["you_muted"] = false
    h["data"]["you_subscribed"] = false
end %>
