---
title: "Home"
---

# App.net API Documentation

App.net is a developer-friendly social infrastructure platform. Our API is the primary interface by which developers interact with the platform. The documentation is broken into two parts: these guides and our [full API reference](/reference/).

## Quick Start

The App.net API is powerful and flexible -- if you're new to the API, we suggest you start with these guides.

<div class="promo-block-wrapper ta-center">
    <div class="yui3-g">
        <div class="yui3-u-1-2">
            <div class="promo-block">
                <div class="promo-block-inner">
                    <a class="overlay" href="/docs/guides/send-a-broadcast/"></a>
                    <div class="promo-block-image"></div>
                    <h3 class="heading-with-hr dark">
                        <span>Quick Start: Broadcast</span><hr>
                    </h3>
                    <p class="note-style">Send a broadcast with the App.net API.</p>
                </div>
            </div>
        </div>
        <div class="yui3-u-1-2">
            <div class="promo-block">
                <div class="promo-block-inner">
                    <a class="overlay" href="/reference/authentication/"></a>
                    <div class="promo-block-image authentication"></div>
                    <h3 class="heading-with-hr dark">
                        <span>Quick Start: Authentication</span><hr>
                    </h3>
                    <p class="note-style">Learn how to make authenticated requests to the API.</p>
                </div>
            </div>
        </div>
    </div>
</div>

## Notable API features

### Identity & Authentication

Use App.net's identity layer to authenticate users and populate user profiles. For more information, see the [Authentication reference](/reference/authentication/) and [User reference](/reference/resources/user/).

### Social Graph

App.net has a asymmetrical (follower-following) social graph which can be used to solve the "cold start" problem when a user signs into your app. The [Following reference](/reference/resources/user/following/) has more details.

### Messaging

Channels are like chat rooms. They're a time ordered series of messages that can be public, private, or restricted to a group of App.net users. The messages inside of channels can take advantage of App.net files, places, and anything else the API provides. [Chat rooms](https://directory.app.net/app/145/patter/), [Broadcasts](http://blog.app.net/2013/11/21/announcing-app-net-broadcast/), and private messages are all built on top of [App.net Messaging](/docs/guides/messaging/).

### Places

App.net has a location database that can be integrated with your app. This allows you to add location to Posts or Message to enable location aware apps. See the [Places reference](/docs/references/resources/places/) for more information.

### Annotations

Annotations are machine readable metadata that can be attached to most App.net objects (posts, messages, users, and more). They power [checkins](https://alpha.app.net/browse/checkins/), [photos](https://alpha.app.net/browse/photos/) and other rich posts on App.net. See the [Annotations introduction](/docs/references/resources/meta/annotations/) to get started.

### Files

App.net gives each user space to store and share files. These files can be shared publicly, attached to posts, or sent as a private message to a friend. All App.net apps share the same file storage space so if a new photo or video app comes along, you can check it out and not have to worry about migrating all your old data. See the [Files reference](/docs/references/resources/files/) for more information.


## Tracking news and announcements

To see the latest updates to the API, follow [@adnapi](http://alpha.app.net/adnapi). You may also want to subscribe to the [App.net blog](https://broadcast.app.net/26283/appnet-blog/) for general news and the [App.net API Updates](https://broadcast.app.net/24368/appnet-api-updates/) Broadcast channel for developer related news.

## Getting help and providing feedback

There are numerous ways for developers to get help utilizing the platform and to provide feedback.

* Developers (including App.net staff) are often chatting in the [Developer Channel](http://patter-app.net/room.html?channel=1383).
* For developer inquiries about the API, our Terms of Service, letting us know about something you're working on, etc., email [developers@app.net](mailto:developers@app.net).
* For general inquiries about account/service related issues, email [support@app.net](mailto:support@app.net).
* In addition to the above, you can report bugs and provide feedback on the API using the [issue tracker](https://github.com/appdotnet/api-spec/issues).
* This documentation is open source. If you find an error or something that's unclear, let us know with a pull request or issue on the [Github repo for the documentation](https://github.com/appdotnet/api-spec/).

## Your hosts

* [Bryan Berg](http://ber.gd) ([@berg](https://alpha.app.net/berg), [bryan@app.net](mailto:bryan@app.net))
* Mark Thurman ([@mthurman](https://alpha.app.net/mthurman), [mthurman@app.net](mailto:mthurman@app.net))
* [Alex Kessinger](http://alexkessinger.net) ([@voidfiles](https://alpha.app.net/voidfiles), [alex@app.net](mailto:alex@app.net))
* Brian Armstrong ([@barmstrong](https://alpha.app.net/barmstrong), [barmstrong@app.net](mailto:barmstrong@app.net))
