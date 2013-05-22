---
title: "User"
---

# User

<%= render 'partials/object-tab' %>

* TOC
{:toc}

A User is the central object of the App.net APIs. User objects have usernames, follow other users, and post content for their followers.

## Example User object

~~~ js
{
    "id": "1", // note this is a string
    "username": "mthurman",
    "name": "Mark Thurman",
    "description": {
       "text": "Hi, I'm Mark Thurman and I'm teaching you about the @appdotnet Stream #API.",
       "html": "Hi, I'm Mark Thurman and I'm <a href=\"https://github.com/appdotnet/api_spec\" rel=\"nofollow\">teaching you</a> about the <span itemprop=\"mention\" data-mention-name=\"appdotnet\" data-mention-id=\"3\">@appdotnet</span> Stream #<span itemprop=\"hashtag\" data-hashtag-name=\"api\">API</span>.",
       "entities": {
           "mentions": [{
               "name": "appdotnet",
               "id": "3",
               "pos": 52,
               "len": 10
           }],
           "hashtags": [{
               "name": "api",
               "pos": 70,
               "len": 4
           }],
           "links": [{
               "text": "teaching you",
               "url": "https://github.com/appdotnet/api-spec",
               "pos": 29,
               "len": 12
           }]
        }
    },
    "timezone": "US/Pacific",
    "locale": "en_US",
    "avatar_image": {
        "height": 512,
        "width": 512,
        "url": "https://example.com/avatar_image.jpg",
        "is_default": false
    },
    "cover_image": {
        "width": 320,
        "height": 118,
        "url": "https://example.com/cover_image.jpg",
        "is_default": false
    },
    "type": "human",
    "created_at": "2012-07-16T17:23:34Z",
    "counts": {
        "following": 100,
        "followers": 200,
        "posts": 24,
        "stars": 76
    },
    "follows_you": false,
    "you_blocked": false,
    "you_follow": true,
    "you_muted": false,
    "you_can_subscribe": true,
    "verified_domain": "example.com",
    "annotations": [
        {
            "type": "net.app.core.directory.blog",
            "value": {
                "url": "http://myawesomeblog.com"
            }
        }
    ]
}
~~~

## User fields

<table class='table table-striped'>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>id</code></td>
        <td>string</td>
        <td>Primary identifier for a user. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed. This idspace is unique to User objects. There can be a Post and User with the same ID; no relation is implied.</td>
    </tr>
    <tr>
        <td><code>username</code></td>
        <td>string</td>
        <td>Case insensitive. 20 characters, may only contain a-z, 0-9 and underscore.</td>
    </tr>
    <tr>
        <td><code>name</code></td>
        <td>string</td>
        <td>User supplied descriptive name. May be a pseudonym. All Unicode characters allowed. Maximum length 50 characters.</td>
    </tr>
    <tr>
        <td><code>description</code></td>
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
                    <td><code>text</code></td>
                    <td>string</td>
                    <td>User supplied biographical information. All Unicode characters allowed. Maximum length 256 characters.</td>
                </tr>
                <tr>
                    <td><code>html</code></td>
                    <td>string</td>
                    <td>Server-generated annotated HTML version of biographical information.</td>
                </tr>
                <tr>
                    <td><code>entities</code></td>
                    <td>object</td>
                    <td>Entities included in biographical information. See information on <a href="/docs/meta/entities/">entities</a> for reference.</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td><code>timezone</code></td>
        <td>string</td>
        <td>User timezone in tzinfo format.</td>
    </tr>
    <tr>
        <td><code>locale</code></td>
        <td>string</td>
        <td>User locale in ISO format.</td>
    </tr>
    <tr>
        <td><code>avatar_image</code></td>
        <td><a href="#images">image object</a></td>
        <td>Object representing the URL and original size of the user's avatar.</td>
    </tr>
    <tr>
        <td><code>cover_image</code></td>
        <td><a href="#images">image object</a></td>
        <td>Object representing the URL and original size of the user's over image.</td>
    </tr>
    <tr>
        <td><code>type</code></td>
        <td>string</td>
        <td>An account can be one of the following types: <code>human</code>, <code>feed</code>, or <code>bot</code>. See the <a href="#account-types">account types documentation</a> for more information.</td>
    </tr>
    <tr>
        <td><code>created_at</code></td>
        <td>string</td>
        <td>The time at which the User was created in <a href='http://en.wikipedia.org/wiki/ISO_8601'>ISO 8601</a> format.</td>
    </tr>
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
                    <td><code>following</code></td>
                    <td>integer</td>
                    <td>The number of users this user is following.</td>
                </tr>
                <tr>
                    <td><code>followers</code></td>
                    <td>integer</td>
                    <td>The number of users following this user.</td>
                </tr>
                <tr>
                    <td><code>posts</code></td>
                    <td>integer</td>
                    <td>The number of posts created by this user.</td>
                </tr>
                <tr>
                    <td><code>stars</code></td>
                    <td>integer</td>
                    <td>The number of posts starred by this user.</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td><code>follows_you</code></td>
        <td>boolean</td>
        <td>Does this user follow the user making the request? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>you_blocked</code></td>
        <td>boolean</td>
        <td>Has the user making the request blocked this user? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>you_follow</code></td>
        <td>boolean</td>
        <td>Does the user making the request follow this user? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>you_muted</code></td>
        <td>boolean</td>
        <td>Has the user making the request muted this user? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>you_can_subscribe</code></td>
        <td>boolean</td>
        <td>Does the user making the request have the ability to subscribe this user to channels? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>verified_domain</code></td>
        <td>string</td>
        <td>A string representing a domain that is controlled by this App.net user and has been verified by App.net.</td>
    </tr>
    <tr>
        <td><code>annotations</code></td>
        <td>list</td>
        <td>Metadata about the user. See the <a href="/docs/meta/annotations/">Annotations</a> documentation.</td>
    </tr>
