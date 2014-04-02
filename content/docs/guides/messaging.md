---
title: "Messaging Overview"
---

# App.net Messaging

The App.net Messaging API allows a User to create public, private, semi-private  messages between an arbitrary number of users. If you'd like to create public messages that your App.net followers see in their streams, you should [create a post](/reference/resources/post/lifecycle/#create-a-post) with the Stream API. If you need a more flexible messaging solution, the Messaging API is for you.

Our messaging API is built around 2 central objects: [Channels](/reference/resources/channel/) and [Messages](/reference/resources/message/). If you're familiar with the App.net Stream API, here are some analogies:

* Messages are like Posts
* Channels are like streams of Posts
* Stream markers work on Channels just like they work on streams of Posts

When you create a Channel, you decide who can read and write to that channel. This flexibility lets you:

* Create a private group chat between multiple App.net users
* Create a moderated group that can be read by a set of users and written to by a different set of users
* Create a chat room where App.net users can read and write messages while they're in the room and leave whenever they want

If a user is authorized to read a Channel, they can also subscribe to a channel. This allows you to keep track of channels an messages at a more granular level.

## Authorization

Access to Messages in a given Channel is determined by the [ACL fields](/reference/resources/channel/#acl-fields) on the Channel itself.

Channels can be public or private. For the purpose of access tokens, a Channel is considered public if it is readable by unauthenticated users (the `public` flag) or any authenticated ADN user (the `any_user` flag).

Application access to messages is governed by two scopes: `messages` and `public_messages`. The `messages` scope grants a superset of the permissions granted by the `public_messages` scope — it is unnecessary to request both scopes for a given application. The difference between the two is that only public Channels are visible to applications authorized with the `public_messages` scope.

In addition, an App access token has read access to a Channel and its contents when:

1. the Channel is public, or
2. the Channel is private, and at least one user with read permission has authorized the application with the `messages` scope.

## Subscriptions

Users indicate their interest in a given channel by subscribing to it. When a channel is created, no one is subscribed to it.

[Private message channels](/reference/resources/channel/#private-message) (type `net.app.core.pm`) auto-subscribe all participants to the channel in accordance with each user's [subscription preferences](https://account.app.net/settings/privacy/#messaging).

To get this same behavior for non-pm channels, you include the key `auto_subscribe: true` when you create or update the Channel. This will auto-subscribe all the users on the ACLs (according to their preferences).

If a user has [muted a channel](/reference/resources/channel/muting/#mute-a-channel) they will never be auto-subscribed to it.

## Annotations

Both Channel and Message objects allow for annotations; however, the details of each annotation implementation vary. Channel annotations act like User annotations — they are unique by type and mutable by the Channel's owner. Message annotations act like Post annotations — they are immutable.

## Markers

The unread state of each Channel is tracked by a stream marker like those used for Posts. We suggest you do not advance a channel stream marker in reverse. When requested with a specific user token, each Channel exposes whether it contains a newer Message than the current marker position for the purpose of displaying an 'unread' indicator.

## Streaming

Messages, channel updates and marker updates are pushed as objects over the streaming API. Channel permissions for the streaming API are related to the App access token as described above. Objects retrieved from the streaming API are not personalized to a given user.

## Types

Much like annotation types, channel types are freeform strings; we suggest you use a reversed-domain format for any custom channel types. Core channel types are prefixed with `net.app.core` and may have additional validation imposed by the App.net API. Currently defined core channel types are:

* [Private Message](/reference/resources/channel/#private-message): net.app.core.pm
* [Broadcast Channel](/reference/resources/channel/#broadcast-channel): net.app.core.broadcast
