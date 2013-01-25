---
title: "Stream"
---

# Stream

<%= render 'partials/object-tab' %>

* TOC
{:toc}

A customized view of the global stream that is streamed to the client instead of polling.

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
            <td>A list of strings that specify the kinds of objects this stream is interested in. Accepted strings are <code>post</code>, <code>star</code>, <code>user_follow</code>, <code>mute</code>, <code>stream_marker</code>, <code>message</code>, <code>channel</code>, <code>channel_subscription</code>, <code>token</code>, <code>file</code>.</td>
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

A Stream is a real-time, ordered collection of objects. An object will always be formatted in a [response envelope](/docs/basics/responses/#response-envelopes). The ```data``` key will always contain the object. Some actions (like following a user) will contain extra information in the ```meta``` key.

There will be three different kinds of Streams, but they all follow the same pattern:

* Public stream (available now): A Stream containing all public activity (and any private activity the App is authorized to see). **It must be accessed with an [App access token](/docs/authentication/flows/app-access-token/)**.

* User stream (coming soon): A Stream for a single User's view of App.net. This is a Stream version of the [Retrieve a User's personalized stream](/docs/resources/post/streams/#retrieve-a-users-personalized-stream) endpoint. It is very useful for client based Apps that need a single User's Stream. **It must be accessed with a User access token**.

* App stream (coming soon): A Stream for Apps to request multiple Users Streams at once. It is very useful for server based Apps that need the streams of lots of users. **It must be accessed with an App access token**.

Since memory and bandwidth is not unlimited, each Stream has associated limits. App.net maintains a buffer of objects to send to a client, but if that buffer fills, your Stream will be disconnected. Please ensure that you are only requesting streams of data that you can actually process.

## Filters

Streams will give you lots of data, much of which your application may not want. A [Filter](/docs/resources/filter/) can be passed to the [stream creation endpoint](/docs/resources/stream/lifecycle/#create-a-stream) to control what objects are actually delivered to your App by our servers.

## Response Format

A Stream is a long-lived HTTP connection that enables clients to receive objects in near real-time from App.net.

When a Stream is established, App.net will send response that includes the ```endpoint``` that the app can use to consume the newly created stream. You may pass ?purge=1 if you do not wish to receive any objects previously queued up for this stream.

Once connected to the stream endpoint, the response will be encoded using HTTP ```Transfer-Encoding: chunked```.

The Stream contains frames separated by ```\r\n```. For example:

    HELLO\r\nWORLD!!!\r\n


### Control Message

A control message is a JSON object that gives the client important information about the current Stream. For instance, if the buffer
is getting too full, the client will receive a control message with that warning. A control message will always have ```control```
as a key in the object so it is easy to distinguish from a Post.

## Sample stream objects

A Stream can listen for the following object types:

* [post](#post): Sent for new posts, replies, reposts, and post deletions
* [star](#star): Sent when a user stars a post
* [user_follow](#user-follow): Sent when a user begins following or unfollows another user
* [mute](#mute): Sent when a user who has authorized your app mutes or unmutes another user
* [stream_marker](#stream-marker): Sent when a stream marker is updated
* [message](#message): Sent for new objects, replies, and message deletions
* [channel](#channel): Sent when a channel is created or updated
* [channel_subscription](#channel-subscription): Sent when a user subscribes or unsubscribes to a channel
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
        "user": {
            ...
        },
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
        "user": {
            ...
        },
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

### file ###

*You only see messages in this category for users who have authorized your app with the `files` scope.*

A file is created.

~~~js
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
        "user": {
            ...
        },
        "type": "com.example.test",
        "annotations": [],
        "complete": false
    }
}
~~~

A file is uploaded to (or updated).

~~~js
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
        "user": {
            ...
        },
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

{
    "meta": {
        "timestamp": 1358986636754,
        "type": "file",
        "id": "85",
        "is_deleted": true,
    },
}

<%= render 'partials/endpoints-tab', :for => "stream" %>
