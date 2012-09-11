# App.net Stream API Spec

This is a living, working document. We're in the early implementation stages of this, and we'd like your feedback, suggestions and ideas. There's nothing here that's going to blow your mind — yet. But that doesn't mean this is all there's going to be — please help us make this into something much bigger than it currently is.

Please submit feedback to us — feel free to comment on commits, open issues, open pull requests, etc.

The App.net Stream API Spec project is just one part of the App.net movement. If this project is interesting to you, we'd appreciate your support. You can provide support by [backing the project](https://join.app.net) or just by participating in the process to help define it.

## Very Important Warning

**As we've started to open up the API to people as part of our early alpha program, it's important to note that this documentation is
imperfect in many ways.** In particular, we're not done implementing all of the endpoints that you see here, and sometimes what we
have written differs from this documentation. If you're running in to issues, drop us a line and we'll try to help.

**If you're submitting your application to one of Apple's App Stores, be sure you follow the special instructions for modifying your login flow in the [Authentication](/appdotnet/api-spec/blob/master/auth.md) section or your app will be rejected.**

## Table of Contents

* [Object definitions](/appdotnet/api-spec/blob/master/objects.md)
* [Resource definitions](/appdotnet/api-spec/blob/master/resources/README.md)
* [Authentication](/appdotnet/api-spec/blob/master/auth.md)

## Wait, I wanted a syndication protocol that can do X, Y and Z!

We're thinking about the best way to do this. It's something we're interested in providing, but since we've gotta start somewhere, we decided it would be best to start with an API defined in terms of things that the majority of developers are already familiar with.

We want to think big with you. What would you like to see?

## RFF — Requests for Feedback

From time to time we'll ask for feedback on specific parts of the spec in particular. Right now, focus your mental energy on:

* Object definitions, specifically:
    * Annotation definitions.
    * Entity definitions.
* Feed filters.
* Data export APIs. These are very, very important to us. If you were writing a backup tool, what would you want to see?
* Re-share, reply semantics.
* Creating objects with body content-type application/json instead of application/x-www-urlencoded.
* What do you think is missing?

## How do I get involved?

Open an issue! Submit a pull request! If you have ideas, let us know. Don't hold back — we want to hear your voice.

## Your hosts

* [Bryan Berg](http://ber.gd) ([github.com/berg](http://github.com/berg), [@berg](http://twitter.com/berg), bryan@ber.gd)
* Mark Thurman ([github.com/mthurman](http://github.com/mthurman), mthurman@gmail.com)
* [Alex Kessinger](http://alexkessinger.net) ([github.com/voidfiles](http://github.com/voidfiles), [@voidfiles](http://twitter.com/voidfiles), voidfiles@gmail.com)
* Brian Armstrong ([github.com/mxml-barmstrong](http://github.com/mxml-barmstrong))
