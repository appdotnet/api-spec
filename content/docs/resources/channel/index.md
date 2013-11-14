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
    "you_muted": false,
    "you_subscribed": true
}
~~~

## Fields

<table class='table table-striped'>
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
                <table class='table table-striped'>
                    <tr>
                        <th>Field</th>
                        <th>Type</th>
                        <th>Description</th>
                    </tr>
                    <tr>
                        <td><code>messages</code></td>
                        <td>integer</td>
                        <td>The number of <a href="/docs/resources/message/">Messages</a> in the channel.</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td><code>id</code></td>
            <td>string</td>
            <td>Primary identifier for a Channel. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
        </tr>
        <tr>
            <td><code>type</code></td>
            <td>string</td>
            <td>A string that looks like a reversed domain name to identify the intended purpose of this Channel. <em>There is no authentication or authorization performed on this field. Just because you create channels with the type <code>com.example.awesome</code> does not imply you are the only one that is using that namespace or that the channel ACLs will match the format you expect</em>. <code>net.app.core</code> is a reserved namespace.</td>
        </tr>
        <tr>
            <td><code>owner</code></td>
            <td><a href="/docs/resources/user/">User object</a></td>
            <td>This is an embedded version of the <a href='/docs/resources/user/'>User</a> object. <em>In certain cases (e.g., when a user account has been deleted), this key may be omitted.</em></td>
        </tr>
        <tr>
            <td><code>annotations</code></td>
            <td>list</td>
            <td>Metadata about the Channel. See the <a href="/docs/meta/annotations/">Annotations</a> documentation.</td>
        </tr>
        <tr>
            <td><code>readers</code></td>
            <td><a href="#acl">ACL object</a></td>
            <td>The access control list that describes who can read this Channel and its <a href="/docs/resources/message/">Messages</a>.</td>
        </tr>
        <tr>
            <td><code>writers</code></td>
            <td><a href="#acl">ACL object</a></td>
            <td>The access control list that describes who can write <a href="/docs/resources/message/">Messages</a> to this Channel.</td>
        </tr>
        <tr>
            <td><code>you_muted</code></td>
            <td>boolean</td>
            <td>Have you muted this Channel? A user cannot be <a href="/docs/basics/messaging/#subscriptions">auto-subscribed</a> to muted channels.</td>
        </tr>
        <tr>
            <td><code>you_subscribed</code></td>
            <td>boolean</td>
            <td>Are you currently subscribed to this Channel. There are many Channels you could have access to read and this indicates whether you are "following" this Channel.</td>
        </tr>
        <tr>
            <td><code>you_can_edit</code></td>
            <td>boolean</td>
            <td>Are you allowed to edit the Channel.</td>
        </tr>
        <tr>
            <td><code>has_unread</code></td>
            <td>boolean</td>
            <td>Are there unread <a href="/docs/resources/message/">Messages</a> in this Channel (according to the <code>last_read_id</code> of the <a href="/docs/resources/stream-marker/">Stream Marker</a> you have saved for this Channel)?</td>
        </tr>
        <tr>
            <td><code>marker</code></td>
            <td><a href="/docs/resources/stream-marker/">Stream Marker object</a></td>
            <td>The full <a href="/docs/resources/stream-marker/">Stream Marker</a> object for this Channel. Only sent if using a <a href="/docs/authentication/#access-tokens">user access token</a> and requested by the <code>include_marker=1</code> query string parameter.</td>
        </tr>
        <tr>
            <td><code>recent_message_id</code></td>
            <td>string</td>
            <td>The ID of the most recent <a href="/docs/resources/message/">Message</a> in this channel. <em>This may be a deleted Message or a Message from a muted User.</em></td>
        </tr>
        <tr>
            <td><code>recent_message</code></td>
            <td>Message object</td>
            <td>The most recent <a href="/docs/resources/message/">Message</a> in this channel. This is always included in Channel updates pushed via the streaming API, but must otherwise be requested with the <code>include_recent_message=1</code> query string parameter. <em>This may be a deleted Message or a Message from a muted User.</em></td>
        </tr>
    </tbody>
</table>

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

