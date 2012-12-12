# Channel

A Channel is a user created stream of Messages. It controls access to the messages in the channel allowing for (among other things) public, private, and group messaging. For an overview of the App.net messaging API, please see the [Introduction to App.net Messaging](/docs/basics/messaging/).

## Fields

<table>
    <thead>
        <tr>
            <th>Field</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>id</code></td>
            <td>string</td>
            <td>Primary identifier for a channel. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
        </tr>
        <tr>
            <td><code>type</code></td>
            <td>string</td>
            <td>A string that looks like a reversed domain name to identify the intended purpose of this channel. <em>There is no authentication or authorization performed on this field. Just because you create annotations with the type <code>com.example.awesome</code> does not imply you are the only one that is using that namespace or that the channel ACLs will match the format you expect</em>. <code>net.app.core</code> is a reserved namespace.</td>
        </tr>
        <tr>
            <td><code>owner</code></td>
            <td>User object</td>
            <td>This is an embedded version of the <a href='/docs/resources/user/'>User</a> object. <b>Note:</b> In certain cases (e.g., when a user account has been deleted), this key may be omitted.</td>
        </tr>
        <tr>
            <td><code>annotations</code></td>
            <td>list</td>
            <td>Metadata about the channel. See the <a href="/docs/meta/annotations/">annotations documentation</a>.</td>
        </tr>
        <tr>
            <td><code>readers</code></td>
            <td><a href="#acl">ACL object</a></td>
            <td>The access control list that describes who can read this channel and its messages.</td>
        </tr>
        <tr>
            <td><code>writers</code></td>
            <td><a href="#acl">ACL object</a></td>
            <td>The access control list that describes who can write messages to this channel.</td>
        </tr>
        <tr>
            <td><code>you_subscribed</code></td>
            <td>boolean</td>
            <td>Are you currently subscribed to this channel. There are many channels you could have access to read and this indicates whether you are "following" this channel.</td>
        </tr>
        <tr>
            <td><code>you_can_edit</code></td>
            <td>boolean</td>
            <td>Can you edit the channel.</td>
        </tr>
        <tr>
            <td><code>has_unread</code></td>
            <td>boolean</td>
            <td>Are there unread messages in this channel (according to the stream marker you have saved for this channel)?</td>
        </tr>
    </tbody>
</table>

## Channel Annotations

Channel annotations are mutable attributes that describe the channel. Please see the [Annotations spec](/docs/meta/annotations/) for more information.

## ACL

~~~ js
"readers": {
    "any_user": false,
    "immutable": false,
    "public": false,
    "user_ids": [],
    "you": true
},
"writers": {
    "any_user": false,
    "immutable": false,
    "public": false,
    "user_ids": [
        "1",
        "2",
        "3"
    ],
    "you": true
}
~~~

Access control lists (ACLs) specify who can read and who can write Messages in a Channel. In our permissions model, writing implies reading. Note that ```any_user```, ```public```, and non-empty ```user_ids``` are all mutually exclusive (only one of those can be true at a time). Also, the creator of a Channel always has write access and will not be specified in the ```user_ids``` list. For some channel types (like ```net.app.core.pm```), the ACLs will be sanitized to make sure they fit a specific schema. Please see the [messaging overview](/docs/basics/messaging/) for more information.

### ACL Fields

<table>
    <thead>
        <tr>
            <th>Field</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>any_user</code></td>
            <td>boolean</td>
            <td>Can any logged in App.net user read/write to this channel? If true, <code>public</code> will be false and <code>user_ids</code> will be empty.</td>
        </tr>
        <tr>
            <td><code>immutable</code></td>
            <td>boolean</td>
            <td>Can this ACLs be changed? In general, we recommend creating immutable Channels so a user's messages can't "leak out" of a channel later.</td>
        </tr>
        <tr>
            <td><code>public</code></td>
            <td>boolean</td>
            <td>Can anyone (including not logged in users), read this channel. This will always be false for the <code>writers</code> ACL. If true, <code>any_user</code> will be false and <code>user_ids</code> will be empty.</td>
        </tr>
        <tr>
            <td><code>user_ids</code></td>
            <td>list</td>
            <td>A list of strings specifying the user ids who can read/write to this channel. If non-empty, <code>any_user</code> and <code>public</code> will be false.</td>
        </tr>
        <tr>
            <td><code>you</code></td>
            <td>boolean</td>
            <td>Can the authorized user for the current token read/write to this channel? This field, unlike the others, respects the permission hierarchy. To test channel writeability, you need only examine this field.</td>
        </tr>
    </tbody>
</table>


## Channel types

