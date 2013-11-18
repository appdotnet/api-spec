---
title: "Send A Broadcast From The API"
---

# Send a broadcast using the API

<div class="alert alert-success alert-block">
To start sending broadcasts from the API you will need an access token. <a href='/docs/guides/create-an-app/'>Read our guide an creating an app to get an access token.</a>
</div>

Broadcast channels are mean't for low-volume high-value updates that users are interested in. Because broadcasts are built on top of our existing [Channels](/docs/resources/channel/), and [Messages](/docs/resources/message/) API there isn't much new stuff you need to know. In this guide we will go over the specifics of creating a Broadcast Channel and a Broadcast.

While you can do all of this using our API you don't have to. We have [publishers tools](https://directory.app.net/broadcast/manage/) to help you quickly get started.

* TOC
{:toc}

## Create a Broadcast Channel

Before you create your channel you should come up with a compelling title and description for your channel. Users will use this information to decide if they want to subscribe to your channel. Take an extra moment before you dive in. Also, keep in mind that users will be able to see how often your Broadcast Channel updates and may choose to not subscribe to high volume channels.

For this example, lets say we are going to create a Broadcast Channel for a food truck called Mikhail Borscht. We want to send a Broadcast every time we setup our truck. Using Broadcasts we will immediately be able to inform our customers of our location, our specials for the day, or anything that is of a timely nature.

We might title this channel:
    
    Mikhail Borscht Truck Location Updates

A good description might be:

    Mikhail Borscht is the premier borscht truck in the SF soma neighborhood. Subscribe to our broadcasts to know when we are near you and what our specials for the day will be.

Now that we have decided on a title and description we can start constructing a channel object that we will send to the API to create a broadcast channel.

