# Posts

Posts are currently the best implemented objects on the system. If you're looking to play around with part of the API, start here.

## General parameters

Requests for streams of Posts can be filtered by passing query string parameters along with the request.

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>min_id</code> (<em><a href="#deprecating-min_id-and-max_id">Deprecating</a></em>)</td>
            <td>Optional</td>
            <td>string</td>
            <td>The minimum Post id to return (the response *will include* this post id if it is valid).</td>
        </tr>
        <tr>
            <td><code>max_id</code> (<em><a href="#deprecating-min_id-and-max_id">Deprecating</a></em>)</td>
            <td>Optional</td>
            <td>string</td>
            <td>The maximum Post id to return (the response *will include* this post id if it is valid)</td>
        </tr>
        <tr>
            <td><code>since_id</code></td>
            <td>Optional</td>
            <td>string</td>
            <td>Include posts with ids greater than this id. This value is not guaranteed to be a Post id and should come from the <code>max_id</code> parameter of a previous request's <a href="/appdotnet/api-spec/blob/master/responses.md#pagination-metadata">pagination metadata</a>. The response <strong>will not include</strong> this id.</td>
        </tr>
        <tr>
            <td><code>before_id</code></td>
            <td>Optional</td>
            <td>string</td>
            <td>Include posts with ids smaller than this id. This value is not guaranteed to be a Post id and should come from the <code>min_id</code> parameter of a previous request's <a href="/appdotnet/api-spec/blob/master/responses.md#pagination-metadata">pagination metadata</a>. The response <strong>will not include</strong> this id.</td>
        </tr>
        <tr>
            <td><code>count</code></td>
            <td>Optional</td>
            <td>integer</td>
            <td>The number of Posts to return, up to a maximum of 200. Sorry, negative counts are temporarily disabled.</td>
        </tr>
        <tr>
            <td><code>include_muted</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should posts from muted users be included? Defaults to false except when you specifically request a Post from a muted user or when you specifically request a muted user's stream.</td>
        </tr>
        <tr>
            <td><code>include_deleted</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should deleted posts be included? Defaults to true.</td>
        </tr>
        <tr>
            <td><code>include_directed_posts</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should posts directed at people I don't follow be included? A directed post is a post that starts with 1 or more @mentions. A machine only post with mentions is also considered a directed post. Defaults to false for "My Stream" and true everywhere else.</td>
        </tr>
        <tr>
            <td><code>include_machine</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/appdotnet/api-spec/blob/master/objects.md#machine-only-posts">machine only posts</a> be included? (Default: <code>False</code>)</td>
        </tr>
        <tr>
            <td><code>include_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should the <a href="/appdotnet/api-spec/blob/master/annotations.md">user and post annotations</a> be included in the Post? (Default: <code>False</code>)</td>
        </tr>
        <tr>
            <td><code>include_post_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should the <a href="/appdotnet/api-spec/blob/master/annotations.md">post annotations</a> be included in the Post? (Default: <code>False</code>)</td>
        </tr>
        <tr>
            <td><code>include_user_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should the <a href="/appdotnet/api-spec/blob/master/annotations.md">user annotations</a> be included in the Post? (Default: <code>False</code>)</td>
        </tr>
        <tr>
            <td><code>include_starred_by</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should a sample of Users who have starred a Post be returned with the Post objects? Please see the <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post schema</a>. (Default: <code>False</code>)</td>
        </tr>
        <tr>
            <td><code>include_reposters</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should a sample of Users who have reposted a Post be returned with the Post objects? Please see the <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post schema</a>. (Default: <code>False</code>)</td>
        </tr>
        <tr>
            <td><code>include_user</code> (<em>Coming soon</em>)</td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should the nested User object be included in the Post? (Default depends upon the endpoint)</td>
        </tr>
    </tbody>
</table>

### Deprecating min_id and max_id

