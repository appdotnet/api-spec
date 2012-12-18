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
            <td>A list of strings that specify the kinds of objects this stream is interested in. Accepted strings are <code>post</code>, <code>star</code>, <code>user_follow</code>, <code>stream_marker</code>, <code>message</code>, <code>channel</code>, <code>channel_subscription</code>.</td>
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
* [stream_marker](#stream-marker): Sent when a stream marker is updated
* [message](#message): Sent for new objects, replies, and message deletions
* [channel](#channel): Sent when a channel is created or updated
* [channel_subscription](#channel-subscription): Sent when a user subscribes or unsubscribes to a channel

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

### stream_marker

A stream marker is set. If the stream marker is not for a channel, then meta.channel_id will be omitted.

~~~ js
{
    "meta": {
        "timestamp": 1355349119,
        "user_id": "143",
        "type": "stream_marker",
        "id": "143:channel:39",
        "channel_id": "39"
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

A message is created.

~~~ js
{
    'meta': {
        'timestamp': 1355348398679,
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

<%= render 'partials/endpoints-tab', :for => "stream" %>