* [Private Message](#private-message): net.app.core.pm

### Private Message

> net.app.core.pm

This channel type is for private messages between 2 or more people. As a core Channel type, it has some special restrictions designed to simplify adoption for developers. Arbitrary channel types are available for use which do not have these restrictions (and are able to maintain the same level of privacy.)

Private message channels enforce that there is at least one non-owner user_id in the ```writers``` ACL and that both ACLs are immutable. Messages with the `machine_only` flag set are disallowed (though, of course, annotations are permitted when accompanied with text.)

In addition, this channel type differs from others in that it is designed to provide a simple, combined API for channel creation, reuse and message sending. You can only create `net.app.core.pm` channels via the special endpoint for doing so.


## Get current user's subscribed channels

Retrieve an "inbox" of the channels the user is currently subscribed to. This stream is ordered like an inbox with the stream containing the most recent post first.

This endpoint responds to [pagination parameters](/appdotnet/api-spec/blob/master/responses.md#pagination-metadata"). Remember that the ```min_id```/```max_id``` do not have to correspond to the ids in the ```data``` list.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/channels

~~~ js
{
    "data": [
        {
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
        "more": true
    }
}
~~~

## Create a Channel

Create a new <a href="/appdotnet/api-spec/blob/master/objects.md#channel">Channel</a>.

Send a JSON document that matches the  <a href="/appdotnet/api-spec/blob/master/objects.md#channel">channel schema</a> with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```readers```, ```writers```, ```annotations```, and ```type```. The ```type``` field controls how the ```readers``` and ```writers``` ACLs are validated.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

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

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

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

Updates a specific <a href="/appdotnet/api-spec/blob/master/objects.md#filter">Channel</a> object. You can update a channel by PUTing an object that matches the [channel schema](/appdotnet/api-spec/blob/master/objects.md#channel) with an HTTP header of ```Content-Type: application/json```. The only keys that can be updated are ```annotations```, ```readers```, and ```writers``` (and the ACLs can only be updated if ```immutable=false```). The ```you_can_edit``` property tells you if you are allowed to update a channel. Currently, only the Channel owner can edit a channel.

If you want to add or update a Channel's annotations, you may include the optional ```annotations``` key and pass in the annotations that are changing.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

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

## Subscribe to a Channel

Subscribe to a Channel. This adds it to your [Channel stream](#get-current-users-subscribed-channels).

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribe

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

> POST https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribe

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

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribe

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

> DELETE https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribe

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

This endpoint responds to [pagination parameters](/appdotnet/api-spec/blob/master/responses.md#pagination-metadata"). Remember that the ```min_id```/```max_id``` do not have to correspond to the ids in the ```data``` list.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribers

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
            <td>The id of the Channel to update</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/channels/1/subscribers

~~~ js
{
    "data": [
        {
            "id": "1", // note this is a string
            "username": "mthurman",
            "name": "Mark Thurman",
            "description": {
               "text": "Hi, I'm Mark Thurman and I'm teaching you about the @appdotnet Stream #API.",
               "html": "Hi, I'm Mark Thurman and I'm <a href=\"https://github.com/appdotnet/api_spec\" rel=\"nofollow\">teaching you</a> about the <span itemprop=\"mention\" data-mention-name=\"appdotnet\" data-mention-id=\"3\">@appdotnet</span> Stream #<span itemprop=\"hashtag\" data-hashtag-name=\"api\">API</span>.",
               "entities": {
                   "mentions": [{
                       "name": "appdotnet",
                       "id": "3",
                       "pos": 52,
                       "len": 10
                   }],
                   "hashtags": [{
                       "name": "api",
                       "pos": 70,
                       "len": 4
                   }],
                   "links": [{
                       "text": "teaching you",
                       "url": "https://github.com/appdotnet/api-spec",
                       "pos": 29,
                       "len": 12
                   }]
                }
            },
            "timezone": "US/Pacific",
            "locale": "en_US",
            "avatar_image": {
                "height": 512,
                "width": 512,
                "url": "https://example.com/avatar_image.jpg"
            },
            "cover_image": {
                "height": 118,
                "width": 320,
                "url": "https://example.com/cover_image.jpg"
            },
            "type": "human",
            "created_at": "2012-07-16T17:23:34Z",
            "counts": {
                "following": 100,
                "followers": 200,
                "posts": 24,
                "stars": 76
            },
            "follows_you": false,
            "you_follow": true,
            "you_muted": false,
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": 82,
        "min_id": 54,
        "more": true
    }
}
~~~

## Retrieve user ids subscribed to a Channel

Retrieve all the user ids who are subscribed to a Channel.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribers/ids

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
            <td>The id of the Channel to update</td>
        </tr>
    </tbody>
</table>

### Example

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