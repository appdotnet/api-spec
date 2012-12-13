# Resources
The App.net Stream API is a JSON API.

Guiding principles are:

* Always return JSON. If you are using JSONP, the returned JSON will be wrapped in a function call.
* Utilize HTTP error codes and methods.
* In general, required parameters are in URLs; optional parameters are specified in the query string. **This is not always the case.**
* If we need complex data structures from you, you should send them as a JSON string. We don't need any more conventions for putting arrays and dictionaries directly into URL-encoded GET/POST values.
* We follow a convention of including the API version number in the resource path. API calls of version 0 are subject to change throughout the process. Once we promote something to version 1, we hope to keep its implementation stable.

## Hostname
Please use https://alpha-api.app.net/ to access the APIs.


## [Token](token)
<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Authentication Required?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/token.md#retrieve-current-token">Retrieve the current Token</a></td>
            <td>/stream/0/token</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

## [Users](users)

### Interacting with individual Users

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Authentication Required?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#retrieve-a-user">Retrieve a User</a></td>
            <td>/stream/0/users/[user_id]</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#update-a-user">Update a User</a></td>
            <td>/stream/0/users/me</td>
            <td>PUT</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#retrieve-a-users-avatar-image">Retrieve a User's avatar image</a></td>
            <td>/stream/0/users/[user_id]/avatar</td>
            <td>GET</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#update-a-users-avatar-image">Update a User's avatar image</a></td>
            <td>/stream/0/users/me/avatar</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#retrieve-a-users-cover-image">Retrieve a User's cover image</a></td>
            <td>/stream/0/users/[user_id]/cover</td>
            <td>GET</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#update-a-users-cover-image">Update a User's cover image</a></td>
            <td>/stream/0/users/me/cover</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#follow-a-user">Follow a User</a></td>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#unfollow-a-user">Unfollow a User</a></td>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>DELETE</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#mute-a-user">Mute a User</a></td>
            <td>/stream/0/users/[user_id]/mute</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#unmute-a-user">Unmute a User</a></td>
            <td>/stream/0/users/[user_id]/mute</td>
            <td>DELETE</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

### Retrieving lists of Users

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Authentication Required?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#search-for-users">Search for Users</a></td>
            <td>/stream/0/users/search</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#retrieve-multiple-users">Retrieve multiple Users</a></td>
            <td>/stream/0/users</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-a-user-is-following">Retrieve Users a User is following</a></td>
            <td>/stream/0/users/[user_id]/following</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-user-ids-a-user-is-following">Retrieve IDs of Users a User is following</a></td>
            <td>/stream/0/users/[user_id]/following/ids</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-following-a-user">Retrieve Users following a User</a></td>
            <td>/stream/0/users/[user_id]/followers</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-user-ids-following-a-user">Retrieve IDs of Users following a User</a></td>
            <td>/stream/0/users/[user_id]/followers/ids</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-muted-users">Retrieve Users muted by the current User</a></td>
            <td>/stream/0/users/me/muted</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-user-interactions-with-me">Retrieve Interactions with the current User</a></td>
            <td>/stream/0/users/me/interactions</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-who-have-reposted-a-post">Retrieve Users who reposted a Post</a></td>
            <td>/stream/0/posts/[post_id]/reposters</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-who-have-starred-a-post">Retrieve Users who starred a Post</a></td>
            <td>/stream/0/posts/[post_id]/stars</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

## [Posts](posts)

### Interacting with individual Posts
<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Authentication Required?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#create-a-post">Create a Post</a></td>
            <td>/stream/0/posts</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-post">Retrieve a Post</a></td>
            <td>/stream/0/posts/[post_id]</td>
            <td>GET</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#delete-a-post">Delete a Post</a></td>
            <td>/stream/0/posts/[post_id]</td>
            <td>DELETE</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#repost-a-post">Repost a Post</a></td>
            <td>/stream/0/posts/[post_id]/repost</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#unrepost-a-post">Unrepost a Post</a></td>
            <td>/stream/0/posts/[post_id]/repost</td>
            <td>DELETE</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#star-a-post">Star a Post</a></td>
            <td>/stream/0/posts/[post_id]/star</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#unstar-a-post">Unstar a Post</a></td>
            <td>/stream/0/posts/[post_id]/star</td>
            <td>DELETE</td>
            <td>Yes</td>
        </tr>

    </tbody>
