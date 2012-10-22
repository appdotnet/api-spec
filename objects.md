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
        "posts": 24,
        "stars": 76
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
                <tr>
                    <td><code>stars</code></td>
                    <td>integer</td>
                    <td>The number of posts starred by this user.</td>
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
    "canonical_url": "https://alpha.app.net/mthurman/post/1",
    "num_replies": 3,
    "num_reposts": 1,
    "num_stars": 1,
    "annotations": [
        {
            "type": "net.app.core.geolocation",
            "value": {
                "latitude": 74.0064,
                "longitude": 40.7142,
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
    },
    "you_reposted": true,
    "you_starred": false,
    "reposters": [
        ...user...
    ],
    "starred_by": [
        ...users...
    ]
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
        <td><code>canonical_url</code></td>
        <td>string</td>
        <td>The URL of the post's detail page on Alpha.</td>
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
        <td><code>num_stars</code></td>
        <td>integer</td>
        <td>The number of users who have starred this post.</td>
    </tr>
    <tr>
        <td><code>num_reposts</code></td>
        <td>integer</td>
        <td>The number of users who have reposted this post.</td>
    </tr>
    <tr>
        <td><code>annotations</code></td>
        <td>list</td>
        <td>Metadata about the entire post. See the <a href="/appdotnet/api-spec/blob/master/annotations.md">annotations documentation</a>.</td>
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
    <tr>
        <td><code>you_starred</code></td>
        <td>boolean</td>
        <td>Have you starred this Post? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>starred_by</code></td>
        <td>list</td>
        <td>A partial list of users who have starred this post. This is not comprehensive and is meant to be a sample of users who have starred this post giving preference to users the current user follows. This is only included if <code>include_starred_by=1</code> is passed to App.net. May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>you_reposted</code></td>
        <td>boolean</td>
        <td>Have you reposted this Post? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>reposters</code></td>
        <td>list</td>
        <td>A partial list of users who have reposted this post. This is not comprehensive and is meant to be a sample of users who have starred this post giving preference to users the current user follows. This is only included if <code>include_reposters=1</code> is passed to App.net. May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>repost_of</code></td>
        <td>Post object</td>
        <td>If this post is a repost, this key will contain the complete original Post.</td>
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

Usually entities are extracted from the Post text by App.net's servers. We allow users to specify some entities at Post creation time. Please refer to the [user specified entites](#user-specified-entities) documentation for more information.

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

### User Specified Entites

Entities are automatically extracted from the post text but there are 2 cases where users and apps can set the entities on a post.

#### Mentions in machine only posts

[Machine only posts](#machine-only-posts) don't have any text so entities cannot be extracted. We allow you to specify up to 10 users (by username or id) who can be mentioned in a machine only post. A machine only post with mentions is treated as a [directed post](/appdotnet/api-spec/blob/master/resources/posts.md#general-parameters) to those users. You should not pass the ```pos``` or ```len``` keys in these mentions. Please see the example:

```js
{
    "annotations": ...,
    "machine_only": true,
    "entities": {
        "mentions": [
            {
                "name": "mthurman"
            },
            {
                "id": "1"
            },
            ...
        ]
    }
}
```

#### Links with custom anchor text

If you'd like to provide a link without including the entire URL in your post text, you can specify a custom link at Post creation time. If you provide any links at post creation time, **App.net will not extract any links on the server**. Mentions and hashtags will still be extracted and your provided links must not overlap with these extracted entities.

To prevent phishing, any link where the anchor text differs from the destination domain will be followed by the domain of the link target. These extra characters will not count against the 256 character Post limit.

The ```text``` attribute of a link should be omitted as it will always be filled in from the post text.

##### Example

If you created the following post:

```js
{
    "text": "I love this website!",
    "entities": {
        "links": [
            {
                "pos": 7,
                "len": 12,
                "url": "https://alpha.app.net"
            }
        ]
    }
}
```

App.net will store and return:

```js
{
    "text": "I love this website [alpha.app.net]!",
    "entities": {
        "links": [
            {
                "pos": 7,
                "len": 12,
                "url": "https://alpha.app.net"
            }
        ]
    },
    ...
}
```

## Filter

A Filter restricts a stream of messages on the server side so your client only sees what it's interested in. [Streams](#stream) are currently the only way to use filters right now.

```js
{
    "clauses": [
        {
            "field": "/data/entities/hashtags/*/name",
            "object_type": "post",
            "operator": "contains",
            "value": "rollout"
        }
    ],
    "id": "1",
    "match_policy": "include_any",
    "name": "Posts about rollouts"
}
```

### Filter fields

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
            <td><code>id</code></td>
            <td>string</td>
            <td>Primary identifier for a filter. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
        </tr>
        <tr>
            <td><code>name</code></td>
            <td>string</td>
            <td>An optional User assigned name for this filter.</td>
        </tr>
        <tr>
            <td><code>clauses</code></td>
            <td>list</td>
            <td>A list of <a href="#filter-clauses">filter clauses</a> to match against. Must be non-empty.</td>
        </tr>
        <tr>
            <td><code>match_policy</code></td>
            <td>string</td>
            <td>How should the clauses be joined together? One of <code>include_any</code>, <code>include_all</code>, <code>exclude_any</code>, or <code>exclude_all</code>. For example, <code>include_any</code> will include a message if it matches any of the clauses and <code>exclude_all</code> will exclude a message if it matches all of the clauses. This allows either white- or blacklist filtering.</td>
        </tr>
    </tbody>
</table>

### Filter Clauses

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
            <td><code>object_type</code></td>
            <td>string</td>
            <td>What type of object does this filter operate on? Must be one of <code>post</code>, <code>star</code>, <code>user_follow</code>. </td>
        </tr>
        <tr>
            <td><code>operator</code></td>
            <td>string</td>
            <td>How should <code>field</code> be matched against <code>value</code>.
                <br>
                <table>
                    <tr>
                        <th>Operator</th>
                        <th>Description</th>
                    </tr>
                    <tr>
                        <td><code>equals</code></td>
                        <td>Does <code>field</code> equal <code>value</code>.</td>
                    </tr>
                    <tr>
                        <td><code>matches</code></td>
                        <td>Is the string <code>value</code> a substring of <code>field</code>.</td>
                    </tr>
                    <tr>
                        <td><code>lt</code></td>
                        <td>Is the integer in <code>field</code> &lt; <code>value</code>.</td>
                    </tr>
                    <tr>
                        <td><code>le</code></td>
                        <td>Is the integer in <code>field</code> &le; <code>value</code>.</td>
                    </tr>
                    <tr>
                        <td><code>gt</code></td>
                        <td>Is the integer in <code>field</code> &gt; <code>value</code>.</td>
                    </tr>
                    <tr>
                        <td><code>ge</code></td>
                        <td>Is the integer in <code>field</code> &ge; <code>value</code>.</td>
                    </tr>
                    <tr>
                        <td><code>one_of</code></td>
                        <td>Is the <code>field</code> an element in the list <code>value</code>.</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td><code>field</code></td>
            <td>string</td>
            <td>A <a href="#json-pointer">JSON Pointer</a> string that specifies what part of the message we should match against.</td>
        </tr>
        <tr>
            <td><code>value</code></td>
            <td>string, int, or list</td>
            <td>A string, integer, or list that the message's data is compared against. Some <a href="#filter-variables">variables</a> are also accepted.</td>
        </tr>
    </tbody>
</table>

### Filter variables

<table>
    <thead>
        <tr>
            <th>Value</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>$authorized_userids</code></td>
            <td>list</td>
            <td>A list of the current user ids who have authorized the App that is using this filter in a stream. Since this is a list, make sure you use the <code>one_of</code> operator with this variable.</td>
        </tr>
    </tbody>
</table>

### JSON Pointer

We use a slightly modified version of the [JSON Pointer](http://tools.ietf.org/html/draft-ietf-appsawg-json-pointer-04) standard to specify which part of a message we should filter against. According to the spec:

> JSON Pointer defines a string syntax for identifying a specific value within a JSON document.

For instance, in the message:

```js
{
    "data": [
        {
            "id": "2", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@mthurman stop trolling",
            "html": "<span itemprop=\"mention\" data-mention-name=\"mthurman\" data-mention-id=\"1\">@mthurman</span> stop trolling",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": "1",
            "thread_id": "1",
            "num_replies": 0,
            "num_reposts": 0,
            "num_stars": 0,
            "entities": {
                "mentions": [{
                    "name": "mthurman",
                    "id": "2",
                    "pos": 0,
                    "len": 9
                }],
                "hashtags": [{],
                "links": []
            },
            "you_reposted": false,
            "you_starred": false
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": "2",
        "min_id": "1",
        "more": false
    }
}
```

* ```/data/source/client_id``` = "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4"
* ```/data/entities/mentions/0/name``` = "mthurman"
* ```/data/num_replies``` = 0

We extend JSON pointer slightly to allow all the elements of a list to match. For example, to answer the question "Does this post contain the hashtag 'rollout'", you'd use a field selector like ```/data/entities/hashtags/*/name```. Following the JSON Pointer spec, if you'd like to encode a literal ```*``` you can use ```~2``` instead.


## Stream

A customized view of the global stream that is streamed to the client instead of polling.

```js
{
    "endpoint": "https://stream-channel.app.net...",
    "filter": {
        "clauses": [
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "contains",
                "value": "rollout"
            }
        ],
        "id": "1",
        "match_policy": "include_any",
        "name": "Posts about rollouts"
    },
    "id": "1",
    "object_types": [
        "post"
    ],
    "type": "long_poll",
    "key": "rollout_stream"
}
```

### Stream Fields

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
            <td><code>id</code></td>
            <td>string</td>
            <td>Primary identifier for a stream. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
        </tr>
        <tr>
            <td><code>endpoint</code></td>
            <td>string</td>
            <td>The fully qualified URL the client should use to connect to this stream.</td>
        </tr>
        <tr>
            <td><code>filter</code></td>
            <td>object</td>
            <td>An optional filter to apply when generating the stream.</td>
        </tr>
        <tr>
            <td><code>object_types</code></td>
            <td>list</td>
            <td>A list of strings that specify the kinds of objects this stream is interested in. Must be one of <code>post</code>, <code>star</code>, <code>user_follow</code>.</td>
        </tr>
        <tr>
            <td><code>type</code></td>
            <td>string</td>
            <td>A string specifying the type of stream this is. This can affect the transport method of the endpoint url as well as characteristics of the stream (how many messages it can process, how long lived it is, etc). Currently, the only option is <code>long_poll</code>.</td>
        </tr>
        <tr>
            <td><code>key</code></td>
            <td>string</td>
            <td>An optional User assigned string that names this stream so it's easy to query for later. If a key is given, it must be unique for all streams created by a single token.</td>
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
