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
    "description": "Hi, I'm Mark Thurman and I'm teaching you about the App.net Stream API.",
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
