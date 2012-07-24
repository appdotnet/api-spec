# Streams

## General Information

### Basic Use

A Stream is a real-time, ordered collection of Posts.

There are 3 different kinds of Streams, but they all follow the same pattern:

* User stream: A Stream for a single User's view of App.net. This is a Stream version of the [Retrieve a User's personalized stream]
(/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-users-personalized-stream) endpoint. It is very useful for client
based Apps that need a single User's Stream. **It must be accessed with a User access token**.
* App stream: A Stream for Apps to request multiple Users Streams at once. It is very useful for server based Apps that need the
streams of lots of users. **It must be accessed with an App access token**.
* Public stream: A Stream containing all public Posts. **It must be accessed with an App access token**.

Once a Stream has been created through one of the following endpoints, you will receive a link representing the Stream which can be
used to alter the Stream's contents and check the status. Please refer to the [Stream control endpoint](#control-a-stream) and
[Stream status endpoint](#get-stream-status) documentation.

Since memory and bandwidth is not unlimited, each Stream has associated limits. App.net maintains a buffer of Posts to send to a
client, but if that buffer fills, your Stream will be disconnected. Please ensure that you are only requesting streams of data that
you can actually process. If you find that you are falling behind, we provide mechanisms for you to sample a Stream instead of
receiving every Post.

### Filters

Streams will give you lots of data, much of which your application may not want. A [Filter](/appdotnet/api-spec/blob/master/objects.md#filter) can be passed to any of the following endpoints at creation time, or can be passed to the [Stream control endpoint](#control-a-stream) after a Stream exists. These filters will determine what messages are actually delivered to your App by our servers.

### Response Format

A Stream is a long-lived HTTP connection that enables clients to receive Posts in near real-time from App.net.

When a Stream is established, App.net will send a response code of ```201 Created``` if successful. The ```Location``` header will
contain a link representing the new stream. This link will allow the client to check the status of the stream (what are the current
filters, how full the Stream buffer is, etc.) and alter the Stream (adjust filters, sample Posts, etc.).

The response will be encoded using HTTP ```Transfer-Encoding: chunked```.

The Stream contains frames separated by ```\r\n```. Each frame consists of a message prepended by the length of the message and
```\r\n```. For example:


    9\r\nHELLO\r\n4\r\n\r\n12\r\nWORLD!!!\r\n


Each message is either a [Post](/appdotnet/api-spec/blob/master/objects.md#post), a [control message](#control-message), or an empty
line. An empty line will be sent when there are no other messages in order to keep the connection alive.

#### Control Message

A control message is a JSON object that gives the client important information about the current Stream. For instance, if the buffer
is getting too full, the client will receive a control message with that warning. A control message will always have ```control```
as a key in the object so it is easy to distinguish from a Post.


## Retrieve a real-time, personalized Stream for a User

Retrieve a personalized [Stream](#streams) for the current authorized User. This endpoint is similar to the '[Retrieve a User's personalized stream](/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-users-personalized-stream)' endpoint.

### URL
> https://api.app.net/stream/0/streams/user

### Parameters

*See [Filters](#filters) for optional filters you can use with this query.*

### Example

> GET https://api.app.net/stream/0/streams/user
>
> *See [Response Format](#response-format) for details about the response.*



## Retrieve a real-time, personalized Stream for multiple Users

Retrieve a personalized [Stream](#streams) for the specified users. This endpoint is similar to the '[Retrieve a User's personalized stream](/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-users-personalized-stream)' endpoint.

### URL
> https://api.app.net/stream/0/streams/app

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
            <td><code>user_ids</code></td>
            <td>Required</td>
            <td>string</td>
            <td>A JSON encoded list of the user ids whose Streams should be returned</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://api.app.net/stream/0/streams/app?user_ids=%5B%221%22%5D
>
> *See [Response Format](#response-format) for details about the response.*


## Retrieve a public Stream of real-time posts

Retrieve a [Stream](#streams) of all public Posts on App.net.

### URL
> https://api.app.net/stream/0/streams/public

### Parameters

*See [Filters](#filters) for optional filters you can use with this query.*

### Example

> GET https://api.app.net/stream/0/streams/public
>
> *See [Response Format](#response-format) for details about the response.*


## Get Stream status

Retrieve the current status for a specific [Stream](#stream)

### URL
> https://api.app.net/stream/0/streams/[stream_id]

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
            <td><code>stream_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The stream id.</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://api.app.net/stream/0/streams/abc123
```js
{
    "sent": 128,
    "buffer": 0.8,
    "filters": [{
        "name": "hashtag",
        "value": "joinus"
    },
    {
        "name": "domain",
        "value": "join.app.net"
    }],
    "links": {
        "self": "https://api.app.net/stream/0/streams/abc123"
    }
}
```


## Control a Stream

Change the Posts returned in the specified Stream.

### URL
> https://api.app.net/stream/0/streams/[stream_id]

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
            <td>The stream id.</td>
        </tr>
    </tbody>
</table>

*See [Filters](#filters) for optional filters you can use with this query.*

### Example

> POST https://api.app.net/stream/0/streams/abc123
>
> DATA mention=berg
```js
{
    "sent": 128,
    "buffer": 0.8,
    "filters": [{
        "name": "hashtag",
        "value": "joinus"
    },
    {
        "name": "domain",
        "value": "join.app.net"
    },
    {
        "name": "mention",
        "value": "berg"
    }],
    "links": {
        "self": "https://api.app.net/stream/0/streams/abc123"
    }
}
```
