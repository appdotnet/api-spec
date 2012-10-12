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

## [Users](/appdotnet/api-spec/blob/master/resources/users.md)
<table>
    <thead>
        <tr>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Authentication Required?</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>/stream/0/users/[user_id]</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#retrieve-a-user">Retrieve a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>POST</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#follow-a-user">Follow a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>DELETE</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#unfollow-a-user">Unfollow a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/following</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-a-user-is-following">List users a User is following</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/followers</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-following-a-user">List users following a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/mute</td>
            <td>POST</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#mute-a-user">Mute a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/mute</td>
            <td>DELETE</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#unmute-a-user">Unmute a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/me/muted</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-muted-users">List muted Users</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/search</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#search-for-users">Search for Users</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]/reposters</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-who-have-reposted-a-post">List Users who have reposted a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]/stars</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-who-have-starred-a-post">List Users who have starred a Post</a></td>
        </tr>
    </tbody>
</table>

## [Token](/appdotnet/api-spec/blob/master/resources/token.md)
<table>
    <thead>
        <tr>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Authentication Required?</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>/stream/0/token</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/token.md#retrieve-current-token">Check current Token</a></td>
        </tr>
    </tbody>
</table>


## [Posts](/appdotnet/api-spec/blob/master/resources/posts.md)
<table>
    <thead>
        <tr>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Authentication Required?</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>/stream/0/posts</td>
            <td>POST</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#create-a-post">Create a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]</td>
            <td>GET</td>
            <td>No</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-post">Retrieve a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]</td>
            <td>DELETE</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#delete-a-post">Delete a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]/replies</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-the-replies-to-a-post">Retrieve the replies to a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/posts</td>
            <td>GET</td>
            <td>No</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-posts-created-by-a-user">Retrieve Posts created by a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]/repost</td>
            <td>POST</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#repost-a-post">Repost a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]/repost</td>
            <td>DELETE</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#unrepost-a-post">Unrepost a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]/star</td>
            <td>POST</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#star-a-post">Star a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]/star</td>
            <td>DELETE</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#unstar-a-post">Unstar a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/stars</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-posts-starred-by-a-user">Retrieve Posts starred by a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/mentions</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-posts-mentioning-a-user">Retrieve Posts mentioning a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/stream</td>
            <td>GET</td>
            <td>Yes</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-users-personalized-stream">Retrieve a User's personalized stream</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/stream/global</td>
            <td>GET</td>
            <td>No</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-the-global-stream">Retrieve the Global stream</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/tag/[hashtag]</td>
            <td>GET</td>
            <td>No</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-tagged-posts">Retrieve tagged Posts</a></td>
        </tr>
    </tbody>
</table>

## [Filters](/appdotnet/api-spec/blob/master/resources/filters.md)

<table>
    <thead>
        <tr>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>/stream/0/filters</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#get-current-users-filters">Get current user's Filters</a></td>
        </tr>
        <tr>
            <td>/stream/0/filters</td>
            <td>POST</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#create-a-filter">Create a Filter</a></td>
        </tr>
        <tr>
            <td>/stream/0/filters</td>
            <td>DELETE</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#delete-all-of-the-current-users-filters">Delete all of the current user's Filters</a></td>
        </tr>
        <tr>
            <td>/stream/0/filters/[filter_id]</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#retrieve-a-filter">Retrieve a Filter</a></td>
        </tr>
        <tr>
            <td>/stream/0/filters/[filter_id]</td>
            <td>DELETE</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#delete-a-filter">Delete a Filter</a></td>
        </tr>
    </tbody>
</table>

## [Streams](/appdotnet/api-spec/blob/master/resources/streams.md)&mdash;experimental
<table>
    <thead>
        <tr>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>/stream/0/streams</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#get-current-tokens-streams">Get current tokens's Streams</a></td>
        </tr>
        <tr>
            <td>/stream/0/streams</td>
            <td>POST</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#create-a-stream">Create a Stream</a></td>
        </tr>
        <tr>
            <td>/stream/0/streams</td>
            <td>DELETE</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#delete-all-of-the-current-tokens-streams">Delete all of the current tokens's Stream</a></td>
        </tr>
        <tr>
            <td>/stream/0/streams/[streams_id]</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#retrieve-a-stream">Retrieve a Stream</a></td>
        </tr>
        <tr>
            <td>/stream/0/streams/[streams_id]</td>
            <td>DELETE</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#delete-a-stream">Delete a Stream</a></td>
        </tr>
    </tbody>
</table>
