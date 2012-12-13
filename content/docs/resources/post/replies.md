# Replies

## Retrieve the replies to a Post

Retrieve all the <a href="../objects/post.md">Post</a>s that are in the same thread as this post. The specified Post does not have to be the root of the conversation. Additionally, the specified Post will be included in the response at the appropriate place.

**This endpoint would be more accurately named ```stream/0/posts/[post_id]/thread``` and may be renamed in a later API version.**

<%= render 'partials/migration' %>

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

~~~ js
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
~~~