# Stream

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
            <td>A list of strings that specify the kinds of objects this stream is interested in. Must be one of <code>post</code>, <code>star</code>, <code>user_follow</code>.</td>
        </tr>
        <tr>
            <td><code>type</code></td>
            <td>string</td>
            <td>A string specifying the type of stream this is. This can affect the transport method of the endpoint url as well as characteristics of the stream (how many messages it can process, how long lived it is, etc). Currently, the only option is <code>long_poll</code>.</td>
        </tr>
        <tr>
            <td><code>key</code></td>
            <td>string</td>
            <td>An optional User assigned string that names this stream so it's easy to query for later. If a key is given, it must be unique for all streams created by a single token.</td>
        </tr>
    </tbody>
</table>

## Interacting with individual Streams

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#create-a-stream">Create a Stream</a></td>
            <td>/stream/0/streams</td>
            <td>POST</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#retrieve-a-stream">Retrieve a Stream</a></td>
            <td>/stream/0/streams/[streams_id]</td>
            <td>GET</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#delete-a-stream">Delete a Stream</a></td>
            <td>/stream/0/streams/[streams_id]</td>
            <td>DELETE</td>
        </tr>
    </tbody>
</table>

## Interacting with multiple Streams

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#get-current-tokens-streams">Retrieve all Streams for the current Token</a></td>
            <td>/stream/0/streams</td>
            <td>GET</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#delete-all-of-the-current-tokens-streams">Delete all Streams for the current Token</a></td>
            <td>/stream/0/streams</td>
            <td>DELETE</td>
        </tr>
    </tbody>
</table>

## Basic Use

A Stream is a real-time, ordered collection of messages. A message will always be a [response envelope](/appdotnet/api-spec/blob/master/migrations.md#current-migrations). If you are receiving a message about an object, the ```data``` key will contain that object. Some actions (like following a user) will contain extra information in the ```meta``` key.

There are 3 different kinds of Streams, but they all follow the same pattern:

* Public stream: A Stream containing all public activity (and any private activity the App is authorized to see). **It must be accessed with an [App access token](/appdotnet/api-spec/blob/master/auth.md#app-access-token-flow)**.

* Coming soon:
    * User stream: A Stream for a single User's view of App.net. This is a Stream version of the [Retrieve a User's personalized stream]
(/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-users-personalized-stream) endpoint. It is very useful for client
based Apps that need a single User's Stream. **It must be accessed with a User access token**.
    * App stream: A Stream for Apps to request multiple Users Streams at once. It is very useful for server based Apps that need the
streams of lots of users. **It must be accessed with an App access token**.

Since memory and bandwidth is not unlimited, each Stream has associated limits. App.net maintains a buffer of messages to send to a
client, but if that buffer fills, your Stream will be disconnected. Please ensure that you are only requesting streams of data that
you can actually process.

## Filters

Streams will give you lots of data, much of which your application may not want. A [Filter](../objects/filter.md) can be passed to the [stream creation endpoint](#create-a-stream) to control what messages are actually delivered to your App by our servers.

## Response Format

A Stream is a long-lived HTTP connection that enables clients to receive messages in near real-time from App.net.

When a Stream is established, App.net will send response that includes the ```endpoint``` that the app can use to consume the newly created stream. You may pass ?purge=1 if you do not wish to receive any messages previously queued up for this stream.

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
* [message](#message): Sent for new messages, replies, and message deletions
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


## Create a Stream

Create a <a href="../objects/stream.md">Stream</a> for the current token.

Send a JSON document that matches the  <a href="../objects/stream.md">stream schema</a> with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```object_types```, ```type``` and ```filter_id```. If you don't want to specify a filter, omit ```filter_id```.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/streams

### Data

A JSON object representing the stream to create. See <a href="../objects/stream.md">the stream object</a> for more information. Specify ```filter_id``` instead of ```filter``` if you want to filter this stream. (Omit the ```id``` and ```endpoint``` parameters).</td>

### Example

> POST https://alpha-api.app.net/stream/0/streams
> 
> Content-Type: application/json
> 
> DATA {"object_types": ["post"], "type": "long_poll", "id": "1", "filter_id": "1", "key": "rollout_stream"}

~~~js
{
    "data": {
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
    },
    "meta": {
        "code": 200
    }
}
~~~

## Retrieve a Stream

Returns a specific <a href="../objects/stream.md">Stream</a> object.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/streams/[streams_id]

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
            <td><code>streams_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The stream id</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/streams/1

~~~ js
{
    "data": {
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
        "type": "long_poll"
    },
    "meta": {
        "code": 200
    }
}
~~~

## Get current token's Streams

Return the <a href="../objects/stream.md">Streams</a> for the current token.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/streams

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
            <td><code>key</code></td>
            <td>Optional</td>
            <td>string</td>
            <td>Only retrieve the stream that matches the given key</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/streams?key=rollout_stream

~~~ js
{
    "data": [
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
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": "2",
        "min_id": "1",
        "more": false
    }
}
~~~

## Delete a Stream

Delete a <a href="../objects/stream.md">Stream</a>. The Stream must belong to the current User. It returns the deleted Stream on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/appdotnet/api-spec/blob/master/auth.md#authenticated-api-requests).*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/streams/[stream_id]

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
            <td><code>stream_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The stream id</td>
        </tr>
    </tbody>
</table>

### Example

> DELETE https://alpha-api.app.net/stream/0/streams/1

~~~ js
{
    "data": {
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
        "type": "long_poll"
    },
    "meta": {
        "code": 200
    }
}
~~~

## Delete all of the current user's Streams

Delete all <a href="../objects/stream.md">Streams</a> for the current token. It returns the deleted Streams on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/appdotnet/api-spec/blob/master/auth.md#authenticated-api-requests).*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/streams

### Data

None.

### Example

> DELETE https://alpha-api.app.net/stream/0/streams

~~~ js
{
    "data": [
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
            "type": "long_poll"
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": "2",
        "min_id": "1",
        "more": false
    }
}
~~~
