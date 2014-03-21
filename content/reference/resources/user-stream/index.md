---
title: "User Stream"
---

# User Stream

<%= render 'partials/object-tab' %>

* TOC
{:toc}

## Overview

A User Stream is a long-lived connection that allows an app to receive real-time updates on a user's behalf. If you would like to receive information on behalf of multiple users (or process all public App.net data), please use an [App Stream](/reference/resources/app-stream). Unlike App Streams (which must be used on a server), User Streams can be used by any App.net client.

User Streams are not meant to be a global firehose from App.net. Rather, user streams are based on the idea of subscriptions. Essentially, your app makes normal API calls to App.net and then subscribes to future updates from that endpoint. Each User Stream is identified by a `connection_id` and has multiple subscriptions (which correspond to normal API endpoints) and are identified by `subscription_id`.

The User Streaming API is meant to work in conjunction with the polling endpoints seamlessly. For instance, when a user launches an App.net iPhone client the client can create a user stream, poll to fill in new posts in the User's stream since their stream marker and at the same time subscribe to any new posts in the user's stream.

Since memory and bandwidth is not unlimited, each Stream has associated limits. App.net maintains a buffer of objects to send to a client, but if that buffer fills, your Stream will be disconnected. Please ensure that you are only requesting streams of data that you can actually process.

## Getting Started

### Creating a User Stream

