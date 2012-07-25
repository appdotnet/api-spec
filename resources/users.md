# Users

## Retrieve a User

Returns a specific <a href="/appdotnet/api-spec/blob/master/objects.md#user">User</a> object.

### URL
> https://api.app.net/stream/1/users/[user_id]

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

> GET https://api.app.net/stream/1/users/1
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
               "indices": [52, 62]
           }],
           "hashtags": [{
               "name": "api",
               "indices": [70, 74]
           }],
           "links": [{
               "text": "teaching you",
               "url": "https://github.com/appdotnet/api-spec"
                   "indices": [29, 41],
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
}
```
