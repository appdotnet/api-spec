# Resources

* TOC
{:toc}

The App.net API is a JSON API.

Guiding principles are:

* Always return JSON. If you are using JSONP, the returned JSON will be wrapped in a function call.
* Utilize HTTP error codes and methods.
* In general, required parameters are in URLs; optional parameters are specified in the query string. **This is not always the case.**
* If we need complex data structures from you, you should send them as a JSON string. We don't need any more conventions for putting arrays and dictionaries directly into URL-encoded GET/POST values.
* We follow a convention of including the API version number in the resource path. API calls of version 0 are subject to change throughout the process. Once we promote something to version 1, we hope to keep its implementation stable.

## Hostname
Please use https://alpha-api.app.net/ to access the APIs.

## [User](/docs/resources/user/)

### Interacting with individual Users

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/user/lookup/#retrieve-a-user">Retrieve a User</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/profile/#update-a-user">Update a User</a></td>
            <td>PUT</td>
            <td>/stream/0/users/me</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/profile/#retrieve-a-users-avatar-image">Retrieve a User's avatar image</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/avatar</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/profile/#update-a-users-avatar-image">Update a User's avatar image</a></td>
            <td>POST</td>
            <td>/stream/0/users/me/avatar</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/profile/#retrieve-a-users-cover-image">Retrieve a User's cover image</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/cover</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/profile/#update-a-users-cover-image">Update a User's cover image</a></td>
            <td>POST</td>
            <td>/stream/0/users/me/cover</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#follow-a-user">Follow a User</a></td>
            <td>POST</td>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#unfollow-a-user">Unfollow a User</a></td>
            <td>DELETE</td>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/muting/#mute-a-user">Mute a User</a></td>
            <td>POST</td>
            <td>/stream/0/users/[user_id]/mute</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/muting/#unmute-a-user">Unmute a User</a></td>
            <td>DELETE</td>
            <td>/stream/0/users/[user_id]/mute</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

### Retrieving lists of Users

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/user/lookup/#search-for-users">Search for Users</a></td>
            <td>GET</td>
            <td>/stream/0/users/search</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/lookup/#retrieve-multiple-users">Retrieve multiple Users</a></td>
            <td>GET</td>
            <td>/stream/0/users</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#list-users-a-user-is-following">Retrieve Users a User is following</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/following</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#list-user-ids-a-user-is-following">Retrieve IDs of Users a User is following</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/following/ids</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#list-users-following-a-user">Retrieve Users following a User</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/followers</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#list-user-ids-following-a-user">Retrieve IDs of Users following a User</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/followers/ids</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/muting/#list-muted-users">Retrieve Users muted by the current User</a></td>
            <td>GET</td>
            <td>/stream/0/users/me/muted</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/post-interactions/#list-users-who-have-reposted-a-post">Retrieve Users who reposted a Post</a></td>
            <td>GET</td>
            <td>/stream/0/posts/[post_id]/reposters</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/post-interactions/#list-users-who-have-starred-a-post">Retrieve Users who starred a Post</a></td>
            <td>GET</td>
            <td>/stream/0/posts/[post_id]/stars</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

## [Post](/docs/resources/post/)

### Interacting with individual Posts
<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/post/lifecycle/#create-a-post">Create a Post</a></td>
            <td>POST</td>
            <td>/stream/0/posts</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/lookup/#retrieve-a-post">Retrieve a Post</a></td>
            <td>GET</td>
            <td>/stream/0/posts/[post_id]</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/lifecycle/#delete-a-post">Delete a Post</a></td>
            <td>DELETE</td>
            <td>/stream/0/posts/[post_id]</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/reposts/#repost-a-post">Repost a Post</a></td>
            <td>POST</td>
            <td>/stream/0/posts/[post_id]/repost</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/reposts/#unrepost-a-post">Unrepost a Post</a></td>
            <td>DELETE</td>
            <td>/stream/0/posts/[post_id]/repost</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/stars/#star-a-post">Star a Post</a></td>
            <td>POST</td>
            <td>/stream/0/posts/[post_id]/star</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/stars/#unstar-a-post">Unstar a Post</a></td>
            <td>DELETE</td>
            <td>/stream/0/posts/[post_id]/star</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

