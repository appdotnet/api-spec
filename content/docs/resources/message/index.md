---
title: "Message"
---

# Message

<%= render 'partials/object-tab' %>

* TOC
{:toc}

A Message is very similar to a [Post](/docs/resources/post/) but 1) it doesn't have to be public and 2) it will be delivered to an arbitrary set of users (not just the users who follow the Message creator). For an overview of the App.net messaging API, please see the [Introduction to App.net Messaging](/docs/basics/messaging/).

~~~ js
{
    "channel_id": "1",
    "created_at": "2012-12-11T00:31:49Z",
    "entities": {
        "hashtags": [],
        "links": [],
        "mentions": []
    },
    "html": "<span itemscope=\"https://app.net/schemas/Post\">Hello channel!</span>",
    "id": "103",
    "machine_only": false,
    "num_replies": 0,
    "source": {
        "client_id": "UxUWrSdVLyCaShN62xZR5tknGvAxK93P",
        "link": "https://app.net",
        "name": "Test app"
    },
    "text": "Hello channel!",
    "thread_id": "103",
    "user": {
        ...
    }
}
~~~

## Fields

<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>id</code></td>
        <td>string</td>
        <td>Primary identifier for a message. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
    </tr>
    <tr>
        <td><code>channel_id</code></td>
        <td>string</td>
        <td>The id of the channel this message belongs to. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
    </tr>
    <tr>
        <td><code>user</code></td>
        <td>object</td>
        <td>This is an embedded version of the <a href='/docs/resources/user/'>User</a> object. <b>Note:</b> In certain cases (e.g., when a user
                account has been deleted), this key may be omitted.</td>
    </tr>
    <tr>
        <td><code>created_at</code></td>
        <td>string</td>
        <td>The time at which the message was create in <a href='http://en.wikipedia.org/wiki/ISO_8601'>ISO 8601</a> format.</td>
    </tr>
    <tr>
        <td><code>text</code></td>
        <td>string</td>
        <td>User supplied text of the message.</td>
    </tr>
    <tr>
        <td><code>html</code></td>
        <td>string</td>
        <td>Server-generated annotated HTML rendering of message text.</td>
    </tr>
    <tr>
        <td><code>source</code></td>
        <td>object</td>
        <td>
            <br>
            <table>
                <tr>
                    <th>Field</th>
                    <th>Type</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td><code>name</code></td>
                    <td>string</td>
                    <td>Description of the API consumer that created this message.</td>
                </tr>
                <tr>
                    <td><code>link</code></td>
                    <td>string</td>
                    <td>Link provided by the API consumer that created this message.</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td><code>reply_to</code></td>
        <td>string</td>
        <td>The id of the message this message is replying to (or <code>null</code> if not a reply).</td>
    </tr>
    <tr>
        <td><code>thread_id</code></td>
        <td>string</td>
        <td>The id of the post at the root of the thread that this message is a part of. If <code>thread_id==id</code> than this property does not guarantee that the thread has > 1 message. Please see <code>num_replies</code>.</td>
    </tr>
    <tr>
        <td><code>num_replies</code></td>
        <td>integer</td>
        <td>The number of messages created in reply to this message.</td>
    </tr>
    <tr>
        <td><code>annotations</code></td>
        <td>list</td>
        <td>Metadata about the entire message. See the <a href="/docs/meta/annotations/">Annotations</a> documentation.</td>
    </tr>
    <tr>
        <td><code>entities</code></td>
        <td>object</td>
        <td>Rich text information for this message. See the <a href="/docs/meta/entities/">Entities</a> documentation.</td>
    </tr>
    <tr>
        <td><code>is_deleted</code></td>
        <td>boolean</td>
        <td>Has this message been deleted? For non-deleted posts, this key may be omitted instead of being <code>false</code>. If a message has been deleted, the <code>text</code>, <code>html</code>, and <code>entities</code> properties will be empty and may be omitted.</td>
    </tr>
    <tr>
        <td><code>machine_only</code></td>
        <td>boolean</td>
        <td>Is this Message meant for humans or other apps? See <a href="#machine-only-messages">Machine only Messages</a> for more information.</td>
    </tr>
</table>

## Message Annotations

Message annotations are immutable attributes that describe the entire message. Please see the [Annotations](/docs/meta/annotations/) documentation for more information.

## Machine only Messages

Sometimes a Message is not meant for human consumption but it may be readable by an App of some kind. In that case, you can create a Machine only Message by including ```annotations``` and not including ```text```. You can request Machine only Messages using the ```include_machine=1``` query string parameter.

<%= render 'partials/endpoints-tab', :for => "message" %>
