# Messaging

The App.net Messaging API allows a User to create public, private, semi-private  messages between an arbitrary number of users. If you'd like to create public messages that your App.net followers see in their streams, you should [create a post](https://github.com/appdotnet/api-spec/blob/master/resources/posts.md#create-a-post). If you need a more flexible messaging solution, than this API is for you.

## Introduction to App.net Messaging

Our messaging API is built around 2 central objects: [Messages](https://github.com/appdotnet/api-spec/blob/master/objects.md#message) and [Channels](https://github.com/appdotnet/api-spec/blob/master/objects.md#channel). If you're familiar with the App.net API, here are some analogies:

* Messages are like Posts
* Channels are like streams of Posts
* Stream markers work on Channels just like they work on streams of Posts

When you create a Channel, you decide who can read and write to that channel. This flexibility lets you:

* Create a private group chat between N App.net users
* Create a moderated group that can be read by a set of users and written to by a different set of users
* Create a chat room where App.net users can read and write messages while their in the room and leave whenever they want

If a user is authorized to read a Channel, they can also subscribe to a channel. This allows you to keep track of channels an messages at a more granular level.

## Getting started

TODO
explain different scopes
explain app tokens
explain 403 vs 404
channel annotations are mutable

## Channel types

* [Private Message](#private-message): net.app.core.pm

### Private Message

> net.app.core.pm

This channel type is for private messages between 2 or more people. It enforces that there is at least one non-owner user_id in the ```writers``` ACL and that both ACLs are immutable.
