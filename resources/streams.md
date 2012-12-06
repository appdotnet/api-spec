# Streams

**These features are still highly experimental. If you make use of them, please idle in our [developer chat room](https://www.hipchat.com/garqCaGOZ) so you can report bugs and we can communicate updates.**

## General Information

### Basic Use

A Stream is a real-time, ordered collection of messages. A message will always be a [response envelope](/appdotnet/api-spec/blob/master/migrations.md#current-migrations). If you are receiving a message about an object, the ```data``` key will contain that object. Some actions (like following a user) will contain extra information in the ```meta``` key.

There are 3 different kinds of Streams, but they all follow the same pattern:

* Public stream: A Stream containing all public activity. **It must be accessed with an [App access token](/appdotnet/api-spec/blob/master/auth.md#app-access-token-flow)**.

* Coming soon:
    * User stream: A Stream for a single User's view of App.net. This is a Stream version of the [Retrieve a User's personalized stream]
(/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-users-personalized-stream) endpoint. It is very useful for client
based Apps that need a single User's Stream. **It must be accessed with a User access token**.
    * App stream: A Stream for Apps to request multiple Users Streams at once. It is very useful for server based Apps that need the
streams of lots of users. **It must be accessed with an App access token**.

Since memory and bandwidth is not unlimited, each Stream has associated limits. App.net maintains a buffer of messages to send to a
client, but if that buffer fills, your Stream will be disconnected. Please ensure that you are only requesting streams of data that
you can actually process.

### Filters

Streams will give you lots of data, much of which your application may not want. A [Filter](/appdotnet/api-spec/blob/master/objects.md#filter) can be passed to the [stream creation endpoint](#create-a-stream) to control what messages are actually delivered to your App by our servers.

### Response Format

A Stream is a long-lived HTTP connection that enables clients to receive messages in near real-time from App.net.

When a Stream is established, App.net will send response that includes the ```endpoint``` that the app can use to consume the newly created stream. You may pass ?purge=1 if you do not wish to receive any messages previously queued up for this stream.

Once connected to the stream endpoint, the response will be encoded using HTTP ```Transfer-Encoding: chunked```.

The Stream contains frames separated by ```\r\n```. For example:


    HELLO\r\nWORLD!!!\r\n


#### Control Message

A control message is a JSON object that gives the client important information about the current Stream. For instance, if the buffer
is getting too full, the client will receive a control message with that warning. A control message will always have ```control```
as a key in the object so it is easy to distinguish from a Post.


## Get current token's Streams

Return the <a href="/appdotnet/api-spec/blob/master/objects.md#stream">Streams</a> for the current token.

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
```js
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
```

## Create a Stream

Create a <a href="/appdotnet/api-spec/blob/master/objects.md#stream">Stream</a> for the current token.

Send a JSON document that matches the  <a href="/appdotnet/api-spec/blob/master/objects.md#stream">stream schema</a> with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```object_types```, ```type``` and ```filter_id```. If you don't want to specify a filter, omit ```filter_id```.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/streams

### Data

A JSON object representing the stream to create. See <a href="/appdotnet/api-spec/blob/master/objects.md#stream">the stream object</a> for more information. Specify ```filter_id``` instead of ```filter``` if you want to filter this stream. (Omit the ```id``` and ```endpoint``` parameters).</td>

### Example

> POST https://alpha-api.app.net/stream/0/streams
> 
> Content-Type: application/json
> 
> DATA {"object_types": ["post"], "type": "long_poll", "id": "1", "filter_id": "1", "key": "rollout_stream"}
```js
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
```

## Delete all of the current user's Streams

Delete all <a href="/appdotnet/api-spec/blob/master/objects.md#stream">Streams</a> for the current token. It returns the deleted Streams on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/appdotnet/api-spec/blob/master/auth.md#authenticated-api-requests).*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/streams

### Data

None.

### Example

> DELETE https://alpha-api.app.net/stream/0/streams
```js
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
```

## Retrieve a Stream

Returns a specific <a href="/appdotnet/api-spec/blob/master/objects.md#stream">Stream</a> object.

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
```js
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
```

## Delete a Stream

Delete a <a href="/appdotnet/api-spec/blob/master/objects.md#stream">Stream</a>. The Stream must belong to the current User. It returns the deleted Stream on success.

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
```js
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
```
