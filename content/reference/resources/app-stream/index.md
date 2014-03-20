---
title: "App Stream"
---

# App Stream

<%= render 'partials/object-tab' %>

* TOC
{:toc}

A customized view of the global events happening on App.net that is streamed to the client instead of polling.

~~~ js
{
    "endpoint": "https://stream-channel.app.net...",
    "filter": {
        "clauses": [
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "matches",
                "value": "rollout"
            }
        ],
        "id": "1",
        "match_policy": "include_any",
        "name": "Posts about rollouts"
    },
    "id": "1",
    "object_types": [
        "post"
    ],
    "type": "long_poll",
    "key": "rollout_stream"
}
~~~

## Stream Fields

<table class='table table-striped'>
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
            <td>Primary identifier for a stream. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
        </tr>
        <tr>
            <td><code>endpoint</code></td>
            <td>string</td>
            <td>The fully qualified URL the client should use to connect to this stream.</td>
        </tr>
        <tr>
            <td><code>filter</code></td>
            <td>object</td>
            <td>An optional filter to apply when generating the stream.</td>
        </tr>
        <tr>
            <td><code>object_types</code></td>
            <td>list</td>
            <td>A list of strings that specify the kinds of objects this stream is interested in. Accepted strings are <code>post</code>, <code>star</code>, <code>user_follow</code>, <code>mute</code>, <code>block</code>, <code>stream_marker</code>, <code>message</code>, <code>channel</code>, <code>channel_subscription</code>, <code>token</code>, <code>file</code>.</td>
        </tr>
        <tr>
            <td><code>type</code></td>
            <td>string</td>
            <td>A string specifying the type of stream this is. This can affect the transport method of the endpoint url as well as characteristics of the stream (how many objects it can process, how long lived it is, etc). Currently, the only option is <code>long_poll</code>.</td>
        </tr>
        <tr>
            <td><code>key</code></td>
            <td>string</td>
            <td>An optional User assigned string that names this stream so it's easy to query for later. If a key is given, it must be unique for all streams created by a single token.</td>
        </tr>
    </tbody>
</table>

## Basic Use

    curl -i <value from stream.endpoint>

An App Stream contains all public activity (and any private activity the App is authorized to see). **It must be accessed with an [App access token](/reference/authentication/flows/app-access-token/)**. You can create up to 5 app streams per App token. An App Stream can only be used on a server (where the App token can be kept secret). If you would like your stream to be automatically deleted when you disconnect from your app stream, add the `auto_delete=1` query string parameter when connecting to a stream.

