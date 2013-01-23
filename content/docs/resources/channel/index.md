---
title: "Channel"
---

# Channel

<%= render 'partials/object-tab' %>

* TOC
{:toc}

A Channel is a user created stream of Messages. It controls access to the messages in the channel allowing for (among other things) public, private, and group messaging. For an overview of the App.net messaging API, please see the [Introduction to App.net Messaging](/docs/basics/messaging/).

~~~ js
{
    "counts": {
        "messages": 42
    },
    "has_unread": true,
    "id": "1",
    "owner": {
        ...
    },
    "marker": {
        ...
    },
    "readers": {
        "any_user": false,
        "immutable": true,
        "public": false,
        "user_ids": [],
        "you": true
    },
    "recent_message_id": "231",
    "recent_message": {
        ...
    },
    "type": "net.app.core.pm",
    "writers": {
        "any_user": false,
        "immutable": true,
        "public": false,
        "user_ids": [
            "1",
        ],
        "you": true
    },
    "you_can_edit": false,
    "you_subscribed": true
}
~~~

## Fields

<table>
    <thead>
        <tr>
            <th>Field</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>counts</code></td>
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
                        <td><code>messages</code></td>
                        <td>integer</td>
                        <td>The number of messages in the channel.</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td><code>id</code></td>
            <td>string</td>
            <td>Primary identifier for a channel. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
        </tr>
        <tr>
            <td><code>type</code></td>
            <td>string</td>
            <td>A string that looks like a reversed domain name to identify the intended purpose of this channel. <em>There is no authentication or authorization performed on this field. Just because you create annotations with the type <code>com.example.awesome</code> does not imply you are the only one that is using that namespace or that the channel ACLs will match the format you expect</em>. <code>net.app.core</code> is a reserved namespace.</td>
        </tr>
        <tr>
            <td><code>owner</code></td>
            <td>User object</td>
            <td>This is an embedded version of the <a href='/docs/resources/user/'>User</a> object. <b>Note:</b> In certain cases (e.g., when a user account has been deleted), this key may be omitted.</td>
        </tr>
        <tr>
            <td><code>annotations</code></td>
            <td>list</td>
            <td>Metadata about the channel. See the <a href="/docs/meta/annotations/">Annotations</a> documentation.</td>
        </tr>
        <tr>
            <td><code>readers</code></td>
            <td><a href="#acl">ACL object</a></td>
            <td>The access control list that describes who can read this channel and its messages.</td>
        </tr>
        <tr>
            <td><code>writers</code></td>
            <td><a href="#acl">ACL object</a></td>
            <td>The access control list that describes who can write messages to this channel.</td>
        </tr>
        <tr>
            <td><code>you_subscribed</code></td>
            <td>boolean</td>
            <td>Are you currently subscribed to this channel. There are many channels you could have access to read and this indicates whether you are "following" this channel.</td>
        </tr>
        <tr>
            <td><code>you_can_edit</code></td>
            <td>boolean</td>
            <td>Can you edit the channel.</td>
        </tr>
        <tr>
            <td><code>has_unread</code></td>
            <td>boolean</td>
            <td>Are there unread messages in this channel (according to the `last_read_id` of the stream marker you have saved for this channel)?</td>
        </tr>
        <tr>
            <td><code>marker</code></td>
            <td>Stream Marker object</td>
            <td>The full stream marker object for this channel. Only sent if using a user access token and requested by the `include_marker=1` query string parameter.</td>
        </tr>
        <tr>
            <td><code>recent_message_id</code></td>
            <td>string</td>
            <td>The ID of the most recent message in this channel. Includes deleted messages.</td>
        </tr>
        <tr>
            <td><code>recent_message</code></td>
            <td>Message object</td>
            <td>The most recent message in this channel. Includes deleted messages. Included in messages pushed via the streaming API, but must be requested with the `include_recent_message=1` query string parameter elsewhere.</td>
        </tr>
    </tbody>
