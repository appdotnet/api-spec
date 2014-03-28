---
title: "Message"
---

# Message

<%= render 'partials/object-tab' %>

* TOC
{:toc}

A Message is very similar to a [Post](/reference/resources/post/) but 1) it doesn't have to be public and 2) it will be delivered to an arbitrary set of users (not just the users who follow the Message creator). For an overview of the App.net messaging API, please see the [Introduction to App.net Messaging](/docs/guides/messaging/).

<%= json(:message) %>

## Fields

<table class='table table-striped'>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>id</code></td>
        <td>string</td>
        <td>Primary identifier for a Message. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
    </tr>
    <tr>
        <td><code>channel_id</code></td>
        <td>string</td>
        <td>The id of the <a href="/reference/resources/channel/">Channel</a> this Message belongs to. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
    </tr>
    <tr>
        <td><code>user</code></td>
        <td>object</td>
        <td>This is an embedded version of the <a href='/reference/resources/user/'>User</a> object. <em>In certain cases (e.g., when a user account has been deleted), this key may be omitted.</em></td>
    </tr>
    <tr>
        <td><code>created_at</code></td>
        <td>string</td>
        <td>The time at which the Message was create in <a href='http://en.wikipedia.org/wiki/ISO_8601'>ISO 8601</a> format.</td>
    </tr>
    <tr>
        <td><code>text</code></td>
        <td>string</td>
        <td>User supplied text of the Message. All Unicode characters allowed. Maximum length 2048 characters. The maximum length can be retrieved from the <a href="/reference/resources/config/">Configuration endpoint</a>.</td>
    </tr>
    <tr>
        <td><code>html</code></td>
        <td>string</td>
        <td>Server-generated annotated HTML rendering of Message text.</td>
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
                    <td>Description of the API consumer that created this Message.</td>
                </tr>
                <tr>
                    <td><code>link</code></td>
                    <td>string</td>
                    <td>Link provided by the API consumer that created this Message.</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td><code>reply_to</code></td>
        <td>string</td>
        <td>The id of the Message this Message is replying to (or <code>null</code> if not a reply).</td>
    </tr>
    <tr>
        <td><code>thread_id</code></td>
        <td>string</td>
        <td>The id of the post at the root of the thread that this Message is a part of. If <code>thread_id==id</code> then this property does not guarantee that the thread has > 1 Message. Please see <code>num_replies</code>.</td>
    </tr>
    <tr>
        <td><code>num_replies</code></td>
        <td>integer</td>
        <td>The number of messages created in reply to this Message.</td>
    </tr>
    <tr>
        <td><code>annotations</code></td>
        <td>list</td>
        <td>Metadata about the entire Message. See the <a href="/reference/meta/annotations/">Annotations</a> documentation.</td>
    </tr>
    <tr>
        <td><code>entities</code></td>
        <td>object</td>
        <td>Rich text information for this message. See the <a href="/reference/meta/entities/">Entities</a> documentation.</td>
    </tr>
    <tr>
        <td><code>is_deleted</code></td>
        <td>boolean</td>
        <td>Has this message been deleted? For non-deleted Messages, this key may be omitted instead of being <code>false</code>. If a Message has been deleted, the <code>text</code>, <code>html</code>, and <code>entities</code> properties will be empty and may be omitted.</td>
    </tr>
    <tr>
        <td><code>machine_only</code></td>
        <td>boolean</td>
        <td>Is this Message meant for humans or other apps? See <a href="#machine-only-messages">machine only Messages</a> for more information.</td>
    </tr>
</table>

## Message Annotations

Message annotations are immutable attributes that describe the entire message. Please see the [Annotations](/reference/meta/annotations/) documentation for more information.

## Machine only Messages

Sometimes a Message is not meant for human consumption but it may be readable by an App of some kind. In that case, you can create a machine only Message by including `annotations`, omitting `text`, and setting `machine_only: true`. You can request machine only Messages using the `include_machine=1` query string parameter.

## General Parameters

Where noted, Message endpoints respond to the following query string parameters:

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
            <td><code>include_muted</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should Messages from muted Users be included? Defaults to false except when you specifically request a Message from a muted User.</td>
        </tr>
        <tr>
            <td><code>include_deleted</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should deleted Messages be included? Defaults to true.</td>
        </tr>
        <tr>
            <td><code>include_machine</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="#machine-only-messages">machine only Messages</a> be included? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/reference/meta/annotations/">annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_message_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/reference/meta/annotations/">Message annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_user_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/reference/meta/annotations/">User annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_html</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should the <a href="/reference/resources/message/#fields"><code>html</code> field</a> be included alongside the <code>text</code> field in the response objects? Defaults to true.</td>
        </tr>
    </tbody>
</table>

Where noted, endpoints that return a stream of Messages additionally respond to [pagination parameters](/reference/make-request/pagination).

<%= render 'partials/endpoints-tab', :for => "message" %>