Each object in the App Stream will be formatted in a [response envelope](/reference/make-request/responses/#response-envelope). The ```data``` key will always contain the object. Some actions (like following a user) will contain extra information in the ```meta``` key.

If you would like a realtime stream of an individual user's view of App.net, please use a [User Stream](/reference/resources/user-stream).

Since memory and bandwidth is not unlimited, each Stream has associated limits. App.net maintains a buffer of objects to send to a client, but if that buffer fills, your Stream will be disconnected. Please ensure that you are only requesting streams of data that you can actually process.

## Filters

Streams will give you lots of data, much of which your application may not want. A [Filter](/reference/resources/filter/) can be passed to the [stream creation endpoint](/reference/resources/app-stream/lifecycle/#create-a-stream) to control what objects are actually delivered to your App by our servers.

## Response Format

A Stream is a long-lived HTTP connection that enables clients to receive objects in near real-time from App.net.

When a Stream is established, App.net will send response that includes the ```endpoint``` that the app can use to consume the newly created stream. You may pass ?purge=1 if you do not wish to receive any objects previously queued up for this stream.

Once connected to the stream endpoint, the response will be encoded using HTTP ```Transfer-Encoding: chunked```.

The Stream contains frames separated by ```\r\n```. For example:

    HELLO\r\nWORLD!!!\r\n


### Data Message

A data message is a JSON object that represents an action that was taken in the App.net API. These messages are returned in a [response envelope](/reference/make-request/responses/#response-envelope). The `data` that's returned is meant to match the responses from the polling API endpoints as closely as possible. Please look at the [sample stream objects](#sample-stream-objects) for documentation about each kind of data message.

The `meta` object may contain the following standard keys:

<table class='table table-striped'>
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
            <td>An opaque string that identifies this message. Do not assume any formatting or meaning with this field.</td>
        </tr>
        <tr>
            <td><code>is_deleted</code></td>
            <td>boolean</td>
            <td>Does this event represent an object being deleted?</td>
        </tr>
        <tr>
            <td><code>timestamp</code></td>
            <td>integer</td>
            <td>A unix time representing the approximate time this event occurred.</td>
        </tr>
        <tr>
            <td><code>type</code></td>
            <td>string</td>
            <td>One of <code>post</code>, <code>star</code>, <code>user_follow</code>, <code>mute</code>, <code>block</code>, <code>stream_marker</code>, <code>message</code>, <code>channel</code>, <code>channel_subscription</code>, <code>token</code>, <code>file</code>.</td>
        </tr>
    </tbody>
</table>

Depending on the event type, the following keys may also be available in the `meta` object:

<table class='table table-striped'>
    <thead>
        <tr>
            <th>Field</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>channel_id</code></td>
            <td>string</td>
            <td>What is the id of the channel this event is connected to? This is included if the event <code>type</code> is <code>stream_marker</code>.</td>
        </tr>
        <tr>
            <td><code>channel_type</code></td>
            <td>string</td>
            <td>What is the type of the channel this event is connected to? This is included if the event <code>type</code> is <code>message</code> or <code>stream_marker</code>.</td>
        </tr>
        <tr>
            <td><code>subscribed_user_ids</code></td>
            <td>list</td>
            <td>A list of user ids who are subscribed to the channel associated with this event. This is included if the event <code>type</code> is <code>channel</code> or <code>message</code>.</td>
        </tr>
        <tr>
            <td><code>suppress_notifications</code></td>
            <td>list</td>
            <td>A list of user ids who should not receive this event as a <a href="#notifications">notification</a>.</td>
        </tr>
        <tr>
            <td><code>suppress_notifications_all</code></td>
            <td>boolean</td>
            <td>Should this event be excluded when sending <a href="#notifications">notifications</a> to any user?</td>
        </tr>
        <tr>
            <td><code>user_id</code></td>
            <td>string</td>
            <td>What is the id of the user this event is connected to? This is included if the event <code>type</code> is <code>stream_marker</code> or <code>token</code>.</td>
        </tr>
    </tbody>
</table>

### Control Message

A control message is a JSON object that gives the client important information about the current Stream. For instance, if the buffer
is getting too full, the client will receive a control message with that warning. A control message will always have ```control```
as a key in the object so it is easy to distinguish from a Post.

## Notifications

One of the main uses of an App Stream is to send notifications to users about what is happening on App.net. When you run a notification service, you need to respect a user's [muting](/reference/resources/user/muting/) and [blocking](/reference/resources/user/blocking/) preferences and whether that event came from a [bot account](/reference/resources/user/#user-fields). If you're sending ["standard" notifications](#standard-notifications), App.net provides some information with each streaming event to make this easier. If you'd like to do something besides the standard notifications, App.net provides some [advanced guidance](#advanced-notifications).

### Standard Notifications

App.net recognizes that there are some standard notifications that many clients send to users. To make sure users don't get notifications from other users they've muted or blocked, App.net provides some extra information with each streaming event.

For each streaming event, App.net generates a list of every user who would be notified using the [standard notifications](#standard-notification-types). Then, App.net provides a list of user ids who should not receive a notification from this event.

If your app only sends standard notifications, you won't have to keep lists of who a user has muted or blocked. Instead, when you receive a message from the Streaming API:

1. Check `meta.suppress_notifications_all`. If that value is `true`, then don't send any notifications.
2. Generate the list of users you would usually notify.
3. Filter that list so it doesn't include an user ids specified in `meta.suppress_notifications`

These values can also be influenced by App.net's anti-spam system and future features. *If your app fits into the Standard Notification Types, we highly recommend you use this option.*

#### Standard Notification Types

In general, clients that send push notifications should send based on the following events:

* Notify me when someone stars one of my posts
* Notify me when someone follows me
* Notify me when someone reposts one of my posts
* Notify me when someone replies to one of my posts or messages
* Notify me when someone mentions me in a post or a message
* Notify me when someone messages a channel I'm subscribed to

### Advanced Notifications

If you'd like to do complex notifications that aren't possible with the [standard notifications](#standard-notifications), your notification server will still need to respect a user's [muting](/reference/resources/user/muting/) and [blocking](/reference/resources/user/blocking/) preferences.

1. When your notification server starts, retrieve and store the list of [users who have authorized your app](/reference/resources/token/#retrieve-authorized-user-ids-for-an-app).
2. For each of those users, retrieve and store the users they have [muted](/reference/resources/user/muting/#retrieve-muted-user-ids-for-multiple-users) and [blocked](/reference/resources/user/blocking/#retrieve-blocked-user-ids-for-multiple-users).
3. As you process [(un)mutes](#mute) and [(un)blocks](#block) from the Streaming API, update those lists for each user.
4. Before you send a notification to a user, check that it didn't come from a user that they have muted or blocked. Also, check to make sure `meta.suppress_notifications_all` is not `true`.

## Sample stream objects

An App Stream can listen for the following object types:

* [post](#post): Sent for new posts, replies, reposts, and post deletions
* [star](#star): Sent when a user stars a post
* [user_follow](#user_follow): Sent when a user begins following or unfollows another user
* [mute](#mute): Sent when a user who has authorized your app mutes or unmutes another user
* [block](#block): Sent when a user who has authorized your app blocks or unblocks another user
* [stream_marker](#stream_marker): Sent when a stream marker is updated
* [message](#message): Sent for new objects, replies, and message deletions
* [channel](#channel): Sent when a channel is created or updated
* [channel_subscription](#channel_subscription): Sent when a user subscribes or unsubscribes to a channel
* [token](#token): Sent when a user authorizes, changes scopes for, or deauthorizes an app
* [file](#file): Sent when a user creates a file, updates a file, or deletes a file

### post

A new post is created.

~~~ js
{
    'meta': {
        'timestamp': 1355347583834,
        'type': 'post',
        'id': '71611'
    },
    'data': {
        ...post that was created...
    }
}
~~~

A post is deleted.

~~~ js
{
    'meta': {
        'timestamp': 1355347607233,
        'is_deleted': true,
        'type': 'post',
        'id': '71611'
    },
    'data': {
        ...post that was deleted...
    }
}
~~~

### star

A user stars a post.

~~~ js
{
    'meta': {
        'timestamp': 1355347590751,
        'type': 'star',
        'id': '132'
    },
    'data': {
        'post': {
            ...post that was starred...
        },
        'user': {
            ...user that starred this post...
        }
    }
}
~~~

A user unstars a post.

~~~ js
{
    'meta': {
        'timestamp': 1355347603621,
        'is_deleted': true,
        'type': 'star',
        'id': '132'
    },
    'data': {
        'post': {
            ...post that was unstarred...
        },
        'user': {
            ...user that unstarred the post...
        }
    }
}
~~~

### user_follow

A user follows another user.

~~~ js
{
    'meta': {
        'timestamp': 1355347619758,
        'type': 'user_follow',
        'id': '486'
    },
    'data': {
        'follows_user': {
            ...user...
        },
        'user': {
            ...user starts following follows_user...
        }
    }
}
~~~

A user unfollows another user.

~~~ js
{
    'meta': {
        'timestamp': 1355347618071,
        'is_deleted': true,
        'type': 'user_follow',
        'id': '190'
    },
    'data': {
        'follows_user': {
            ...who was unfollowed...
        },
        'user': {
            ...user unfollowed follows_user...
        }
    }
}
~~~

### mute

*You only see objects in this category for users who have authorized your app.*

A user that has authorized your app mutes another user.

~~~ js
{
    "meta": {
        "timestamp": 1358373991082,
        "type": "mute",
        "id": "143:144"
    },
    "data": {
        "muted_user": {
            ...user object...
        },
        "user": {
            ...user object...
        }
    }
}
~~~

A user that has authorized your app unmutes another user.

~~~ js
{
    "meta": {
        "timestamp": 1358373991082,
        "is_deleted": true,
        "type": "mute",
        "id": "143:144"
    },
    "data": {
        "muted_user": {
            ...user object...
        },
        "user": {
            ...user object...
        }
    }
}
~~~

### block

*You only see objects in this category for users who have authorized your app.*

A user that has authorized your app blocks another user.

~~~ js
{
    "meta": {
        "timestamp": 1358373991082,
        "type": "block",
        "id": "143:144"
    },
    "data": {
        "blocked_user": {
            ...user object...
        },
        "user": {
            ...user object...
        }
    }
}
~~~

A user that has authorized your app unblocks another user.

~~~ js
{
    "meta": {
        "timestamp": 1358373991082,
        "is_deleted": true,
        "type": "block",
        "id": "143:144"
    },
    "data": {
        "blocked_user": {
            ...user object...
        },
        "user": {
            ...user object...
        }
    }
}
~~~


### stream_marker

*You only see objects in this category for users who have authorized your app with the `stream`, `messages` or `public_messages` scopes. You will only see stream markers that your users have authorized you to see.*

A stream marker is set. If the stream marker is not for a channel, then `meta.channel_id` and `meta.channel_type` will be omitted.

~~~ js
{
    "meta": {
        "timestamp": 1355349119,
        "user_id": "143",
        "type": "stream_marker",
        "id": "143:channel:39",
        "channel_id": "39",
        "channel_type": "net.app.core.pm"
    },
    "data": {
        "marker": {
            ...marker object...
        },
        "user": {
            ...user object...
        }
    }
}
~~~

### message

*You only see objects in this category for users who have authorized your app with the `messages` or `public_messages` scopes. You will only see messages that your users have authorized you to see.*

A message is created.

~~~ js
{
    'meta': {
        'timestamp': 1355348398679,
        'channel_type' : 'net.app.core.pm',
        'subscribed_user_ids': [
            '1',
            '2'
        ],
        'type': 'message',
        'id': '1'
    },
    'data': {
        ...message object...
    }
}
~~~

A message is deleted.

~~~ js
{
    'meta': {
        'timestamp': 1355348398679,
        'channel_type' : 'net.app.core.pm',
        'is_deleted': true,
        'type': 'message',
        'id': '1'
    },
    'data': {
        ...message object...
    }
}
~~~

### channel

*You only see objects in this category for users who have authorized your app with the `messages` or `public_messages` scopes. You will only see channels that your users have authorized you to see.*

A channel is created or updated.

~~~ js
{
    'meta': {
        'timestamp': 1355348399284,
        'type': 'channel',
        'id': '1'
    },
    'data': {
        ...channel...
    }
}
~~~

### channel_subscription

A user subscribes to a channel.

~~~ js
{
    "meta": {
        "timestamp": 1355349183060,
        "type": "channel_subscription",
        "id": "92"
    },
    "data": {
        "user": "...user object...",
        "channel": {
            ...
        }
    }
}
~~~

A user unsubscribes to a channel.

~~~ js
{
    "meta": {
        "timestamp": 1355349183060,
        'is_deleted': true,
        "type": "channel_subscription",
        "id": "92"
    },
    "data": {
        "user": "...user object...",
        "channel": {
            ...
        }
    }
}
~~~

### token

A user authorizes an application.

~~~ js
{
    "meta": {
        "timestamp": 1358365986869,
        "type": "token",
        "id": "12345",
        "user_id": "29"
    },
    "data": {
        "scopes": ["update_profile", "basic"],
        "app": {
            "link": "http://app.net",
            "name": "My test app",
            "client_id": "pXUH9kGNx54tA9B4EYkJc9kB9Ne8ZVdS"
        },
        "user": {...},
        "client_id": "pXUH9kGNx54tA9B4EYkJc9kB9Ne8ZVdS"
    }
}
~~~

A user changes scopes for an application.

~~~ js
{
    "meta": {
        "timestamp": 1358365986869,
        "type": "token",
        "id": "12345",
        "user_id": "29"
    },
    "data": {
        "scopes": ["basic", "follow", "stream"],
        "app": {
            "link": "http://app.net",
            "name": "My test app",
            "client_id": "pXUH9kGNx54tA9B4EYkJc9kB9Ne8ZVdS"
        },
        "user": {...},
        "client_id": "pXUH9kGNx54tA9B4EYkJc9kB9Ne8ZVdS"
    }
}
~~~

A user deauthorizes an application.

~~~ js
{
    "meta": {
        "timestamp": 1358365986869,
        "is_deleted": true,
        "type": "token",
        "id": "12345",
        "user_id": "29"
    }
}
~~~

### file

*You only see messages in this category for users who have authorized your app with the `files` scope.*

A file is created.

~~~ js
{
    "meta": {
        "timestamp": 1358986634896,
        "type": "file",
        "id": "85"
    },
    "data": {
        "kind": "other",
        "name": "my_dog",
        "id": "85",
        "source": {
            ...
        },
        "user": "...user object...",
        "type": "com.example.test",
        "annotations": [],
        "complete": false
    }
}
~~~

A file is uploaded to (or updated).

~~~ js
{
    "meta": {
        "timestamp": 1358986636754,
        "type": "file",
        "id": "85"
    },
    "data": {
        "kind": "other",
        "sha1": "ef0ccae4d36d4083b53e121a6cf9cc9d7aca1234",
        "name": "my_dog",
        "source": {
            ...
        },
        "url": "https://example.com/image.png",
        "derived_files": {
            "image_thumb_200s": {
                "url": "https://example.com/image_thumb.png",
                "sha1": "be91cb06d69df13bb103a359ce70cf9fba3e1234",
                "url_expires": "2013-01-25T03:00:00Z",
                "mime_type": "image/png",
                "size": 33803
            },
            "image_thumb_960r": {
                "url": "https://example.com/image_large_thumb.png",
                "sha1": "57004b55119002f551be5b9f2d5439dd4adf1234",
                "url_expires": "2013-01-25T03:00:00Z",
                "mime_type": "image/png",
                "size": 140173
            }
        },
        "id": "85",
        "total_size": 346369,
        "user": "...user object...",
        "complete": true,
        "size": 172393,
        "type": "com.example.test",
        "annotations": [],
        "mime_type": "image/png",
        "url_expires": "2013-01-25T03:00:00Z"
    }
}
~~~

A file is deleted.

~~~ js
{
    "meta": {
        "timestamp": 1358986636754,
        "type": "file",
        "id": "85",
        "is_deleted": true,
    },
}
~~~

<%= render 'partials/endpoints-tab', :for => "app-stream" %>
