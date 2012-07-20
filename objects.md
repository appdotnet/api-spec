# Objects

## User

A user is the central object utilized by the App.net Stream API. They have usernames, follow other users, and post content for their followers.

### Example User object

```js
{
    "id": "1", // note this is a string
    "username": "mthurman",
    "name": "Mark Thurman",
    "description": "Hi, Im Mark Thurman and I'm teaching you about the App.net Stream API.",
    "url": "http://www.example.com/mthurman",
    "timezone": "US/Pacific",
    "locale": "en_US",
    "avatar_image": {
        "57s": {
            "height": 57,
            "width": 57,
            "url": "https://example.com/avatar_57x57_image.jpg"
        },
        "114s": {
            "height": 114,
            "width": 114,
            "url": "https://example.com/avatar_114x114_image.jpg"
        },
    },
    "cover_image": {
        "320r": {
            "height": 118,
            "width": 320,
            "url": "https://example.com/cover_320x118_image.jpg"
        },
        "640r": {
            "height": 237,
            "width": 640,
            "url": "https://example.com/cover_640x237_image.jpg"
        },
    },
    "type": "human",
    "created_at": "2012-07-16T17:23:34Z",
    "counts": {
        "follows": 100,
        "followed_by": 200,
        "posts": 24
    }
}
```

### User fields

<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>id</code></td>
        <td>string</td>
        <td>Primary identifier for a post. Alphanumeric, always expressed as a string. This idspace is unique to Post objects. There can be a Post and User with the same ID; no relation is implied.</td>
    </tr>
    <tr>
        <td><code>username</code></td>
        <td>string</td>
        <td>Case insensitive. 20 characters, may only contain a-z, 0-9 and underscore.</td>
    </tr>
    <tr>
        <td><code>name</code></td>
        <td>string</td>
        <td>User supplied descriptive name. May be a pseudonym. All Unicode characters allowed. Maximum length N characters.</td>
    </tr>
    <tr>
        <td><code>description</code></td>
        <td>string</td>
        <td>User supplied biographical information. All Unicode characters allowed. Maximum length N characters.</td>
    </tr>
    <tr>
        <td><code>url</code></td>
        <td>string</td>
        <td>User supplied descriptive URL. Maximum length N characters.</td>
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
        <td>Object representing different sizes of the urls of the user's avatar.</td>
    </tr>
    <tr>
        <td><code>cover_image</code></td>
        <td><a href="#images">image object</a></td>
        <td>Object representing different sizes of the urls of the user's larger cover image.</td>
    </tr>
    <tr>
        <td><code>type</code></td>
        <td>string</td>
        <td>An account can be one of the following types: <code>human</code>, <code>bot</code>, <code>corporate</code>, or <code>feed</code>.</td>
    </tr>
    <tr>
        <td><code>created_at</code></td>
        <td>string</td>
        <td>The time at which the User was created in <a href='http://en.wikipedia.org/wiki/ISO_8601'>ISO 8601</a> format.</td>
    </tr>
    <tr>
        <td><code>counts</code></td>
        <td>object</td>
        <td><pre>
"counts": {
    "follows": 100,
    "followed_by": 200,
    "posts": 24
}
</pre>
            <table>
                <tr>
                    <th>Field</th>
                    <th>Type</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td><code>follows</code></td>
                    <td>integer</td>
                    <td>The number of users this user is following.</td>
                </tr>
                <tr>
                    <td><code>followed_by</code></td>
                    <td>integer</td>
                    <td>The number of users following this user.</td>
                </tr>
                <tr>
                    <td><code>posts</code></td>
                    <td>integer</td>
                    <td>The number of posts created by this user.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

### Images
Images are objects so that app developers can more easily pick the appropriated sized image for different contexts.

```js
{
    "57s": {
        "height": 57,
        "width": 57,
        "url": "https://example.com/square_57x57_image.jpg"
    },
    "114s": {
        "height": 114,
        "width": 114,
        "url": "https://example.com/square_114x114_image.jpg"
    },
    ...
}
```

Top level keys are strings matching the following regular expression:

    ^([0-9]+)([sr])$

* $1 is the width of the image
* $2 is the format of the image, ```s``` or ```r``` depending on if the image is square or rectangular.
* For each image kind, the keys will be well defined based on commonly requested sizes.

## Post
A Post is the other central object utilized by the App.net Stream API. It has rich text and annotations which comprise all of the content a users sees in their feed.

