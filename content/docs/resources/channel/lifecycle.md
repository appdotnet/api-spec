---
title: "Channel Lifecycle"
---

# Channel Lifecycle

* TOC
{:toc}

## Create a Channel

Create a new [Channel](/docs/resources/channel/).

Send a JSON document that matches the [Channel schema](/docs/resources/channel/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```readers```, ```writers```, ```annotations```, and ```type```. The ```type``` field controls how the ```readers``` and ```writers``` ACLs are validated.

<%= migration_warning ['response_envelope'] %>

### Required Scopes

* ```public_messages``` or ```messages```

### URL
> https://alpha-api.app.net/stream/0/channels

### Data

None.

### Example

> POST https://alpha-api.app.net/stream/0/channels
>
> Content-Type: application/json
> 
> DATA {"type": "net.app.core.pm", "writers": {"user_ids": ["@berg", 1]}}

~~~ js
{
    "data": {
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
        "type": "net.app.core.pm",
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

## Retrieve a Channel

Retrieve a Channel.

<%= migration_warning ['response_envelope'] %>

### Required Scopes

* ```public_messages``` or ```messages```

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]

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
            <td>int</td>
            <td>The id of the Channel to retrieve</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/channels/1

~~~ js
{
    "data": {
        "has_unread": false,
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

## Update a Channel

Updates a specific [Channel](/docs/resources/channel/) object. You can update a channel by PUTing an object that matches the [Channel schema](/docs/resources/channel/) with an HTTP header of ```Content-Type: application/json```. The only keys that can be updated are ```annotations```, ```readers```, and ```writers``` (and the ACLs can only be updated if ```immutable=false```). The ```you_can_edit``` property tells you if you are allowed to update a channel. Currently, only the Channel owner can edit a channel.

If you want to add or update a Channel's annotations, you may include the optional ```annotations``` key and pass in the annotations that are changing.

<%= migration_warning ['response_envelope'] %>

### Required Scopes

* ```public_messages``` or ```messages```

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]

### Data

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
            <td>int</td>
            <td>The id of the Channel to update</td>
        </tr>
    </tbody>
</table>

### Example

> PUT https://alpha-api.app.net/stream/0/channels/1
>
> Content-Type: application/json
> 
> DATA {"readers": {"public": true}}

~~~ js
{
    "data": {
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