</table>

### Retrieving lists of Posts

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Authentication Required?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-multiple-posts">Retrieve multiple Posts</a></td>
            <td>/stream/0/posts</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-posts-created-by-a-user">Retrieve a User's posts</a></td>
            <td>/stream/0/users/[user_id]/posts</td>
            <td>GET</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-posts-starred-by-a-user">Retrieve a User's starred posts</a></td>
            <td>/stream/0/users/[user_id]/stars</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-posts-mentioning-a-user">Retrieve Posts mentioning a User</a></td>
            <td>/stream/0/users/[user_id]/mentions</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-tagged-posts">Retrieve Posts containing a hashtag</a></td>
            <td>/stream/0/posts/tag/[hashtag]</td>
            <td>GET</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-the-replies-to-a-post">Retrieve replies to a Post</a></td>
            <td>/stream/0/posts/[post_id]/replies</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-users-personalized-stream">Retrieve a User's personalized stream</a></td>
            <td>/stream/0/posts/stream</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-users-unified-stream">Retrieve a User's unified stream</a></td>
            <td>/stream/0/posts/stream/unified</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-the-global-stream">Retrieve the Global stream</a></td>
            <td>/stream/0/posts/stream/global</td>
            <td>GET</td>
            <td>No</td>
        </tr>
    </tbody>
</table>

## [Streams](streams)

### Interacting with individual Streams

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#create-a-stream">Create a Stream</a></td>
            <td>/stream/0/streams</td>
            <td>POST</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#retrieve-a-stream">Retrieve a Stream</a></td>
            <td>/stream/0/streams/[streams_id]</td>
            <td>GET</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#delete-a-stream">Delete a Stream</a></td>
            <td>/stream/0/streams/[streams_id]</td>
            <td>DELETE</td>
        </tr>
    </tbody>
</table>

### Interacting with multiple Streams

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#get-current-tokens-streams">Retrieve all Streams for the current Token</a></td>
            <td>/stream/0/streams</td>
            <td>GET</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#delete-all-of-the-current-tokens-streams">Delete all Streams for the current Token</a></td>
            <td>/stream/0/streams</td>
            <td>DELETE</td>
        </tr>
    </tbody>
</table>

## [Filters](filters)

### Interacting with individual Filters

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#create-a-filter">Create a Filter</a></td>
            <td>/stream/0/filters</td>
            <td>POST</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#retrieve-a-filter">Retrieve a Filter</a></td>
            <td>/stream/0/filters/[filter_id]</td>
            <td>GET</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#update-a-filter">Update a Filter</a></td>
            <td>/stream/0/filters/[filter_id]</td>
            <td>PUT</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#delete-a-filter">Delete a Filter</a></td>
            <td>/stream/0/filters/[filter_id]</td>
            <td>DELETE</td>
        </tr>
    </tbody>
</table>

### Interacting with multiple Filters

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#get-current-users-filters">Get the current User's Filters</a></td>
            <td>/stream/0/filters</td>
            <td>GET</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#delete-all-of-the-current-users-filters">Delete the current User's Filters</a></td>
            <td>/stream/0/filters</td>
            <td>DELETE</td>
        </tr>
    </tbody>
</table>

## [Stream Markers](stream_markers)

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Authentication Required?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#update-a-stream-marker">Update a Stream Marker</a></td>
            <td>/stream/0/posts/marker</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

## [Web Intents](web_intents)

## [Feeds](feeds) 

## [Subscriptions](subscriptions)
