# Objects

## User

A user is the central object utilized by the App.net Stream API. They have usernames, follow other users, and post content for their followers.

### Example User object

```js
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
        "url": "https://example.com/avatar_image.jpg"
    },
    "cover_image": {
        "height": 118,
        "width": 320,
        "url": "https://example.com/cover_image.jpg"
    },
    "type": "human",
    "created_at": "2012-07-16T17:23:34Z",
    "counts": {
        "following": 100,
        "followers": 200,
        "posts": 24
    },
    "app_data": {
        "appdotnet": {...},
        "rdio": {...}
    },
    "follows_you": false,
    "you_follow": true,
    "you_muted": false,
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
        <td>User supplied descriptive name. May be a pseudonym. All Unicode characters allowed. Maximum length N characters.</td>
    </tr>
    <tr>
        <td><code>description</code></td>
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
                    <td><code>text</code></td>
                    <td>string</td>
                    <td>User supplied biographical information. All Unicode characters allowed. Maximum length N characters.</td>
                </tr>
                <tr>
                    <td><code>html</code></td>
                    <td>string</td>
                    <td>Server-generated annotated HTML version of biographical information.</td>
                </tr>
                <tr>
                    <td><code>entities</code></td>
                    <td>object</td>
                    <td>Entities included in biographical information. See information on <a href="#entities">entities</a> for reference.</td>
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
        <td>
            <br>
            <table>
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
            </table>
        </td>
    </tr>
    <tr>
        <td><code>app_data</code></td>
        <td>object</td>
        <td>Object where each app can store opaque information for this user. This could be useful for storing application state (read pointers, default filters in the app, etc).</td>
    </tr>
    <tr>
        <td><code>follows_you</code></td>
        <td>boolean</td>
        <td>Does this user follow the user making the request? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>you_follow</code></td>
        <td>boolean</td>
        <td>Does the user making the request follow this user? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>you_muted</code></td>
        <td>boolean</td>
        <td>Has the user making the request blocked this user? May be omitted if this is not an authenticated request.</td>
    </tr>
</table>

#### Deprecations

* ```is_following```, ```is_follower```, and ```is_muted``` have all been deprecated and replaced with ```follows_you```, ```you_follow```, and ```you_muted```. These keys should not be used and will be removed from the User object soon.

### Images
Images are objects so that app developers can more easily pick the appropriated sized image for different contexts.

```js
{
    "height": 512,
    "width": 512,
    "url": "https://example.com/image.jpg"
}
```

Images may be dynamically resized on the server by adding `w` and/or `h` parameters to the query string of the URL as desired. If
one of the parameters is omitted, the omitted dimension will be scaled according to the aspect ratio of the original image. Images
will be returned with HTTPS URLs, but can be fetched over HTTP if desired.

**Currently, gif images can not be resized with the ```w``` and ```h``` parameters.**

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
    "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
    "source": {
        "name": "Clientastic for iOS",
        "link": "http://app.net"
    },
    "machine_only": false,
    "reply_to": null,
    "thread_id": "1",
    "num_replies": 3,
    "annotations": [
        {
            "type": "net.app.core.geo",
            "value": {
                "type": "Point",
                "coordinates": [102.0, .5]
            }
        }
    ],
    "entities": {
        "mentions": [{
            "name": "berg",
            "id": "2",
            "pos": 0,
            "len": 5
        }],
        "hashtags": [{
            "name": "newsocialnetwork",
            "pos": 34,
            "len": 17
        }],
        "links": [{
            "text": "this new site",
            "url": "https://join.app.net"
            "pos": 20,
            "len": 13
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
        <td>Primary identifier for a post. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
    </tr>
    <tr>
        <td><code>user</code></td>
        <td>object</td>
        <td>This is an embedded version of the <a href='#user'>User</a> object. <b>Note:</b> In certain cases (e.g., when a user
                account has been deleted), this key may be omitted.</td>
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
        <td><code>html</code></td>
        <td>string</td>
        <td>Server-generated annotated HTML rendering of post text.</td>
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
                    <td>Description of the API consumer that created this post.</td>
                </tr>
                <tr>
                    <td><code>link</code></td>
                    <td>string</td>
                    <td>Link provided by the API consumer that created this post.</td>
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
        <td><code>thread_id</code></td>
        <td>string</td>
        <td>The id of the post at the root of the thread that this post is a part of. If <code>thread_id==id</code> than this property does not guarantee that the thread has > 1 post. Please see <code>num_replies</code>.</td>
    </tr>
    <tr>
        <td><code>num_replies</code></td>
        <td>integer</td>
        <td>The number of posts created in reply to this post.</td>
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
    <tr>
        <td><code>is_deleted</code></td>
        <td>boolean</td>
        <td>Has this post been deleted? For non-deleted posts, this key may be omitted instead of being <code>false</code>. If a post has been deleted, the <code>text</code>, <code>html</code>, and <code>entities</code> properties will be empty and may be omitted.</td>
    </tr>
    <tr>
        <td><code>machine_only</code></td>
        <td>boolean</td>
        <td>Is this Post meant for humans or other apps? See <a href="#machine-only-posts">Machine only Posts</a> for more information.</td>
    </tr>
</table>

#### Deprecations

* ```deleted``` has been deprecated and replaced with ```is_deleted```. This key should not be used and will be removed from the Post object soon.

### Post Annotations
Post annotations are immutable attributes that describe the entire post. Please see the [Annotations spec](annotations.md) for more information.

#### Machine only Posts
Some posts with annotations data may not be meant for direct consumption by a User. For example, a chess app may create Posts with annotations representing chess moves but having human readable text doesn't make sense. Machine only Posts solve this problem by allowing clients to create posts with ```annotations``` and without ```text```. These posts must be specifically asked for by using the ```include_machine=1``` query string parameter. They must contain at least one annotation and cannot contain any text. When deciding if a Post should be machine only, ask yourself "Would this Post make sense in Alpha's Global Feed?"

## Entities
Entities allow users and applications to provide rich text formatting for posts. They provide common formatting for mentions and hashtags but they also allow links to be embedded with anchor text which gives more context. Each entity type is a list with 0 or more entities of the same type.

Entities are designed to be very simple to render — they should relatively easily translate into [`NSAttributedString`](https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/Classes/NSAttributedString_Class/Reference/Reference.html) objects and the like.

Ranges specified by entities may be adjacent, but may not overlap.

All of the following examples are about the following post:

> @berg FIRST post on this new site #newsocialnetwork

### Mentions
Bring another user's attention to your post. A mention starts with <code>@</code>.

```js
"mentions": [{
    "name": "berg",
    "id": "2",
    "pos": 0,
    "len": 5,
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
        <td><code>pos</code></td>
        <td>integer</td>
        <td>The 0 based index where this entity begins <code>text</code> (include @).</td>
    </tr>
    <tr>
        <td><code>len</code></td>
        <td>integer</td>
        <td>The length of the substring in <code>text</code> that represents this mention. Since <code>@</code> is included, <code>len</code> will be the length of the <code>name</code> + 1.</td>
    </tr>
</table>

### Hashtags
Tag a post about a specific subject. A hashtag starts with <code>#</code>.

```js
"hashtags": [{
    "name": "newsocialnetwork",
    "pos": 34,
    "len": 17
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
        <td><code>pos</code></td>
        <td>integer</td>
        <td>The 0 based index where this entity begins <code>text</code> (include #).</td>
    </tr>
    <tr>
        <td><code>len</code></td>
        <td>integer</td>
        <td>The length of the substring in <code>text</code> that represents this hashtag. Since <code>#</code> is included, <code>len</code> will be the length of the <code>name</code> + 1.</td>
    </tr>
</table>

### Links
Link to another website.

```js
"links": [{
    "text": "this new site",
    "url": "https://join.app.net"
    "pos": 20,
    "len": 13
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
        <td><code>pos</code></td>
        <td>integer</td>
        <td>The 0 based index where this entity begins <code>text</code>.</td>
    </tr>
    <tr>
        <td><code>len</code></td>
        <td>integer</td>
        <td>The length of the substring in <code>text</code> that represents this link.</td>
    </tr>
</table>

## Filter

A Filter functions as either a whitelist or a blacklist over a stream of Posts. All the predicates are logically OR'ed together. For instance, with the following example, a post will be shown if it's from user 1, or it's from user 2, or it has hashtag 'sf', or it links to app.net, or it mentions user 1.

```js
{
    "id": "1",
    "type": "show",
    "name": "On the go",
    "user_ids": ["1", "2"],
    "hashtags": ["sf"],
    "link_domains": ["app.net"],
    "mention_user_ids": ["1"]
}
```

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
            <td><code>type</code></td>
            <td>string</td>
            <td>Either <code>show</code> or <code>block</code> for whether this filter should exclude everything except for what's shown or show everything except for what's blocked.</td>
        </tr>
        <tr>
            <td><code>name</code></td>
            <td>string</td>
            <td>A User assigned name for this filter.</td>
        </tr>
        <tr>
            <td><code>user_ids</code></td>
            <td>list</td>
            <td>A list of user ids a Post must or must not be created by.</td>
        </tr>
        <tr>
            <td><code>hashtags</code></td>
            <td>list</td>
            <td>A list of hashtags a Post must or must not have.</td>
        </tr>
        <tr>
            <td><code>link_domains</code></td>
            <td>list</td>
            <td>A list of domains a Post must or must not have a link to.</td>
        </tr>
        <tr>
            <td><code>mention_user_ids</code></td>
            <td>list</td>
            <td>A list of user ids a Post must or must not mention.</td>
        </tr>
    </tbody>
</table>

## Notes on data formats

### Dates

Dates will be formatted as a **strict** subset of [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601). Dates are parseable by almost any ISO 8601 date parser or merely by parsing from position. All dates will be formatted as follows:

`2012-12-31T13:22:55Z`

where `2012` is the year, `12` represents December, `31` represents the 31st day of the month, `13` represents 1 PM, `22` minutes and `55` seconds past the hour. All times will be expressed in terms of UTC.

This format was chosen to minimize ambiguity and edge cases in terms of parsing while maximizing readability of dates during
development.

### Object IDs

Object ids will always be transferred as strings to avoid issues with with limitations of JavaScript integers. You can assume that object ids are integers.
