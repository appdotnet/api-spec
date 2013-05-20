---
title: "Channel Lifecycle"
---

# Channel Lifecycle

* TOC
{:toc}

## Create a Channel

Create a new [Channel](/docs/resources/channel/).

Send a JSON document that matches the [Channel schema](/docs/resources/channel/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```readers```, ```writers```, ```annotations```, and ```type```. 

#### Creating a PM Channel

[PM Channels](/docs/resources/channel/#private-message) (channels of type `net.app.core.pm`) cannot be directly created. Instead they are created for you as necessary when sending a [Message](/docs/resources/message/) using `pm` as a `channel_id`. For more information, see the [Create a Message](/docs/resources/message/lifecycle/#create-a-message) endpoint.

<%= general_params_note_for "channel" %>

<%= endpoint "POST", "channels", "User", "public_messages</code> or <code>messages"%>

#### Example

> POST https://alpha-api.app.net/stream/0/channels
>
> Content-Type: application/json
> 
> DATA {"type": "com.example.channel", "writers": {"user_ids": ["@berg", "1"]}}

~~~ js
{
    "data": {
        "counts": {
            "messages": 42
        },    
        "has_unread": false,
        "id": "36",
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
        "type": "com.example.channel",
        "writers": {
            "any_user": false,
            "immutable": true,
            "public": false,
            "user_ids": [
                "1",
                "2"
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

## Update a Channel

Updates a specific [Channel](/docs/resources/channel/) object. You can update a channel by PUTing an object that matches the [Channel schema](/docs/resources/channel/) with an HTTP header of ```Content-Type: application/json```. The only keys that can be updated are ```annotations```, ```readers```, and ```writers``` (and the ACLs can only be updated if ```immutable=false```). The ```you_can_edit``` property tells you if you are allowed to update a channel. Currently, only the Channel owner can edit a channel.

If you want to add or update a Channel's annotations, you may include the optional ```annotations``` key and pass in the annotations that are changing.

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
            "public": true,
            "user_ids": [],
            "you": true
        },
        "type": "com.example.channel",
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
