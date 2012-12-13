# Interactions

* TOC
{:toc}

Interactions are objects that represent users taking certain actions on App.net. Currently an Interaction is created when a User replies to, reposts, or stars a Post, or follows another User. Interactions are structured to form a sentence like: User X took action Y on object Z. If multiple users take the same action (e.g. multiple users reply to one post) within a set time window those events will be combined into a single Interaction. 

> Note: currently only one User or Post will be returned in the ```objects``` list of an Interaction but future actions may target multiple objects per Interaction.

(Example) @dalton and @berg reposted post 1:

~~~ js
{
    "action": "repost",
    "objects": [
        {
            // ... post 1 ...
        }
    ],
    "users": [
        {
            // ... @berg's user object ...
        },
        {
            // ... @dalton's user object ...
        },
    ]
}
~~~

(Example) @berg started following @dalton:

~~~ js
{
    "action": "follow",
    "objects": [
        {
            // ... @dalton's user object ...
        }
    ],
    "users": [
        {
            // ... @berg's user object ...
        }
    ]
}
~~~

## Interactions Fields

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
            <td><code>action</code></td>
            <td>string</td>
            <td>What <code>users</code> did. Currently one of <code>follow</code>, <code>reply</code>, <code>repost</code>, or <code>star</code></td>
        </tr>
        <tr>
            <td><code>objects</code></td>
            <td>list</td>
            <td><code>users</code> took <code>action</code> on. These objects will be Users if <code>action=follow</code></td>
        </tr>
        <tr>
            <td><code>users</code></td>
            <td>list</td>
            <td>A list of User objects that took <code>action</code> on <code>objects</code>.</td>
        </tr>
    </tbody>
</table>

## List User interactions with me

List all the [Interactions](/docs/resources/interaction/) other users have had with me. 

> Note: you can only request this list for the current user.

<!-- blockquote break -->
> Note: although this endpoint supports paging, a user's Interactions stream is continuously rebuilt as new actions in the system occur, so developers should generally plan to refetch the stream whenever switching to display it as Interactions may have shifted their position, with users being added or removed. If you need to keep track of activity in a more precise manner, you should using the [Streaming API](/appdotnet/api-spec/blob/master/resources/streams.md) to monitor the global feed for relevant activity.

<!-- blockquote break -->
<%= migration_warning ['response_envelope'] %>

### URL
> https://alpha-api.app.net/stream/0/users/me/interactions

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/users/me/interactions

~~~ js
{
    "data": [
        {
            "action": "repost",
            "objects": [
                {
                    "id": "1",
                    ...
                }
            ],
            "users": [
                {
                    "id": "2",
                    ...
                },
                {
                    "id": "1",
                    ...
                },
            ]
        },
        {
            "action": "follow",
            "objects": [
                {
                    "id": "1",
                    ...
                }
            ],
            "users": [
                {
                    "id": "2",
                    ...
                }
            ]
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": 10,
        "min_id": 4,
        "more": true
    }
}
~~~