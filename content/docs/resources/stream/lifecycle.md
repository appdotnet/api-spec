# Stream Lifecycle

## Create a Stream

Create a <a href="../objects/stream.md">Stream</a> for the current token.

Send a JSON document that matches the  <a href="../objects/stream.md">stream schema</a> with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```object_types```, ```type``` and ```filter_id```. If you don't want to specify a filter, omit ```filter_id```.

<%= render 'partials/migration' %>

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

<%= render 'partials/migration' %>

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

<%= render 'partials/migration' %>

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

<%= render 'partials/migration' %>

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

<%= render 'partials/migration' %>

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