After thinking through the pagination use cases more, we don't think ```min_id``` and ```max_id``` are the most useful parameters. We're planning on deprecating them in favor of ```since_id``` and ```before_id```. If you have a use case that would benefit from inclusive parameters (```min_id``` and ```max_id```), please [let us know](https://github.com/appdotnet/api-spec/issues).

## Sorting Posts

Post id is the ordering field for multiple posts (not ```created_at```). ```created_at``` is meant to be displayed to users, not to sort posts. This also makes pagination with ```since_id``` and ```before_id``` more straightforward. Posts are presently always returned in reverse chronological order (newest to oldest). As a result, the Posts endpoints will always return the newest posts that meet the requested criteria e.g. before_id and count.

## Create a Post
Create a new <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a> object. Mentions and hashtags will be parsed out of the post text, as will bare URLs.

You can also create a Post by sending JSON in the HTTP post body that matches the <a href="/appdotnet/api-spec/blob/master/objects.md#post">post schema</a> with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```text```, ```reply_to```, ```machine_only```, ```annotations``` and ```entities```. To create complex posts (including [machine only posts](/appdotnet/api-spec/blob/master/objects.md#machine-only-posts)), you must use the JSON interface. See the [JSON example](#json-example) below. If you would like to specify your own entities, please refer to the [user specified entites](/appdotnet/api-spec/blob/master/objects.md#user-specified-entities) documentation.

*Note: You cannot reply to a repost. Please reply to the parent Post.*


> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### Required Scopes

* ```write_post```

### URL
> https://alpha-api.app.net/stream/0/posts

### Data

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>text</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The raw text of the post</td>
        </tr>
        <tr>
            <td><code>reply_to</code></td>
            <td>Optional</td>
            <td>string</td>
            <td>The id of the post that this new post is replying to</td>
        </tr>
    </tbody>
</table>

### Example

> POST https://alpha-api.app.net/stream/0/posts
>
> DATA text=%40berg+FIRST+post+on+this+new+site+%23newsocialnetwork
```js
{
    "data": {
        "id": "1", // note this is a string
        "user": {
            ...
        },
        "created_at": "2012-07-16T17:25:47Z",
        "text": "@berg FIRST post on this new site #newsocialnetwork",
        "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on this new site <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
        "source": {
            "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
            "name": "Clientastic for iOS",
            "link": "http://app.net"
        },
        "machine_only": false,
        "reply_to": null,
        "thread_id": "1",
        "num_replies": 0,
        "num_reposts": 0,
        "num_stars": 0,
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
            "links": []
        },
        "you_reposted": false,
        "you_starred": false
    },
    "meta": {
        "code": 200,
    }
}
```

### JSON Example

> POST https://alpha-api.app.net/stream/0/posts?include_post_annotations=1
> 
> Content-Type: application/json
> 
> DATA '{"text": "@berg FIRST post on this new site #newsocialnetwork", "annotations": [{"type": "net.app.core.geolocation", "value": {"latitude": 74.0064, "longitude": 40.7142}}]}'
```js
{
    "data": {
        "id": "1", // note this is a string
        "user": {
            ...
        },
        "created_at": "2012-07-16T17:25:47Z",
        "text": "@berg FIRST post on this new site #newsocialnetwork",
        "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on this new site <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
        "source": {
            "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
            "name": "Clientastic for iOS",
            "link": "http://app.net"
        },
        "machine_only": false,
        "reply_to": null,
        "thread_id": "1",
        "num_replies": 0,
        "num_reposts": 0,
        "num_stars": 0,
        "annotations": [
            {
                "type": "net.app.core.geolocation",
                "value": {
                    "latitude": 74.0064,
                    "longitude": 40.7142
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
            "links": []
        },
        "you_reposted": false,
        "you_starred": false
    },
    "meta": {
        "code": 200,
    }
}
```

## Retrieve multiple Posts
Returns multiple Posts requested by id. At most 200 posts can be requested.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts

### Parameters

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>ids</code></td>
            <td>Required</td>
            <td>string</td>
            <td>A comma separated list of Post ids to retrieve.</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/posts?ids=1,2,3
```js
{
    "data": [
        {
            "id": "1", // note this is a string
            ...
        },
        {
            "id": "2",
            ...
        },
        {
            "id": "3",
            ...
        },
    ],
    "meta": {
        "code": 200,
    }
}
```

## Retrieve a Post
Returns a specific <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts/[post_id]

### Parameters

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>post_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The post id</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/posts/1
```js
{
    "data": {
        "id": "1", // note this is a string
        "user": {
            ...
        },
        "created_at": "2012-07-16T17:25:47Z",
        "text": "@berg FIRST post on this new site #newsocialnetwork",
        "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
        "source": {
            "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
            "name": "Clientastic for iOS",
            "link": "http://app.net"
        },
        "machine_only": false,
        "reply_to": null,
        "thread_id": "1",
        "num_replies": 3,
        "num_reposts": 0,
        "num_stars": 0,
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
        "you_reposted": false,
        "you_starred": false
    },
    "meta": {
        "code": 200,
    }
}
```

## Delete a Post

Delete a <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>. The current user must be the same user who created the Post. It returns the deleted Post on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/appdotnet/api-spec/blob/master/auth.md#authenticated-api-requests).*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts/[post_id]

### Data

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>post_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The post id</td>
        </tr>
    </tbody>
</table>

### Example

> DELETE https://alpha-api.app.net/stream/0/posts/1
```js
{
    "data": {
        "id": "1", // note this is a string
        "user": {
            ...
        },
        "created_at": "2012-07-16T17:25:47Z",
        "text": "@berg FIRST post on this new site #newsocialnetwork",
        "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
        "source": {
            "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
            "name": "Clientastic for iOS",
            "link": "http://app.net"
        },
        "machine_only": false,
        "reply_to": null,
        "thread_id": "1",
        "num_replies": 3,
        "num_reposts": 0,
        "num_stars": 0,
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
        "you_reposted": false,
        "you_starred": false
    },
    "meta": {
        "code": 200,
    }
}
```

## Retrieve the replies to a Post

Retrieve all the <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s that are in the same thread as this post. The specified Post does not have to be the root of the conversation. Additionally, the specified Post will be included in the response at the appropriate place.

**This endpoint would be more accurately named ```stream/0/posts/[post_id]/thread``` and may be renamed in a later API version.**

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts/[post_id]/replies

### Parameters

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>post_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The post id</td>
        </tr>
    </tbody>
</table>

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/1/replies
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

## Retrieve Posts created by a User

Get the most recent <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s created by a specific <a href="/appdotnet/api-spec/blob/master/objects.md#user">User</a> in reverse post order.

*Note: the User object is not returned for these Posts.*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/users/[user_id]/posts

### Parameters

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>user_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>.</td>
        </tr>
    </tbody>
</table>

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/users/1/posts
```js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
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
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "47",
        "min_id": "1"
        "more": true
    }
}
```

## Repost a Post

Share a Post (specified with post_id) with your followers. Reposts are intended solely as a routing mechanism; a repost's text, entities, and html are "inherited" from the original Post. If a user would like to quote, comment on, or alter a Post, reposts are not the solution. Reposts are meant to be pointers to another Post.

For compatibility with clients who don't wish to show reposts specially, we set a repost's text field to be ```>> @username: original text```. **Thus the text field could actually be slightly longer than 256 characters.** Most clients will probably want to display the original post (with some indication that is has been reposted). When rendering a repost, we recommend you pull most of your information from ```repost_of``` and make use of the ```repost_of.reposters``` field.

- Reposts cannot be reposted, starred, or replied to. Please take those actions on the parent post.
- Reposts do not show up in the hashtags, mentions or global streams.
- A repost of Post A will only show up in a User's stream if they have not seen Post A (or another repost of Post A) in a reasonable amount of time (currently 1 week).

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts/[post_id]/repost

### Data

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>post_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The post id</td>
        </tr>
    </tbody>
</table>

### Example

> POST https://alpha-api.app.net/stream/0/posts/1/repost
```js
{
    "data": {
        "id": "2",
        "user": {
            ...
        },
        "created_at": "2012-09-13T21:26:19Z",
        "entities": {
            "hashtags": [],
            "links": [],
            "mentions": [{
                "name": "berg",
                "id": "2",
                "pos": 3,
                "len": 5
            }]
        },
        "text": ">> @berg: a really insightful post that must be shared with the world"
        "html": ">> <span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span>: a really insightful post that must be shared with the world",
        "source": {
            "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
            "name": "Clientastic for iOS",
            "link": "http://app.net"
        },
        "machine_only": false,
        "reply_to": null,
        "thread_id": "2",
        "num_replies": 0,
        "num_reposts": 0,
        "num_stars": 0,
        "you_reposted": false,
        "you_starred": false
        "repost_of": {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "a really insightful post that must be shared with the world",
            "html": "a really insightful post that must be shared with the world",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 1,
            "num_stars": 0,
            "entities": {
                "mentions": [],
                "hashtags": [],
                "links": []
            },
            "you_reposted": true,
            "you_starred": false
        },
    },
    "meta": {
        "code": 200,
    }
}
```

## Unrepost a Post

Given the original ```post_id```, delete the current user's repost. *Note: this same functionality can be accomplished by [deleting using the repost's post_id](#delete-a-post)*.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts/[post_id]/repost

### Data

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>post_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The post id</td>
        </tr>
    </tbody>
</table>

### Example

> DELETE https://alpha-api.app.net/stream/0/posts/1/repost
```js
{
    "data": {
        "id": "1", // note this is a string
        "user": {
            ...
        },
        "created_at": "2012-07-16T17:25:47Z",
        "text": "@berg FIRST post on this new site #newsocialnetwork",
        "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
        "source": {
            "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
            "name": "Clientastic for iOS",
            "link": "http://app.net"
        },
        "machine_only": false,
        "reply_to": null,
        "thread_id": "1",
        "num_replies": 3,
        "num_reposts": 0,
        "num_stars": 0,
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
        "you_reposted": false,
        "you_starred": false
    },
    "meta": {
        "code": 200,
    }
}
```

## Star a Post

Save a given Post to the current User's stars. This is just a "save" action, not a sharing action. A User's stars are visible to others, but they are not automatically added to your followers' streams.

*Note: A repost cannot be starred. Please star the parent Post.*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts/[post_id]/star

### Data

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>post_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The post id</td>
        </tr>
    </tbody>
</table>

### Example

> POST https://alpha-api.app.net/stream/0/posts/1/star
```js
{
    "data": {
        "id": "1", // note this is a string
        "user": {
            ...
        },
        "created_at": "2012-07-16T17:25:47Z",
        "text": "@berg FIRST post on this new site #newsocialnetwork",
        "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
        "source": {
            "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
            "name": "Clientastic for iOS",
            "link": "http://app.net"
        },
        "machine_only": false,
        "reply_to": null,
        "thread_id": "1",
        "num_replies": 3,
        "num_reposts": 0,
        "num_stars": 1,
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
        "you_reposted": false,
        "you_starred": true
    },
    "meta": {
        "code": 200,
    }
}
```

## Unstar a Post

Remove a Star from a Post.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts/[post_id]/star

### Data

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>post_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The post id</td>
        </tr>
    </tbody>
</table>

### Example

> DELETE https://alpha-api.app.net/stream/0/posts/1/star
```js
{
    "data": {
        "id": "1", // note this is a string
        "user": {
            ...
        },
        "created_at": "2012-07-16T17:25:47Z",
        "text": "@berg FIRST post on this new site #newsocialnetwork",
        "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
        "source": {
            "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
            "name": "Clientastic for iOS",
            "link": "http://app.net"
        },
        "machine_only": false,
        "reply_to": null,
        "thread_id": "1",
        "num_replies": 3,
        "num_reposts": 0,
        "num_stars": 0,
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
        "you_reposted": false,
        "you_starred": false
    },
    "meta": {
        "code": 200,
    }
}
```

## Retrieve Posts starred by a User

Get the most recent <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s starred by a specific <a href="/appdotnet/api-spec/blob/master/objects.md#user">User</a> in reverse post order. Stars are a way for Users to
save posts without rebroadcasting the Post to their followers.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/users/[user_id]/stars

### Parameters

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>user_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>.</td>
        </tr>
    </tbody>
</table>

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/users/1/stars
```js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 1,
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
            "you_reposted": false,
            "you_starred": true
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "47",
        "min_id": "1"
        "more": true
    }
}
```

## Retrieve Posts mentioning a User

Get the most recent <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s mentioning by a specific <a href="/appdotnet/api-spec/blob/master/objects.md#user">User</a> in reverse post order.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/users/[user_id]/mentions

### Parameters

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>user_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>.</td>
        </tr>
    </tbody>
</table>

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/users/2/mentions
```js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
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
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "36",
        "min_id": "1",
        "more": false
    }
}
```

## Retrieve a User's personalized stream

Return the 20 most recent <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s from the current User and the Users they follow.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts/stream

### Parameters

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/stream
```js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
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
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "39",
        "min_id": "1",
        "more": true
    }
}
```

## Retrieve a User's unified stream

Return the 20 most recent [Post](/appdotnet/api-spec/blob/master/objects.md#post)s from the current User's [personalized stream](#retrieve-a-users-personalized-stream) and [mentions stream](#retrieve-posts-mentioning-a-user) merged into one stream.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts/stream/unified

### Parameters

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/stream/unified
```js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
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
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "39",
        "min_id": "1",
        "more": true
    }
}
```

## Retrieve the Global stream

Return the 20 most recent <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s from the Global stream.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts/stream/global

### Parameters

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/stream/global
```js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
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
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "33",
        "min_id": "1",
        "more": true
    }
}
```
## Retrieve tagged Posts

Return the 20 most recent <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s for a specific hashtag.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/posts/tag/[hashtag]

### Parameters

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/tag/newsocialnetwork
```js
{
    "data": [
        ...
        {
            "id": "1", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@berg FIRST post on this new site #newsocialnetwork",
            "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": null,
            "thread_id": "1",
            "num_replies": 3,
            "num_reposts": 0,
            "num_stars": 0,
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
            "you_reposted": false,
            "you_starred": false
        },
    ],
    "meta": {
        "code": 200,
        "max_id": "78",
        "min_id": "1",
        "more": false
    }
}
```
