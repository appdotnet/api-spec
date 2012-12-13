# Reposts

* TOC
{:toc}

## Repost a Post

Share a Post (specified with post_id) with your followers. Reposts are intended solely as a routing mechanism; a repost's text, entities, and html are "inherited" from the original Post. If a user would like to quote, comment on, or alter a Post, reposts are not the solution. Reposts are meant to be pointers to another Post.

For compatibility with clients who don't wish to show reposts specially, we set a repost's text field to be ```>> @username: original text```. **Thus the text field could actually be slightly longer than 256 characters.** Most clients will probably want to display the original post (with some indication that is has been reposted). When rendering a repost, we recommend you pull most of your information from ```repost_of``` and make use of the ```repost_of.reposters``` field.

- Reposts cannot be reposted, starred, or replied to. Please take those actions on the parent post.
- Reposts do not show up in the hashtags, mentions or global streams.
- A repost of Post A will only show up in a User's stream if they have not seen Post A (or another repost of Post A) in a reasonable amount of time (currently 1 week).

<%= migration_warning ['response_envelope'] %>

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

~~~ js
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
~~~

## Unrepost a Post

Given the original ```post_id```, delete the current user's repost. *Note: this same functionality can be accomplished by [deleting using the repost's post_id](#delete-a-post)*.

<%= migration_warning ['response_envelope'] %>

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

~~~ js
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
~~~