**You can create channels using the API, but it might be easier to create your channel using our [publisher tools](https://directory.app.net/broadcast/manage/) instead.**

It's a good idea to start creating a channel object in a way that you can easily serialize to a JSON string. In python that might be a dict, and in JavaScript that might be an object literal. Pick the one that is right for your language.

The first part of our channel definition will be putting our title and description into an appropriate [annotation](/docs/meta/annotations/). Also, Broadcast Channels are a special type of of Channel, they have the type `net.app.core.broadcast` we will be adding that to our channel object as well.

~~~ python
channel = {
    "type": "net.app.core.broadcast",
    "annotations": [{
        "type": "net.app.core.broadcast.metadata",
        "value": {
            "title": "Mikhail Borscht Truck Location Updates.",
            "description": "Mikhail Borscht is the premier borscht truck in the SF soma neighborhood. Subscribe to our broadcasts to know when we are near you."
        }
    }]
}
~~~

We set our annotation to a type of `net.app.core.broadcast.metadata`. Then we set the value of the annotation to our title and description. Now anyone that can access the API can also know what this broadcast channel is about.

But, we aren't done creating our channel object. Next, we need to decide who can read our broadcasts, and who can send send broadcasts.

To do that we are going to add two [ACL's](/docs/resources/channel/#acl) to our channel object. A readers ACL, and an editors ACL.

This channel will be public. Public means anyone, even people who aren't App.net users, will be able to read from this Broadcast Channel. Also, since it won't make sense for the public nature of this channel to change and we don't want anyone to accidentally mark it as private, we are going to make this channel's readers ACL as immutable.

Marking an ACL immutable means we won't be able to change it after we create it. Once we have added our readers ACL our channel object should look like this.

~~~ python
channel = {
    "type": "net.app.core.broadcast",
    "readers": {
        "public": True,
        "immutable": True,
    },
    "annotations": [{
        ...
    }]
}
~~~

We need to add one more ACL to determine who can edit this channel. Being able to edit this channel means they can change the channel metadata and send broadcasts. We are only going mark two users as editors, but we are going to make the editors ACL mutable so we can change this in the future. Our updated channel object should now look something like this.

~~~ python
channel = {
    "type": "net.app.core.broadcast",
    "readers": {
        ...
    },
    "editors": {
        "user_ids": ['@samsharp', '@sfborscht'],
        "immutable": False,
    },
    "annotations": [{
        ...
    }]
}
~~~

We are now ready to create our broadcast channel. For the purposes of this demo we are going to use curl, but you should checkout the client libraries page and use a language specific library.

~~~ sh
curl -X POST -H "Authorization: Bearer <YOUR ACCESS TOKEN>"  -H "Content-Type: application/json" \
-d '{"annotations": [{"type": "net.app.core.broadcast.metadata", "value": {"description": "Mikhail Borscht is the premier borscht truck in the SF soma neighborhood. Subscribe to our broadcasts to know when we are near you.", "title": "Mikhail Borscht Truck Location Updates."}}], "type": "net.app.core.broadcast", "editors": {"user_ids": ["@samsharp", "@sfborscht"], "immutable": false}, "readers": {"public": true, "immutable": true}}' \
https://alpha-api.app.net/stream/0/channels
~~~

We will get back our channel resource. You will see that a bunch of information has been added into our channel. Our new channel also has an `id`. We can use that to address this channel in the future.

~~~ js
{
  "meta": {
    "code": 200
  },
  "data": {
    "id": "33990",
    "type": "net.app.core.broadcast",
    "counts": {
      "subscribers": 1,
      "messages": 0
    },
    "owner": {
      "name": "Sam Sharp",
      ...
    },
    "is_inactive": false,
    "readers": {
      "immutable": true,
      "you": true,
      "any_user": false,
      "user_ids": [],
      "public": true
    },
    "you_muted": false,
    "you_can_edit": true,
    "has_unread": false,
    "editors": {
      "immutable": false,
      "you": true,
      "any_user": false,
      "user_ids": [
        "190195"
      ],
      "public": false
    },
    "writers": {
      "immutable": false,
      "you": true,
      "any_user": false,
      "user_ids": [],
      "public": false
    },
    "you_subscribed": true
  }
}
~~~

We have now created a channel. We can continue to administer this channel via API, or we could use the [publishers tools](https://directory.app.net/broadcast/manage/). Either way, we are all setup to send a Broadcast.

## Send a Broadcast

A Broadcast is a message that is received as a push notification. To send a Broadcast we are going to publish a [Message](/docs/resources/message/) to a [Channel](/docs/resources/channel/).

Continuing with our example of Mikhail Borscht Food Truck, lets send a broadcast to our customers. Say we just setup our truck at 5th and mission and we want to tell them where we are.

Well, first we'll need to figure out what our subject should be. A subject is what a user will see in their push notification. It's kind of like the subject of an e-mail. It should give the user enough information so that they will know who its from and entice them to open the Broadcast. For our purposes that might be something like:

    Mikhail Borscht will be at 5th and Mission with 2 for 1 perogies till 2pm

But, we can add more information to our Broadcast. We add a text field to our message that can be up to 2048 characters. In most cases that will be significantly more characters then we will need. We shouldn't count on people to read long messages, but some extra detail could be nice. Also, you don't need to include text at all. The only required part of a Broadcast is the subject. In the case of Mikhail Borscht we might want to include our specials.

    Today the truck will be featuring a beet and goat cheese salad with candied walnuts. Also, we will be featuring beet chips made from fresh Sonoma produce.

A well formed Broadcast will have at least one annotation of type `net.app.core.broadcast.message.metadata`, which will include our subject. Optionally you can set the text field of the message as well. Now that we know what our subject and text will be we can construct a message.

Just like our channel we are going to build a message object then serialize it to JSON and post it to the API. The object will look like this. 

~~~ python
message = {
    "annotations": [{
        "type": "net.app.core.broadcast.message.metadata",
        "value": {
            "subject": "Mikhail Borscht will be at 5th and Mission with 2 for 1 perogies till 2pm"
        }
    }],
    "text": "Today the truck will be featuring a beet and goat cheese salad with candied walnuts. Also, we will be featuring beet chips made from fresh Sonoma produce."
}
~~~

Before you send the Broadcast take a second to make sure all the information is correct. This is going to be sent as a push notification to people and that push notification won't be retractable. You can always delete the Broadcast, but that won't remove all traces of it. That being said, lets send Mikhail Borscht's customers a Broadcast.

Just like building our channel we are going to use curl (remember to check out the libraries page for something language specific.)

~~~ sh
curl -X POST -H "Authorization: Bearer <YOUR ACCESS TOKEN>"  -H "Content-Type: application/json" \
-d '{"text": "Today the truck will be featuring a beet and goat cheese salad with candied walnuts. Also, we will be featuring beet chips made from fresh Sonoma produce.", "annotations": [{"type": "net.app.core.broadcast.message.metadata", "value": {"subject": "Mikhail Borscht will be at 5th and Mission with 2 for 1 perogies till 2pm"}}]}' \
https://alpha-api.app.net/stream/0/channels/33990/messages
~~~

We just sent our first broadcast. Anyone who was subscribed to our channel will now receive a push notification. This is what the message resource looks like.

~~~ js
{
  "meta": {
    "code": 200
  },
  "data": {
    "id": "1982421",
    "thread_id": "1982421",
    "user": {
      ...
    },
    "num_replies": 0,
    "entities": {
      "links": [],
      "hashtags": [],
      "mentions": []
    },
    "text": "Today the truck will be featuring a beet and goat cheese salad with candied walnuts. Also, we will be featuring beet chips made from fresh Sonoma produce.",
    "created_at": "2013-11-18T17:55:00Z",
    "channel_id": "33990",
    "source": {
      "client_id": "7pZRYcWwaxUJxw24XTHarUC7e676h8t5",
      "name": "Sam Sharps App",
      "link": "https://app.net/samsharp"
    },
    "html": "<span itemscope=\"https://app.net/schemas/Post\">Today the truck will be featuring a beet and goat cheese salad with candied walnuts. Also, we will be featuring beet chips made from fresh Sonoma produce.</span>",
    "machine_only": false
  }
}
~~~

So, in this guide we covered how to create a broadcast channel, and how to send a broadcast to all of your subscribers.


