A client opens a User Stream by making an authenticated connection to the user stream endpoint. The authentication token may be passed in headers or the query string [like the rest of the API](/reference/authentication/#making-authenticated-api-requests).

The User Stream endpoint is `stream-channel.app.net/stream/user` and can be accessed via WebSocket or standard HTTP:

* `wss://stream-channel.app.net/stream/user`
* `https://stream-channel.app.net/stream/user`

If authentication fails or hits a rate limit, your client will be disconnected immediately with the appropriate HTTP error code.

The client can optionally supply an `connection_id` in the query string. The user stream endpoint will return the negotiated `connection_id` in HTTP headers (https) or initial message (websocket). This MAY be the same `connection_id` requested, if client was able to resume streaming on a previous endpoint. If it does NOT match, client should assume that subscriptions must be recreated, and should make efforts to backfill via the JSON API.

Other clients consuming the same `connection_id` will be disconnected. We will make a best-effort attempt to allow for replay of events upon reconnection; this behavior is designed to be available for approximately 600 seconds between connections.

### Client subscribes to updates

Based on the previous client state (if available), the client makes a number of backfill requests via the JSON API, as it would if streaming was unavailable. If a subscription is desired, the `connection_id` parameter can be supplied with each request. Creation of subscriptions is idempotent, but subscriptions are only created if:

1. `count` is zero or positive (defaults to 20), and
2. one of the following is true:
    * the `since_id` parameter was specified, the `before_id` parameter was not specified, and the `more` value in the returned `meta` object is `false`, or
    * no pagination parameters were specified, or
    * no pagination is supported on that endpoint (currently all available endpoints are paginated)

The presence of the `subscription_id` value in the returned `meta` object indicates a subscription has been created or updated.

Requests for subscriptions can also contain a `subscription_id`, which is e.g., a UUID or short mnemonic string chosen by the client designed to uniquely identify that subscription. Client-supplied `subscription_id`s are considered opaque to App.net. This will be returned in the `meta` object of each returned message, as well as the HTTP response when a subscription is created, to help with message ordering. If a `subscription_id` is not supplied, one will be generated. The (`connection_id`, `subscription_id`) tuple must be globally unique, but `subscription_id`s can be reused between user streams. Each stream can have at most 50 subscriptions. A stream could be subscribed to the same API endpoint with multiple subscription_ids. Make sure you save the returned `subscription_id` so your streaming consumer knows which API call streaming messages belong to.

Clients may begin receiving events on the stream **before** the JSON API call returns, so it is recommended that stream consumers pre-allocate subscription IDs and queue any events received until after the final subscription call returns. Subscription requests with an existing `subscription_id` will overwrite any previous subscription on that endpoint.

### Client consumes stream events

Each stream message is a JSON blob that matches the [response format](/reference/make-request/responses/#response-envelope) returned by the JSON API. If you are consuming a User Stream with WebSockets, each frame will be a separate JSON blob. If you are using the HTTP interface, the response will be encoded with `Transfer-Encoding: chunked` and each stream message is separated by `\r\n`.

Once the JSON is parsed, each message will include the `subscription_ids` which is a list of all subscriptions this message matches. If the original endpoint supported pagination, updated pagination keys `max_id`, `min_id` and `more` will be included. `more` will always be false in the case of streaming events. Events may contain multiple data objects. The `subscription_ids` should be used by your stream consumer to decide how to process the streaming event.

Ordering is not guaranteed for events delivered on streams, but we aim to have the ordering be reasonably correct. Depending on your application, you may wish to reorder items for display.

## Available Endpoints

* /stream/0/users/me/following
* /stream/0/users/me/followers
* /stream/0/users/me/posts
* /stream/0/users/me/mentions
* /stream/0/posts/stream
* /stream/0/posts/stream/unified
* /stream/0/channels (includes new messages for channels you're subscribed to)
* /stream/0/channels/:channel_id/subscribers
* /stream/0/channels/:channel_id/messages
* /stream/0/users/me/files

## Limits

* Each User Stream expires approximately 5 minutes after the connection is closed
* Each user token can create at most 5 User Streams
* Each User Stream can have at most 50 subscriptions. The same endpoint can be subscribed to multiple times.

To avoid thinking about limits, you can create User streams that automatically delete themselves once you disconnect from them. If you use this option, you will always have to recreate your subscriptions from scratch. To enable this, add the `auto_delete=1` query string parameter when connecting to a stream.

<%= curl_example(:get, "user?auto_delete=1", :none, {
    :base_url => "https://stream-channel.app.net/stream/",
    :pretty_json => false,
    :print_headers => true,
}) %>

## Subscription options

The App.net API accepts many query string parameters (`include_deleted`, `include_html`, etc) to customize and filter the data returned. These query string parameters are also respected by the User Streaming API with an important caveat. "Display options" are a connection-wide property and must be specified when a User Stream is created. "Filter options" are provided per subscription.

For example, if I never want to receive the `html` attribute over my user stream, when I connect I can specify that:

<%= curl_example(:get, "user?include_html=0", :none, {
    :base_url => "https://stream-channel.app.net/stream/",
    :pretty_json => false,
    :print_headers => true,
}) %>

But if I want to only receive File notifications for complete files, when I subscribe to my Files, I can specify that option:

<%= curl_example(:get, "users/me/files?connection_id=<YOUR CONNECTION ID>&include_incomplete=0", :none, {
    :pretty_json => false,
}) %>

The display options that may be specified when a User Stream is created are:

* include_annotations
* include_message_annotations
* include_channel_annotations
* include_user_annotations
* include_post_annotations
* include_file_annotations
* include_starred_by
* include_reposters
* include_marker
* include_recent_message
* include_html

The filter options that may be specified when creating a subscription are:

* include_incomplete
* include_private
* file_types
* channel_types
* include_read
* include_muted
* include_deleted
* include_machine
* include_directed_posts

## Deleted Objects

In general, the User Streams API tries to mimc the format and conventions of the rest of the App.net API. For deleted objects (posts, unfollows, files, etc), this isn't always possible. Deleted objects will always have `meta.is_deleted == true` and `meta.deleted_id` set to the identifier of the object that was removed. If possible, App.net will return a complete `data` object but that is not always possible.

<%= json_output({
    "meta" => {
        "is_deleted" => true,
        "deleted_id" => "1212",
        "subscription_ids" => ["bf42ca05-e67e-4e26-8bd0-8b042dd5b04c"],
        "connection_id" => "Ne1Rpr4DgmilaYUCe51aoRQpCDei14Aw"
    }
}) %>

## Examples

1. Create a User Stream:

    <%= curl_example(:get, "user", :none, {
        :base_url => "https://stream-channel.app.net/stream/",
        :pretty_json => false,
        :print_headers => true,
    }) %>

    One of the headers in the response will include a `connection_id` which you will need in the next step:

        Connection-Id: sxousNClc4Cq12du3f6GTZXNUvaHoJnFnjdOt6fH2xhJolPdDfR3rOxxjdPfPOIf

1. In a second terminal, add a subscription:

    <%= curl_example(:get, "posts/stream/unified?connection_id=<YOUR CONNECTION ID FROM STEP 2>", :none, {
        :pretty_json => false,
    }) %>

    Will return:

    <%= json_output({
        "meta" => {
            "code" => 200,
            "subscription_ids" => ["d3b72b23-f8d7-4108-a4f1-3aaa25328286"],
            "marker" => {
                "id" => "5668480",
                "last_read_id" => "5668480",
                "name" => "unified",
                "percentage" => 0,
                "updated_at" => "2013-05-14T20:18:16Z",
                "version" => "eMKC1BskFw8hL5q7FfTItiqgr4s"
            },
            "max_id" => "5675954",
            "min_id" => "5675037",
            "more" => true
        },
        "data" => [
            "... posts ..."
        ]
    }) %>

1. When you receive a message in your first terminal, it will look like:

    <%= json_output({
        "meta" => {
            "subscription_ids" => ["d3b72b23-f8d7-4108-a4f1-3aaa25328286"],
            "min_id" => "5675993",
            "max_id" => "5675993",
            "connection_id" => "<YOUR CONNECTION ID FROM STEP 2>",
            "more" => false
        },
        "data" => [
            "... posts ..."
        ]
    }) %>

<%= render 'partials/endpoints-tab', :for => "user-stream" %>
