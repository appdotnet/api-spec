---
title: "App Stream Lifecycle"
---

# App Stream Lifecycle

* TOC
{:toc}

## Create a Stream

Create a [Stream](/docs/resources/app-stream/) for the current token.

Send a JSON document that matches the [stream schema](/docs/resources/app-stream/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```object_types```, ```type```, ```filter_id``` and ```key```. If you don't want to specify a filter, omit ```filter_id```. If you don't want to specify a key, omit ```key```.

You can create up to 5 streams per App token.

<%= endpoint "POST", "streams", "App" %>

#### POST Data

A JSON object representing the stream to create. See [the stream object](/docs/resources/app-stream/) for more information. Specify ```filter_id``` instead of ```filter``` if you want to filter this stream. (Omit the ```id``` and ```endpoint``` parameters).

#### Example

> POST https://alpha-api.app.net/stream/0/streams
> 
> Content-Type: application/json
> 
> DATA {"object_types": ["post"], "type": "long_poll", "filter_id": "1", "key": "rollout_stream"}

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

Returns a specific [Stream](/docs/resources/app-stream/) object.

<%= endpoint "GET", "streams/[stream_id]", "App" %>

<%= url_params [
    ["stream_id", "The id of the Stream to retrieve."]
]%>

#### Example

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

Return the [Streams](/docs/resources/app-stream/) for the current token.

<%= endpoint "GET", "streams", "App" %>

<%= query_params [
    ["key", "(Optional) Only retrieve the stream that matches the given key."]
]%>

#### Example

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

## Update a Stream

Update a [Stream](/docs/resources/app-stream/). You can update a Stream by PUTing a JSON document that matches the [stream schema](/docs/resources/app-stream/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```object_types```, ```type```, ```filter_id``` and ```key```. If you don't want to specify a filter, omit ```filter_id```. If you don't want to specify a key, omit ```key```.

<%= endpoint "PUT", "streams/[stream_id]", "App" %>

<%= url_params [
    ["stream_id", "The id of the Stream to update."]
]%>

#### Example

> PUT https://alpha-api.app.net/stream/0/streams/1
> 
> Content-Type: application/json
> 
> DATA {"object_types": ["post","star"], "type": "long_poll", "id": "1", "filter_id": "1", "key": "rollout_stream"}

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
            "post",
            "star"
        ],
        "type": "long_poll",
        "key": "rollout_stream"
    },
    "meta": {
        "code": 200
    }
}
~~~

## Delete a Stream

Delete a [Stream](/docs/resources/app-stream/). The Stream must belong to the current User. It returns the deleted Stream on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/docs/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "streams/[stream_id]", "App" %>

<%= url_params [
    ["stream_id", "The id of the Stream to delete."]
]%>

#### Example

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

Delete all [Streams](/docs/resources/app-stream/) for the current token. It returns the deleted Streams on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/docs/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "streams", "App" %>

#### Example

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
