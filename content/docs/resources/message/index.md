# Message

A Message is very similar to a [Post](/docs/resources/post/) but 1) it doesn't have to be public and 2) it will be delivered to an arbitrary set of users (not just the users who follow the Message creator). For an overview of the App.net messaging API, please see the [Introduction to App.net Messaging](/docs/basics/messaging/).

~~~ js
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
}
~~~

## Fields

<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>id</code></td>
        <td>string</td>
        <td>Primary identifier for a message. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
    </tr>
    <tr>
        <td><code>channel_id</code></td>
        <td>string</td>
        <td>The id of the channel this message belongs to. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
    </tr>
    <tr>
        <td><code>user</code></td>
        <td>object</td>
        <td>This is an embedded version of the <a href='/docs/resources/user/'>User</a> object. <b>Note:</b> In certain cases (e.g., when a user
                account has been deleted), this key may be omitted.</td>
    </tr>
    <tr>
        <td><code>created_at</code></td>
        <td>string</td>
        <td>The time at which the message was create in <a href='http://en.wikipedia.org/wiki/ISO_8601'>ISO 8601</a> format.</td>
    </tr>
    <tr>
        <td><code>text</code></td>
        <td>string</td>
        <td>User supplied text of the message.</td>
    </tr>
    <tr>
        <td><code>html</code></td>
        <td>string</td>
        <td>Server-generated annotated HTML rendering of message text.</td>
    </tr>
    <tr>
        <td><code>source</code></td>
        <td>object</td>
        <td>
            <br>
            <table>
                <tr>
                    <th>Field</th>
                    <th>Type</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td><code>name</code></td>
                    <td>string</td>
                    <td>Description of the API consumer that created this message.</td>
                </tr>
                <tr>
                    <td><code>link</code></td>
                    <td>string</td>
                    <td>Link provided by the API consumer that created this message.</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td><code>reply_to</code></td>
        <td>string</td>
        <td>The id of the message this message is replying to (or <code>null</code> if not a reply).</td>
    </tr>
    <tr>
        <td><code>thread_id</code></td>
        <td>string</td>
        <td>The id of the post at the root of the thread that this message is a part of. If <code>thread_id==id</code> than this property does not guarantee that the thread has > 1 message. Please see <code>num_replies</code>.</td>
    </tr>
    <tr>
        <td><code>num_replies</code></td>
        <td>integer</td>
        <td>The number of messages created in reply to this message.</td>
    </tr>
    <tr>
        <td><code>annotations</code></td>
        <td>list</td>
        <td>Metadata about the entire message. See the <a href="/docs/meta/annotations/">annotations documentation</a>.</td>
    </tr>
    <tr>
        <td><code>entities</code></td>
        <td>object</td>
        <td>Rich text information for this message. See the <a href="/docs/meta/entities/">entities documentation</a>.</td>
    </tr>
    <tr>
        <td><code>is_deleted</code></td>
        <td>boolean</td>
        <td>Has this message been deleted? For non-deleted posts, this key may be omitted instead of being <code>false</code>. If a message has been deleted, the <code>text</code>, <code>html</code>, and <code>entities</code> properties will be empty and may be omitted.</td>
    </tr>
    <tr>
        <td><code>machine_only</code></td>
        <td>boolean</td>
        <td>Is this Message meant for humans or other apps? See <a href="#machine-only-messages">Machine only Messages</a> for more information.</td>
    </tr>
</table>

## Message Annotations

Message annotations are immutable attributes that describe the entire message. Please see the [Annotations spec](/docs/meta/annotations/) for more information.

## Machine only Messages

Sometimes a Message is not meant for human consumption but it may be readable by an App of some kind. In that case, you can create a Machine only Message by including ```annotations``` and not including ```text```. You can request Machine only Messages using the ```include_machine=1``` query string parameter.

## Retrieve the Messages in a Channel

Retrieve a stream of the Messages in a channel. This endpoint responds to the [General Post Parameters](https://github.com/appdotnet/api-spec/blob/master/resources/posts.md#general-parameters) also.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://api.app.net/stream/0/channels/[channel_id]/messages

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
            <td>The id of the Channel who's messages you want to see</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://api.app.net/stream/0/channels/1/messages

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

## Create a Message

Create a <a href="/appdotnet/api-spec/blob/master/objects.md#message">Message</a> in the specified Channel.

Send a JSON document that matches the  <a href="/appdotnet/api-spec/blob/master/objects.md#message">message schema</a> with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```text```, ```reply_to```, ```annotations```, ```entities```, and ```machine_only```.

If you would like to specify your own entities, please refer to the [user specified entites](/appdotnet/api-spec/blob/master/objects.md#user-specified-entities) documentation, otherwise we will parse out links, hashtags, and mentions from the ```text``` field.

To create private group messages corresponding to the ```net.app.core.pm``` type, you can specify the special ```channel_id``` of ```auto```. With this parameter, the server will look for an extra field in the provided Message object called ```destinations``` which is a list of user_ids to send this message to. If a private message channel already exists between this group of users, that channel_id will be reused. Otherwise, a new channel will be created and the users specified in the ```destinations``` list will be able to write to that channel. Note that the ```destinations``` value may include user_ids in the form of @username or the integer id.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/messages

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
            <td>The id of the Channel who's messages you want to see or <code>auto</code> to find or create a new private message channel.</td>
        </tr>
    </tbody>
</table>

### Example

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

### Auto-channel example
> POST https://alpha-api.app.net/stream/0/channels/auto/messages
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

## Retrieve a Message

Retrieve a message.

*Note: you can always retrieve a message you created even if you are no longer able to view the rest of the Channel anymore.*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/messages/[message_id]

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
            <td>The id of the Channel this message belongs to</td>
        </tr>
        <tr>
            <td><code>message_id</code></td>
            <td>Required</td>
            <td>int</td>
            <td>The id of the Message you'd like to retrieve</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/channels/1/messages/103

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

## Delete a Message

Delete a message. The current user must be the same user who created the Message. It returns the deleted Message on success.

*Note: you can always delete a message you created even if you are no longer able to view the rest of the Channel anymore.*

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/appdotnet/api-spec/blob/master/auth.md#authenticated-api-requests).*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/messages/[message_id]

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
            <td>The id of the Channel this message belongs to</td>
        </tr>
        <tr>
            <td><code>message_id</code></td>
            <td>Required</td>
            <td>int</td>
            <td>The id of the Message you'd like to delete</td>
        </tr>
    </tbody>
</table>

### Example

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
