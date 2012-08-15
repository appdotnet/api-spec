# Resources
The App.net Stream API is a JSON API.

Guiding principles are:

* Always return JSON.
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
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>/stream/0/users/[user_id]</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#retrieve-a-user">Retrieve a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>POST</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#follow-a-user">Follow a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>DELETE</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#unfollow-a-user">Unfollow a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/following</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-a-user-is-following">List users a User is following</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/followers</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-following-a-user">List users following a User</a></td>
        </tr>
    </tbody>
</table>

## [Token](/appdotnet/api-spec/blob/master/resources/)
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
            <td>/stream/0/token</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/">Check current Token</a></td>
        </tr>
    </tbody>
</table>


## [Posts](/appdotnet/api-spec/blob/master/resources/posts.md)
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
            <td>/stream/0/posts</td>
            <td>POST</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#create-a-post">Create a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-post">Retrieve a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]</td>
            <td>DELETE</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#delete-a-post">Delete a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/[post_id]/replies</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-the-replies-to-a-post">Retrieve the replies to a Post</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/posts</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-posts-created-by-a-user">Retrieve Posts created by a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/users/[user_id]/mentions</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-posts-mentioning-a-user">Retrieve Posts mentioning a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/stream</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-a-users-personalized-stream">Retrieve a User's personalized stream</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/stream/global</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-the-global-stream">Retrieve the Global stream</a></td>
        </tr>
        <tr>
            <td>/stream/0/posts/tag/[hashtag]</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-tagged-posts">Retrieve tagged Posts</a></td>
        </tr>
    </tbody>
</table>

## [Streams](/appdotnet/api-spec/blob/master/resources/streams.md) -- coming soon
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
            <td>/stream/0/streams/user</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#retrieve-a-real-time-personalized-stream-for-a-user">Retrieve a real-time, personalized Stream for a User</a></td>
        </tr>
        <tr>
            <td>/stream/0/streams/app</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#retrieve-a-real-time-personalized-stream-for-multiple-users">Retrieve a real-time, personalized Stream for multiple Users</a></td>
        </tr>
        <tr>
            <td>/stream/0/streams/public</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#retrieve-a-public-stream-of-real-time-posts">Retrieve a public Stream of real-time posts</a></td>
        </tr>
        <tr>
            <td>/stream/0/streams/[stream_id]</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#get-stream-status">Get Stream status</a></td>
        </tr>
        <tr>
            <td>/stream/0/streams/[stream_id]</td>
            <td>POST</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/streams.md#control-a-stream">Control a Stream</a></td>
        </tr>
    </tbody>
</table>

## [Real-time updates](/appdotnet/api-spec/blob/master/resources/subscriptions.md) -- coming soon

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
            <td>/stream/0/subscriptions</td>
            <td>GET</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/subscriptions.md#list-subscriptions">List Subscriptions</a></td>
        </tr>
        <tr>
            <td>/stream/0/subscriptions</td>
            <td>POST</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/subscriptions.md#create-a-subscription">Create a Subscription</a></td>
        </tr>
        <tr>
            <td>/stream/0/subscriptions/[subscription_id]</td>
            <td>DELETE</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/subscriptions.md#delete-a-subscription">Delete a Subscription</a></td>
        </tr>
        <tr>
            <td>/stream/0/subscriptions</td>
            <td>DELETE</td>
            <td><a href="/appdotnet/api-spec/blob/master/resources/subscriptions.md#delete-all-subscriptions">Delete all Subscriptions</a></td>
        </tr>
    </tbody>
</table>

## [Filters](/appdotnet/api-spec/blob/master/resources/filters.md) -- coming soon

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
