# Users

## Retrieve a User

Returns a specific <a href="/appdotnet/api-spec/blob/master/objects.md#user">User</a> object.

### URL
> https://alpha-api.app.net/stream/0/users/[user_id]

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

### Example

> GET https://alpha-api.app.net/stream/0/users/1
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
        "follows": 100,
        "followed_by": 200,
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

## Follow a User

Returns the <a href="/appdotnet/api-spec/blob/master/objects.md#user">User</a> object of the user being followed.

### URL
> https://alpha-api.app.net/stream/0/users/[user_id]/follow

### Parameters

None.

### Example

> POST https://alpha-api.app.net/stream/0/users/1/follow
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
        "follows": 100,
        "followed_by": 200,
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

## Unfollow a User

Returns the <a href="/appdotnet/api-spec/blob/master/objects.md#user">User</a> object of the user being unfollowed.

### URL
> https://alpha-api.app.net/stream/0/users/[user_id]/follow

### Parameters

None.

### Example

> DELETE https://alpha-api.app.net/stream/0/users/1/follow
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
        "follows": 100,
        "followed_by": 200,
        "posts": 24
    },
    "app_data": {
        "appdotnet": {...},
        "rdio": {...}
    },
    "follows_you": false,
    "you_follow": false,
    "you_muted": false,
}
```

## List users a user is following

Returns an array of <a href="/appdotnet/api-spec/blob/master/objects.md#user">User</a> objects the specified user is following.

### URL

> https://alpha-api.app.net/stream/0/users/[user_id]/following

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/users/2/following
```js
[{
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
        "follows": 100,
        "followed_by": 200,
        "posts": 24
    },
    "app_data": {
        "appdotnet": {...},
        "rdio": {...}
    },
    "follows_you": false,
    "you_follow": true,
    "you_muted": false,
},
...
]
```

## List users following a user

Returns an array of <a href="/appdotnet/api-spec/blob/master/objects.md#user">User</a> objects for users following the specified user.

### URL

> https://alpha-api.app.net/stream/0/users/[user_id]/followers

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/users/2/followers
```js
[{
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
        "follows": 100,
        "followed_by": 200,
        "posts": 24
    },
    "app_data": {
        "appdotnet": {...},
        "rdio": {...}
    },
    "follows_you": false,
    "you_follow": true,
    "you_muted": false,
},
...
]
```
