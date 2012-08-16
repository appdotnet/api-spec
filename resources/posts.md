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
            <td>Include posts with post ids greater than this id. The response <strong>will not include</strong> this post id.</td>
        </tr>
        <tr>
            <td><code>before_id</code></td>
            <td>Optional</td>
            <td>string</td>
            <td>Include posts with post ids smaller than this id. The response <strong>will not include</strong> this post id.</td>
        </tr>
        <tr>
            <td><code>count</code></td>
            <td>Optional</td>
            <td>integer</td>
            <td>The number of Posts to return, up to a maximum of 200.</td>
        </tr>
        <tr>
            <td><code>include_user</code></td>
            <td>Optional</td>
            <td>boolean</td>
            <td>Should the nested User object be included in the Post? (Default depends upon the endpoint)</td>
        </tr>
        <tr>
            <td><code>include_annotations</code></td>
            <td>Optional</td>
            <td>boolean</td>
            <td>Should the <a href="/appdotnet/api-spec/blob/master/objects.md#post-annotations">post annotations</a> be included in the Post? (Default: <code>True</code>)</td>
        </tr>
        <tr>
            <td><code>include_replies</code></td>
            <td>Optional</td>
            <td>boolean</td>
            <td>Should reply Posts be included in the results? (Default: <code>True</code>)</td>
        </tr>
    </tbody>
</table>

### Deprecating min_id and max_id