</table>

## Channel Annotations

Channel annotations are mutable attributes that describe the channel. Please see the [Annotations](/docs/meta/annotations/)  documentation for more information.

## ACL

~~~ js
"readers": {
    "any_user": false,
    "immutable": false,
    "public": false,
    "user_ids": [],
    "you": true
},
"writers": {
    "any_user": false,
    "immutable": false,
    "public": false,
    "user_ids": [
        "1",
        "2",
        "3"
    ],
    "you": true
}
~~~

Access control lists (ACLs) specify who can read and who can write Messages in a Channel. In our permissions model, writing implies reading. Note that ```any_user```, ```public```, and non-empty ```user_ids``` are all mutually exclusive (only one of those can be true at a time). Also, the creator of a Channel always has write access and will not be specified in the ```user_ids``` list. For some channel types (like ```net.app.core.pm```), the ACLs will be sanitized to make sure they fit a specific schema. Please see the [Messaging overview](/docs/basics/messaging/) for more information.

### ACL Fields

<table>
    <thead>
        <tr>
            <th>Field</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>any_user</code></td>
            <td>boolean</td>
            <td>Can any logged in App.net user read/write to this channel? If true, <code>public</code> will be false and <code>user_ids</code> will be empty.</td>
        </tr>
        <tr>
            <td><code>immutable</code></td>
            <td>boolean</td>
            <td>Can this ACLs be changed? In general, we recommend creating immutable Channels so a user's messages can't "leak out" of a channel later.</td>
        </tr>
        <tr>
            <td><code>public</code></td>
            <td>boolean</td>
            <td>Can anyone (including not logged in users), read this channel. This will always be false for the <code>writers</code> ACL. If true, <code>any_user</code> will be false and <code>user_ids</code> will be empty.</td>
        </tr>
        <tr>
            <td><code>user_ids</code></td>
            <td>list</td>
            <td>A list of strings specifying the user ids who can read/write to this channel. If non-empty, <code>any_user</code> and <code>public</code> will be false. This list can contain at most 200 user ids.</td>
        </tr>
        <tr>
            <td><code>you</code></td>
            <td>boolean</td>
            <td>Can the authorized user for the current token read/write to this channel? This field, unlike the others, respects the permission hierarchy. To test channel writeability, you need only examine this field.</td>
        </tr>
    </tbody>
</table>


## Channel types

* [Private Message](#private-message): net.app.core.pm

### Private Message

> net.app.core.pm

This channel type is for private messages between 2 or more people. As a core Channel type, it has some special restrictions designed to simplify adoption for developers. Arbitrary channel types are available for use which do not have these restrictions (and are able to maintain the same level of privacy.)

Private message channels enforce that there is at least one non-owner user_id in the ```writers``` ACL and that both ACLs are immutable. Messages with the `machine_only` flag set are disallowed (though, of course, annotations are permitted when accompanied with text.)

In addition, this channel type differs from others in that it is designed to provide a simple, combined API for channel creation, reuse and message sending. You can only create `net.app.core.pm` channels via the special endpoint for doing so.

## General Parameters

Requests that return streams of channels accept the following query string parameters in addition to the [pagination parameters](/docs/resources/post/#general-parameters):

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th width="50">Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>channel_types</code></td>
            <td>Optional</td>
            <td>string</td>
            <td>A comma separated list of the Channel types to include. For instance <code>channel_types=net.app.core.pm,net.myapp</code> will only return channels with a type of <code>net.app.core.pm</code> or <code>net.myapp</code>.</td>
        </tr>
        <tr>
            <td><code>include_marker</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should the Stream Marker be included with each channel? Only available when requested with a user access token. (Default: <code>False</code>)</td>
        </tr>
        <tr>
            <td><code>include_recent_message</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should the most recent Message be included with each channel? (Default: <code>False</code>)</td>
        </tr>
    </tbody>
</table>

<%= render 'partials/endpoints-tab', :for => "channel" %>