</table>

### Deprecations

* ```is_following```, ```is_follower```, and ```is_muted``` have all been deprecated and replaced with ```follows_you```, ```you_follow```, and ```you_muted```. These keys should not be used and will be removed from the User object soon.

## Images
Images are objects so that app developers can more easily pick the appropriated sized image for different contexts.

~~~ js
{
    "height": 512,
    "width": 512,
    "url": "https://example.com/image.jpg",
    "is_default": true
}
~~~

Images may be dynamically resized on the server by adding `w` and/or `h` parameters to the query string of the URL as desired. If
one of the parameters is omitted, the omitted dimension will be scaled according to the aspect ratio of the original image. Images
will be returned with HTTPS URLs, but can be fetched over HTTP if desired.

**Currently, gif images can not be resized with the ```w``` and ```h``` parameters.**

A user's avatar and cover images can be [directly requested](/docs/resources/user/profile/#retrieve-a-users-avatar-image) without requesting the entire user object.

## Account Types

A user account can be either a `human`, `feed`, or `bot` account type. As App.net develops, we may add other Account Types for specialized purposes.

* `human` means that a human controls how the account interacts with App.net. By default, all accounts are human accounts.
* `feed` is currently treated just like a human account but is meant to indicate that the account primarily posts from an external feed. If a feed account interacts with other users, a human should be involved.
* `bot` means that this account interacts with other App.net users without a human's involvement. If your account mentions or sends messages to other App.net users without a human's interaction, it must be classified as a Bot to comply with Appp.net's Terms of Service. A bot account has the following restrictions:
    * A bot can only follow users who follow the bot.
    * A bot can only send messages to users who follow the bot.
    * A bot's posts do not appear in the global stream.
    * A bot can only mention users who follow the bot.

## General parameters

Where noted, User endpoints respond to the following query string parameters:

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
            <td><code>include_html</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should the user description <a href="/docs/resources/user/#user-fields"><code>html</code> field</a> be included alongside the <code>text</code> field in the response objects? Defaults to true.</td>
        </tr>
    </tbody>
</table>

Where noted, endpoints that return a stream of Users additionally respond to [pagination parameters](/docs/basics/pagination).

<%= render 'partials/endpoints-tab', :for => "user" %>