After thinking through the pagination use cases more, we don't think ```min_id``` and ```max_id``` are the most useful parameters. We're planning on deprecating them in favor of ```since_id``` and ```before_id```. If you have a use case that would benefit from inclusive parameters (```min_id``` and ```max_id```), please [let us know](https://github.com/appdotnet/api-spec/issues).

## Sorting Posts

Post id is the ordering field for multiple posts (not ```created_at```). ```created_at``` is meant to be displayed to users, not to sort posts. This also makes pagination with ```since_id``` and ```before_id``` more straightforward.

## Create a Post
Create a new <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a> object. Mentions and hashtags will be parsed out of the post text, as will bare URLs. To create a link in a post without using a bare URL, include the anchor text in the post's text and include a link entity in the post creation call.

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
        <tr>
            <td><code>annotations</code></td>
            <td>Optional</td>
            <td>string</td>
            <td>A JSON string that contains extended information about the Post as described in <a href="/appdotnet/api-spec/blob/master/objects.md#post-annotations">the post annotations documentation</a>.</td>
        </tr>
        <tr>
            <td><code>links</code></td>
            <td>Optional</td>
            <td>string</td>
            <td>A JSON string that contains formatting information for links when the anchor text is different than the URL. The JSON must follow the <a href="/appdotnet/api-spec/blob/master/objects.md#links">links entity specification</a>.</td>
        </tr>
    </tbody>
</table>

### Example

> POST https://alpha-api.app.net/stream/0/posts
> 
> DATA text=%40berg+FIRST+post+on+this+new+site+%23newsocialnetwork
```js
{
    "id": "1", // note this is a string
    "user": {
        ...
    },
    "created_at": "2012-07-16T17:25:47Z",
    "text": "@berg FIRST post on this new site #newsocialnetwork",
    "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on this new site <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
    "source": {
        "name": "Clientastic for iOS",
        "link": "http://app.net"
    },
    "reply_to": null,
    "thread_id": "1",
    "num_replies": 0,
    "annotations": {
        "wellknown:geo": {
            "type": "Point",
            "coordinates": [102.0, .5]
        }
    },
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
    }
}
```

## Retrieve a Post
Returns a specific <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>.

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
    "reply_to": null,
    "thread_id": "1",
    "num_replies": 3,
    "annotations": {
        "wellknown:geo": {
            "type": "Point",
            "coordinates": [102.0, .5]
        }
    },
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

## Delete a Post

Delete a <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>. The current user must be the same user who created the Post. It returns the deleted Post on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/appdotnet/api-spec/blob/master/auth.md#authenticated-api-requests).*

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
    "reply_to": null,
    "thread_id": "1",
    "num_replies": 3,
    "annotations": {
        "wellknown:geo": {
            "type": "Point",
            "coordinates": [102.0, .5]
        }
    },
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

## Retrieve the replies to a Post

Retrieve the Posts that are 'in reply to' a specific <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>.

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
[{
    "id": "2", // note this is a string
    "user": {
        ...
    },
    "created_at": "2012-07-16T17:25:47Z",
    "text": "@mthurman stop trolling",
    "html": "<span itemprop=\"mention\" data-mention-name=\"mthurman\" data-mention-id=\"1\">@mthurman</span> stop trolling",
    "source": {
        "name": "Clientastic for iOS",
        "link": "http://app.net"
    },
    "reply_to": "1",
    "thread_id": "1",
    "num_replies": 0,
    "annotations": {
        "wellknown:geo": {
            "type": "Point",
            "coordinates": [102.0, .5]
        }
    },
    "entities": {
        "mentions": [{
            "name": "mthurman",
            "id": "2",
            "pos": 0,
            "len": 9
        }],
        "hashtags": [{],
        "links": []
    }
},
...
]
```

## Retrieve Posts created by a User

Get the most recent <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s created by a specific <a href="/appdotnet/api-spec/blob/master/objects.md#user">User</a> in reverse post order.

*Note: the User object is not returned for these Posts.*

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
            <td>The user id. If the user id is <code>me</code> the current authenticated user will be used.</td>
        </tr>
    </tbody>
</table>

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/users/1/posts
```js
[{
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
    "reply_to": null,
    "thread_id": "1",
    "num_replies": 3,
    "annotations": {
        "wellknown:geo": {
            "type": "Point",
            "coordinates": [102.0, .5]
        }
    },
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
},
...
]
```

## Retrieve Posts mentioning a User

Get the most recent <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s mentioning by a specific <a href="/appdotnet/api-spec/blob/master/objects.md#user">User</a> in reverse post order.

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
            <td>The user id. If the user id is <code>me</code> the current authenticated user will be used.</td>
        </tr>
    </tbody>
</table>

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/users/2/mentions
```js
[{
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
    "reply_to": null,
    "thread_id": "1",
    "num_replies": 3,
    "annotations": {
        "wellknown:geo": {
            "type": "Point",
            "coordinates": [102.0, .5]
        }
    },
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
},
...
]
```

## Retrieve a User's personalized stream

Return the 20 most recent <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s from the current User and the Users they follow.

### URL
> https://alpha-api.app.net/stream/0/posts/stream

### Parameters

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/stream
```js
[{
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
    "reply_to": null,
    "thread_id": "1",
    "num_replies": 3,
    "annotations": {
        "wellknown:geo": {
            "type": "Point",
            "coordinates": [102.0, .5]
        }
    },
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
},
...
]
```


## Retrieve the Global stream

Return the 20 most recent <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s from the Global stream.

### URL
> https://alpha-api.app.net/stream/0/posts/stream/global

### Parameters

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/stream/global
```js
[{
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
    "reply_to": null,
    "thread_id": "1",
    "num_replies": 3,
    "annotations": {
        "wellknown:geo": {
            "type": "Point",
            "coordinates": [102.0, .5]
        }
    },
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
},
...
]
```
## Retrieve tagged Posts

Return the 20 most recent <a href="/appdotnet/api-spec/blob/master/objects.md#post">Post</a>s for a specific hashtag.

### URL
> https://alpha-api.app.net/stream/0/posts/tag/[hashtag]

### Parameters

*See [General Parameters](#general-parameters) for optional parameters you can use with this query.*

### Example

> GET https://alpha-api.app.net/stream/0/posts/tag/newsocialnetwork
```js
[{
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
    "reply_to": null,
    "thread_id": "1",
    "num_replies": 3,
    "annotations": {
        "wellknown:geo": {
            "type": "Point",
            "coordinates": [102.0, .5]
        }
    },
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
},
...
]
```