Access control lists (ACLs) specify who can read and who can write <a href="/docs/resources/message/">Messages</a> in a Channel. In our permissions model, writing implies reading. Note that `any_user`, `public`, and non-empty `user_ids` are all mutually exclusive (only one of those can be true at a time). Also, the creator of a Channel always has write access and will not be specified in the `user_ids` list. For some Channel types (like `net.app.core.pm`), the ACLs will be sanitized to make sure they fit a specific schema. Please see the [Messaging overview](/docs/basics/messaging/) for more information.

### ACL Fields

<table class='table table-striped'>
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
            <td>Can any logged in <a href="/docs/resources/user/">User</a> read/write to this Channel? If true, <code>public</code> will be false and <code>user_ids</code> will be empty.</td>
        </tr>
        <tr>
            <td><code>immutable</code></td>
            <td>boolean</td>
            <td>Can this ACL be changed? In general, we recommend creating immutable Channels so that <a href="/docs/resources/message/">Messages</a> can't "leak out" of a Channel later.</td>
        </tr>
        <tr>
            <td><code>public</code></td>
            <td>boolean</td>
            <td>Can anyone (including not logged in <a href="/docs/resources/user/">Users</a>), read this channel. This will always be <code>false</code> for the <code>writers</code> ACL. If <code>true</code>, <code>any_user</code> will be false and <code>user_ids</code> will be empty.</td>
        </tr>
        <tr>
            <td><code>user_ids</code></td>
            <td>list</td>
            <td>A list of strings specifying the ids of <a href="/docs/resources/user/">Users</a> who can read/write to this Channel. If non-empty, <code>any_user</code> and <code>public</code> will be <code>false</code>. This list can contain at most 200 User ids.</td>
        </tr>
        <tr>
            <td><code>you</code></td>
            <td>boolean</td>
            <td>Can the authorized <a href="/docs/resources/user/">User</a> for the current token read/write to this Channel? This field, unlike the others, respects the permission hierarchy. To test channel writeability, you need only examine this field.</td>
        </tr>
    </tbody>
</table>

## Channel Annotations

Channel annotations are mutable attributes that describe the Channel. When creating new Channels, developers should consider supplying a [fallback url annotation](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.fallback_url.md).

For more information on Annotations in general, see the [Annotations](/docs/meta/annotations/) documentation page.

## Channel Types

A Channel's `type` can be used to identify the behavior of a Channel. Channel types are specified by the application creating the Channel and should have corresponding entries in the [channel-types directory](https://github.com/appdotnet/object-metadata/tree/master/channel-types) describing their behavior.    

There is currently one core Channel type:

#### Private Message

> [net.app.core.pm](https://github.com/appdotnet/object-metadata/blob/master/channel-types/net.app.core.pm.md)

This Channel type is for private messages between 2 or more people. As a core Channel type, it has some special restrictions designed to simplify adoption for developers:

- Private message Channels enforce that there is at least one non-owner user_id in the `writers` ACL and that both ACLs are immutable. 
- Messages with the `machine_only` flag set are disallowed (though, of course, annotations are permitted when accompanied with text.)
- This Channel type differs from others in that it is designed to provide a simple, combined API for Channel creation, reuse and Message sending. You can only create `net.app.core.pm` Channels via the [create private message Channel endpoint](http://developers.app.net/docs/resources/message/lifecycle/#create-a-message
).

You can create arbitrary Channel types which do not have these restrictions (but are able to maintain the same level of privacy.)

## General Parameters

Where noted, Channel endpoints respond to the following query string parameters:

<table class='table table-striped'>
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
            <td>A comma separated list of the Channel types to include. For instance <code>channel_types=net.app.core.pm,net.myapp.room</code> will only return channels with a type of <code>net.app.core.pm</code> or <code>net.myapp.room</code>.</td>
        </tr>
        <tr>
            <td><code>include_marker</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should the <a href="/docs/resources/stream-marker/">Stream Marker</a> be included with each Channel? Only available when requested with a user access token. Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_read</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should Channels with no unread <a href="/docs/resources/message/">Messages</a> be returned? Defaults to true.</td>
        </tr>
        <tr>
            <td><code>include_recent_message</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should the most recent <a href="/docs/resources/message/">Message</a> be included with each Channel? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/docs/meta/annotations/">annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_user_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/docs/meta/annotations/">User annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_message_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/docs/meta/annotations/">Message annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
    </tbody>
</table>

Where noted, endpoints that return a stream of Channels additionally respond to [pagination parameters](/docs/basics/pagination).

<%= render 'partials/endpoints-tab', :for => "channel" %>
