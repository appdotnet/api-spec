---
title: "App Stream Lifecycle"
---

# App Stream Lifecycle

* TOC
{:toc}

## Create a Stream

Create a [Stream](/reference/resources/app-stream/) for the current token.

Send a JSON document that matches the [stream schema](/reference/resources/app-stream/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```object_types```, ```type```, ```filter_id``` and ```key```. If you don't want to specify a filter, omit ```filter_id```. If you don't want to specify a key, omit ```key```.

You can create up to 5 streams per App token.

<%= endpoint "POST", "streams", "App" %>

#### POST Data

A JSON object representing the stream to create. See [the stream object](/reference/resources/app-stream/) for more information. Specify ```filter_id``` instead of ```filter``` if you want to filter this stream. (Omit the ```id``` and ```endpoint``` parameters).

#### Example

<% data = {
    "object_types" => ["post"],
    "type" => "long_poll",
    "filter_id" => "1",
    "key" => "rollout_stream"
} %>
<%= curl_example(:post, "streams", :app_stream, {:data => data, :token => "<YOUR APP TOKEN>"})%>


## Retrieve a Stream

Returns a specific [Stream](/reference/resources/app-stream/) object.

<%= endpoint "GET", "streams/[stream_id]", "App" %>

<%= url_params [
    ["stream_id", "The id of the Stream to retrieve."]
]%>

#### Example

<%= curl_example(:get, "streams/1", :app_stream, {:token => "<YOUR APP TOKEN>"}) %>

## Get current token's Streams

Return the [Streams](/reference/resources/app-stream/) for the current token.

<%= endpoint "GET", "streams", "App" %>

<%= query_params [
    ["key", "(Optional) Only retrieve the stream that matches the given key."]
]%>

#### Example

<%= curl_example(:get, "streams?key=rollout_stream", :app_stream, {:response => :collection, :token => "<YOUR APP TOKEN>"}) %>

## Update a Stream

Update a [Stream](/reference/resources/app-stream/). You can update a Stream by PUTing a JSON document that matches the [stream schema](/reference/resources/app-stream/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```object_types```, ```type```, ```filter_id``` and ```key```. If you don't want to specify a filter, omit ```filter_id```. If you don't want to specify a key, omit ```key```.

<%= endpoint "PUT", "streams/[stream_id]", "App" %>

<%= url_params [
    ["stream_id", "The id of the Stream to update."]
]%>

#### Example

<% data = {
    "object_types" => ["post","star"],
    "type" => "long_poll",
    "filter_id" => "1",
    "key" => "rollout_stream"
} %>
<%= curl_example(:put, "streams/1", :app_stream, {:data => data, :token => "<YOUR APP TOKEN>"}) do |h|
    h["data"]["object_types"] = data["object_types"]
end %>

## Delete a Stream

Delete a [Stream](/reference/resources/app-stream/). The Stream must belong to the current User. It returns the deleted Stream on success.

If you'd like your app stream to be automatically deleted when you disconnect from it, please add the [`auto_delete=1`](/reference/resources/user-stream/#limits) query string parameter when you connect to your app stream.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/reference/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "streams/[stream_id]", "App" %>

<%= url_params [
    ["stream_id", "The id of the Stream to delete."]
]%>

#### Example

<%= curl_example(:delete, "streams/1", :app_stream, {:token => "<YOUR APP TOKEN>"}) %>

## Delete all of the current user's Streams

Delete all [Streams](/reference/resources/app-stream/) for the current token. It returns the deleted Streams on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/reference/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "streams", "App" %>

#### Example

<%= curl_example(:delete, "streams", :app_stream, {:response => :collection, :token => "<YOUR APP TOKEN>"}) %>
