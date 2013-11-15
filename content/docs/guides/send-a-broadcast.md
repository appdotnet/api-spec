---
title: "Send A Broadcast From The API"
---

# Send a broadcast from the API

<div class="alert alert-success alert-block">
To start sending broadcasts from the API you will need an access token. <a href='/docs/guides/create-an-app/'>Read our guide an creating an app to get an access token.</a>
</div>

Broadcast channels are mean't for low-volume high-importance updates that users are interested in. Because broadcasts are built on top of our existing [Channels](), and [Messages]() API there isn't a lot of new stuff you need to know. In this guide we will go over the specfics of creating broadcast channels, and broadcast messages.

A broadcast channel has a type if  `net.app.core.broadcast` and a metadata annotation. A broadcast is a message with a type of  `net.app.core.broadcast.message`.

While there are no hard limits now, 

* TOC
{:toc}

## Creating a Broadcast Channel

Before you create your channel you should come up with a unique, compelling title and description for your channel. Users will use this information to decide if they want to subscribe to your channel, or not, so take an extra moment.

Once you know your information we can construct a JSON object that we will send to the API to create a broadcast channel.

Lets say we are going to create a broadcast channel for a food truck called Mikhail Borscht. We are creating a channel so that we can send a broadcast every time we setup our truck. This will immediately update our customers as to where we are and they can make the decision to come eat at our truck.

We might title this channel:
    
    Mikhail Borscht Truck Location Updates.

A good description might be:

    Mikhail Borscht is the premier borscht truck in the SF soma neighborhood. Subscribe to our broadcasts to know when we are near you.

Now that we know what our meta data will be we can start building our channel definition. We will start with our metadata annotation.

~~~ js
channel = {
    "annotations": {
        "type": "net.app.core.broadcast",
        "value": {
            "title": "Mikhail Borscht Truck Location Updates.",
            "description": "Mikhail Borscht is the premier borscht truck in the SF soma neighborhood. Subscribe to our broadcasts to know when we are near you."
        }
    }
}
~~~

But, we aren't done. There are a couple of other decisions we need to make. First, while channels can be private, this channel will be public. Public means anyone, even people who aren't App.net users, will be able to read this channel, and receive broadcasts. Also, since this is public channel, we don't want anyone to accidentally mark it as private so we are going to make this channel immutable. Making an ACL immutable means you won't be able to change it after you create it. We will need to add some data to the channel definition to make this so.

~~~ js
channel = {
    "readers": {
        "public": true,
        "immutable": true,
    },
    "annotations": {
        "type": "net.app.core.broadcast",
        "value": {
            "title": "Mikhail Borscht Truck Location Updates.",
            "description": "Mikhail Borscht is the premier borscht truck in the SF soma neighborhood. Subscribe to our broadcasts to know when we are near you."
        }
    }
}
~~~

Finally, we need to add one more ACL to determine who can edit this channel. Being able to edit this channel means they can change the channel meta data as well as send broadcasts to subscribers. We are only going to let two people send broadcasts to our channel, but we are going to make the editors mutable so we can change this in the future.

~~~ js
channel = {
    "readers": {
        "public": true,
        "immutable": true,
    },
    "editors": {
        "user_ids": ['@samsharp', '@sfborscht'],
        "immutable": false,
    },
    "annotations": {
        "type": "net.app.core.broadcast",
        "value": {
            "title": "Mikhail Borscht Truck Location Updates.",
            "description": "Mikhail Borscht is the premier borscht truck in the SF soma neighborhood. Subscribe to our broadcasts to know when we are near you."
        }
    }
}
~~~

Okay, now we are ready to create our broadcast channel.







