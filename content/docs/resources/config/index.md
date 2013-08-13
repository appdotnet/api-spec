---
title: "Configuration"
---

# Configuration

* TOC
{:toc}

The Configuration object defines platform-wide variables that Apps can use to make sure their behavior is consistent with the platform.

## Example Configuration object

<%= json(:config) %>

## Configuration fields

<table class='table table-striped'>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>text</code></td>
        <td>object</td>
        <td>
            Configuration that is common to all text fields (post.text, message.text, user.description.text).
            <br>
            <table class='table table-striped'>
                <tr>
                    <th>Field</th>
                    <th>Type</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td><code>uri_template_length</code></td>
                    <td>object</td>
                    <td>A mapping from each of the possible <a href="/docs/meta/entities/#uri-templates">URI template replacement values</a> to the number of characters that are "used" upon replacement.</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td><code>user</code></td>
        <td><a href="#resource-configuration">Resource Configuration Object</a></td>
        <td>The configuration related to <a href="/docs/resources/user/">User</a> objects.</td>
    </tr>
    <tr>
        <td><code>file</code></td>
        <td><a href="#resource-configuration">Resource Configuration Object</a></td>
        <td>The configuration related to <a href="/docs/resources/file/">File</a> objects.</td>
    </tr>
    <tr>
        <td><code>post</code></td>
        <td><a href="#resource-configuration">Resource Configuration Object</a></td>
        <td>The configuration related to <a href="/docs/resources/post/">Post</a> objects.</td>
    </tr>
    <tr>
        <td><code>message</code></td>
        <td><a href="#resource-configuration">Resource Configuration Object</a></td>
        <td>The configuration related to <a href="/docs/resources/message/">Message</a> objects.</td>
    </tr>
    <tr>
        <td><code>channel</code></td>
        <td><a href="#resource-configuration">Resource Configuration Object</a></td>
        <td>The configuration related to <a href="/docs/resources/channel/">Channel</a> objects.</td>
    </tr>
</table>

## Resource Configuration

<%= json(:config) { |h|
    user = h["user"]
    h.clear
    h.update(user)
} %>

A Resource Configuration object represents values that only apply to a specific App.net resource.

### Resource Configuration Fields

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
            <td><code>annotation_max_bytes</code></td>
            <td>integer</td>
            <td>The maximum number of bytes that can be attached to this type of object as an <a href="/docs/meta/annotations/">Annotation</a>.</td>
        </tr>
        <tr>
            <td><code>text_max_length</code></td>
            <td>integer</td>
            <td>The maximum number of characters that an instance of this object can be. For <a href="/docs/resources/user/">User</a> objects, this applies to the User description. This field does not apply to <a href="/docs/resources/channel/">Channel</a> objects.</td>
        </tr>
    </tbody>
</table>

## How should I use the Configuration object

The App.net platform has platform-wide limits that all apps must respect. They are enforced at an API level, but they can be useful to have defined as variable in your app's code. Examples are things like: "how long can a Post be" or "how long can annotations be on a Channel object." This endpoint allows you to update your app's configuration so it always has the newest platform-wide configuration values available.

We recommend:

1. Ship your application with the current values defined for these configuration values. Persist them when your app launches.
2. At most once per day, query this endpoint.
3. Update any configuration keys to their newest values. We recommend you do this when your app launches or in a cronjob.

This endpoint should be queried with an access token if you have one. However, if you are creating an app with multiple user accounts you may store this data globally instead of per-user if you'd like.

## Retrieve the Configuration object

Returns the current Configuration object.

*Your application should request this endpoint with a user or app access token if available.*

<%= endpoint "GET", "config", "None" %>

#### Example

> GET https://alpha-api.app.net/stream/0/config

<%= response(:config) %>