```js
{
    "id": "1", // note this is a string
    "user": {
        ...
    },
    "created_at": "2012-07-16T17:25:47Z",
    "text": "@berg FIRST post on this new site #newsocialnetwork",
    "source": {
        "name": "Rdio for iOS",
        "link": "http://rdio.com"
    },
    "reply_to": null,
    "annotations": {
        "wellknown:geo": {
            "type": "Point",
            "coordinates": [102.0, .5]
        },
        "rdio:song": ...
    },
    "entities": {
        "mentions": [{
            "name": "berg",
            "id": "2",
            "indices": [0, 4]
        }],
        "hashtags": [{
            "name": "newsocialnetwork",
            "indices": [34, 50]
        }],
        "links": [{
            "text": "this new site",
            "url": "https://join.app.net"
            "indices": [20, 32],
        }]
    }
}
```

### Post Fields

<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>id</code></td>
        <td>string</td>
        <td>Always present.</td>
    </tr>
    <tr>
        <td><code>user</code></td>
        <td>object</td>
        <td>This is an embedded version of the <a href='#user'>User</a> object.</td>
    </tr>
    <tr>
        <td><code>created_at</code></td>
        <td>string</td>
        <td>The time at which the post was create in <a href='http://en.wikipedia.org/wiki/ISO_8601'>ISO 8601</a> format.</td>
    </tr>
    <tr>
        <td><code>text</code></td>
        <td>string</td>
        <td>User supplied text of the post.</td>
    </tr>
    <tr>
        <td><code>source</code></td>
        <td>object</td>
        <td>
            <pre>
"source": {
    "name": "Rdio for iOS",
    "link": "http://rdio.com"
}
</pre>
            <table>
                <tr>
                    <th>Field</th>
                    <th>Type</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td><code>name</code></td>
                    <td>string</td>
                    <td>Description of the API consumer.</td>
                </tr>
                <tr>
                    <td><code>link</code></td>
                    <td>string</td>
                    <td>Provided by the API consumer.</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td><code>reply_to</code></td>
        <td>string</td>
        <td>The id of the post this post is replying to (or <code>null</code> if not a reply).</td>
    </tr>
    <tr>
        <td><code>annotations</code></td>
        <td>object</td>
        <td>Metadata about the entire post. See the <a href="/appdotnet/api-spec/blob/master/objects.md#annotations">annotations documentation</a>.</td>
    </tr>
    <tr>
        <td><code>entities</code></td>
        <td>object</td>
        <td>Rich text information for this post. See the <a href="/appdotnet/api-spec/blob/master/objects.md#entities">entities documentation</a>.</td>
    </tr>
</table>

* TODOs
    * Reply model

### Annotations
Annotations are attributes (key, value pairs) that describe the entire post. There will be globally defined annotation formats (like geo above) but each application can also define annotations in their own namespace (like the Rdio song).

TODO

### Entities
Entities allow users and applications to provide rich text formatting for posts. They provide common formatting for mentions and hashtags but they also allow links to be embedded with anchor text which gives more context. Each entity type is a list with 0 or more entities of the same type.

Entities are designed to be very simple to render — they should relatively easily translate into [`NSAttributedString`](https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/Classes/NSAttributedString_Class/Reference/Reference.html) objects and the like.

All of the following examples are about the following post:

> @berg FIRST post on this new site #newsocialnetwork

#### Mentions
Bring another user's attention to your post. A mention starts with <code>@</code>.

```js
"mentions": [{
    "name": "berg",
    "id": "2",
    "indices": [0, 4]
}]
```
<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>name</code></td>
        <td>string</td>
        <td>The username being mentioned (doesn't include '@').</td>
    </tr>
    <tr>
        <td><code>id</code></td>
        <td>string</td>
        <td>The user id of the mentioned user.</td>
    </tr>
    <tr>
        <td><code>indices</code></td>
        <td>list</td>
        <td>A 2 element long list which represents what subset of the <code>text</code> is formatted (include @).</td>
    </tr>
</table>

#### Hashtags
Tag a post about a specific subject. A hashtag starts with <code>#</code>.

```js
"hashtags": [{
    "name": "newsocialnetwork",
    "indices": [34, 50]
}]
```
<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>name</code></td>
        <td>string</td>
        <td>The text of the hashtag (not including #).</td>
    </tr>
    <tr>
        <td><code>indices</code></td>
        <td>list</td>
        <td>A 2 element long list which represents what subset of the <code>text</code> is formatted (include #).</td>
    </tr>
</table>

#### Links
Link to another website.

```js
"links": [{
    "text": "this new site",
    "url": "https://join.app.net"
    "indices": [20, 32],
}]
```
<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>text</code></td>
        <td>string</td>
        <td>The anchor text to be linked (could be a url).</td>
    </tr>
    <tr>
        <td><code>url</code></td>
        <td>string</td>
        <td>The destination url (only http or https accepted).</td>
    </tr>
    <tr>
        <td><code>indices</code></td>
        <td>list</td>
        <td>A 2 element long list which represents what subset of the <code>text</code> is linked.</td>
    </tr>
</table>
