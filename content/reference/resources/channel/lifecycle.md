---
title: "Channel Lifecycle"
---

# Channel Lifecycle

* TOC
{:toc}

## Create a Channel

Create a new [Channel](/reference/resources/channel/).

Send a JSON document that matches the [Channel schema](/reference/resources/channel/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```readers```, ```writers```, ```annotations```, and ```type```. The owner will be auto-subscribed to this channel.

### Creating a PM Channel

[PM Channels](/reference/resources/channel/#private-message) (channels of type `net.app.core.pm`) cannot be directly created. Instead they are created for you as necessary when sending a [Message](/reference/resources/message/) using `pm` as a `channel_id`. For more information, see the [Create a Message](/reference/resources/message/lifecycle/#create-a-message) endpoint.

<%= general_params_note_for "channel" %>

<%= endpoint "POST", "channels", "User", "public_messages</code> or <code>messages"%>

### Example

> POST https://alpha-api.app.net/stream/0/channels
>
> Content-Type: application/json
> 
> DATA {"type": "com.example.channel", "writers": {"user_ids": ["@berg", "1"]}}

<%= response(:channel) do |h|
    h["data"]["id"] = "2"
    h["data"]["readers"]["public"] = false
    h["data"]["writers"]["user_ids"] = ["1", "2"]
    h["data"].delete("recent_message_id")
    h["data"].delete("recent_message")
end %>

## Update a Channel

Updates a specific [Channel](/reference/resources/channel/) object. You can update a channel by PUTing an object that matches the [Channel schema](/reference/resources/channel/) with an HTTP header of ```Content-Type: application/json```. The only keys that can be updated are ```annotations```, ```readers```, and ```writers``` (and the ACLs can only be updated if ```immutable=false```). The ```you_can_edit``` property tells you if you are allowed to update a channel. Currently, only the Channel owner can edit a channel.

If you want to add or update a Channel's annotations, you may include the optional ```annotations``` key and pass in the annotations that are changing.

This endpoint currently works identically for the `PUT` and `PATCH` HTTP methods.

<%= general_params_note_for "channel" %>

<%= endpoint "PUT", "channels/[channel_id]", "User", "public_messages</code> or <code>messages"%>

<%= url_params [
    ["channel_id", "The id of the Channel to update."]
]%>

#### Example

> PUT https://alpha-api.app.net/stream/0/channels/1
>
> Content-Type: application/json
> 
> DATA {"readers": {"public": true}}

<%= response(:channel) %>

## Deactivate a Channel

Mark a channel as inactive. This **does not** delete the contents of the Channel. It prevents new messages from being added to the channel and unsubscribes all users from the Channel. This channel will be hidden unless it is explicitly requested by id or the `include_inactive=1` parameter is used. This is irreversible.

The current user must be the same user who created the Channel. *Editors cannot delete a channel*

*net.app.core.pm* channels cannot be marked as inactive.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/reference/authentication/#making-authenticated-api-requests).*

<%= general_params_note_for "channel" %>

<%= endpoint "DELETE", "channels/[channel_id]", "User" %>

<%= url_params [
    ["channel_id", "The id of the Channel to delete."]
]%>

### Example

> DELETE https://alpha-api.app.net/stream/0/channels/1

<%= response(:channel) do |h|
    h["data"]["is_inactive"] = true
    h["data"]["counts"]["subscribers"] = 0
    h["you_subscribed"] = false
end %>
