---
title: "Getting Started"
---

# Getting Started

The App.net API provides lots of functionality that could be useful to implement into your app. This document provides an overview of those features so you can decide what features make sense in your app. Not all apps need to (or should) use all pieces of the App.net API.

* TOC
{:toc}

## API Overview

App.net provides 5 major kinds of functionality.

* Identity and Authentication: Sign in with App.net. Streamline your app's authentication and signup processes.
* Social Graph: Find friends from App.net. Solve the "cold start" problem when a user signs into your app.
* Microblogging: Publish short public updates to App.net followers.
* Messaging: Publish short public or private updates to any App.net user(s).
* File Storage: Store files (photos, documents, videos) with App.net.

## Get started

1. [Create an app.](/docs/guides/create-an-app)
2. Generate a token for yourself and your new app.
3. Make API requests using one of our [API Libraries.](/docs/libraries)

## Notable API features

### Messaging

Channels are like a chat room. They're a time ordered series of messages that can be public, private, or restricted to a group of App.net users. The messages inside of channels can take advantage of App.net files, places, and anything else the API provides. [Chat rooms](https://directory.app.net/app/145/patter/), [Broadcasts](http://blog.app.net/2013/11/21/announcing-app-net-broadcast/), and private messages are all built on top of [App.net Messaging](/docs/guides/messaging/).

### Places

App.net has a locations database that can be integrated with your app. This allows you to add location to Posts or Message to enable location aware apps. See the [Places reference](/docs/references/resources/places/) for more information.

### Annotations

Annotations are machine readable metadata that can be attached to most App.net objects (posts, messages, users, and more). They power [checkins](https://alpha.app.net/browse/checkins/), [photos](https://alpha.app.net/browse/photos/) and other rich posts on App.net. See the [Annotations introduction](/docs/references/resources/meta/annotations/) to get started.

### Files

App.net gives each user space to store and share files. These files can be shared publicly, attached to posts, or sent as a private message to a friend. All App.net apps share the same file storage space so if a new photo or video app comes along, you can check it out and not have to worry about migrating all your old data. See the [Files reference](/docs/references/resources/files/) for more information.

## Where to get help

If you find a problem with the documentation, please [open an issue](https://github.com/appdotnet/api-spec/issues) and let us know. If you have questions about the API, the quickest way to get answers is usually the [Developer Chat Room](http://patter-app.net/room.html?channel=1383) powered by the App.net API through Patter. 

During typical San Francisco business hours, there are also App.net staff members available to answer questions in our [HipChat chat room](http://www.hipchat.com/garqCaGOZ). For other inquiries about account/service related issues, please email [support@app.net](mailto:support@app.net).