### Retrieving lists of Posts

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/post/lookup/#retrieve-multiple-posts">Retrieve multiple Posts</a></td>
            <td>GET</td>
            <td>/stream/0/posts</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-posts-created-by-a-user">Retrieve a User's posts</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/posts</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/stars/#retrieve-posts-starred-by-a-user">Retrieve a User's starred posts</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/stars</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-posts-mentioning-a-user">Retrieve Posts mentioning a User</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/mentions</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-tagged-posts">Retrieve Posts containing a hashtag</a></td>
            <td>GET</td>
            <td>/stream/0/posts/tag/[hashtag]</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/replies">Retrieve replies to a Post</a></td>
            <td>GET</td>
            <td>/stream/0/posts/[post_id]/replies</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-a-users-personalized-stream">Retrieve a User's personalized stream</a></td>
            <td>GET</td>
            <td>/stream/0/posts/stream</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-a-users-unified-stream">Retrieve a User's unified stream</a></td>
            <td>GET</td>
            <td>/stream/0/posts/stream/unified</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-the-global-stream">Retrieve the Global stream</a></td>
            <td>GET</td>
            <td>/stream/0/posts/stream/global</td>
            <td>No</td>
        </tr>
    </tbody>
</table>

## [Channel](/docs/resources/channel/)

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>

    </tbody>
</table>

## [Message](/docs/resources/message/)

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>

    </tbody>
</table>

## [Stream](/docs/resources/stream/)

### Interacting with individual Streams

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/stream/lifecycle/#create-a-stream">Create a Stream</a></td>
            <td>POST</td>
            <td>/stream/0/streams</td>
            <td></td>
        </tr>
        <tr>
            <td><a href="/docs/resources/stream/lifecycle/#retrieve-a-stream">Retrieve a Stream</a></td>
            <td>GET</td>
            <td>/stream/0/streams/[streams_id]</td>
            <td></td>
        </tr>
        <tr>
            <td><a href="/docs/resources/stream/lifecycle/#delete-a-stream">Delete a Stream</a></td>
            <td>DELETE</td>
            <td>/stream/0/streams/[streams_id]</td>
            <td></td>
        </tr>
    </tbody>
</table>

### Interacting with multiple Streams

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/stream/lifecycle/#get-current-tokens-streams">Retrieve all Streams for the current Token</a></td>
            <td>GET</td>
            <td>/stream/0/streams</td>
            <td></td>
        </tr>
        <tr>
            <td><a href="/docs/resources/stream/lifecycle/#delete-all-of-the-current-users-streams">Delete all Streams for the current Token</a></td>
            <td>DELETE</td>
            <td>/stream/0/streams</td>
            <td></td>
        </tr>
    </tbody>
</table>

## [Filter](/docs/resources/filter/)

### Interacting with individual Filters

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/filter/lifecycle/#create-a-filter">Create a Filter</a></td>
            <td>POST</td>
            <td>/stream/0/filters</td>
            <td></td>
        </tr>
        <tr>
            <td><a href="/docs/resources/filter/lifecycle/#retrieve-a-filter">Retrieve a Filter</a></td>
            <td>GET</td>
            <td>/stream/0/filters/[filter_id]</td>
            <td></td>
        </tr>
        <tr>
            <td><a href="/docs/resources/filter/lifecycle/#update-a-filter">Update a Filter</a></td>
            <td>PUT</td>
            <td>/stream/0/filters/[filter_id]</td>
            <td></td>
        </tr>
        <tr>
            <td><a href="/docs/resources/filter/lifecycle/#delete-a-filter">Delete a Filter</a></td>
            <td>DELETE</td>
            <td>/stream/0/filters/[filter_id]</td>
            <td></td>
        </tr>
    </tbody>
</table>

### Interacting with multiple Filters

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/filter/lifecycle/#get-current-users-filters">Get the current User's Filters</a></td>
            <td>GET</td>
            <td>/stream/0/filters</td>
            <td></td>
        </tr>
        <tr>
            <td><a href="/docs/resources/filter/lifecycle/#delete-all-of-the-current-users-filters">Delete the current User's Filters</a></td>
            <td>DELETE</td>
            <td>/stream/0/filters</td>
            <td></td>
        </tr>
    </tbody>
</table>

## [Interaction](/docs/resources/interaction/)

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/interaction/">Retrieve Interactions with the current User</a></td>
            <td>GET</td>
            <td>/stream/0/users/me/interactions</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

## [Stream Marker](/docs/resources/stream-marker/)

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/stream-marker/#update-a-stream-marker">Update a Stream Marker</a></td>
            <td>POST</td>
            <td>/stream/0/posts/marker</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

## [Token](/docs/resources/token/)
<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/token/#retrieve-current-token">Retrieve the current Token</a></td>
            <td>GET</td>
            <td>/stream/0/token</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>
