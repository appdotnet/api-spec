<table class='table table-striped'>
    <thead>
        <tr>
            <th width="410">Description</th>
            <th width="80">Method</th>
            <th width="320">Path</th>
            <th width="60">Token</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/post/lifecycle/#create-a-post">Create a Post</a></td>
            <td>POST</td>
            <td><code>/stream/0/posts</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/lookup/#retrieve-a-post">Retrieve a Post</a></td>
            <td>GET</td>
            <td><code>/stream/0/posts/{post_id}</code></td>
            <td>None</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/lifecycle/#delete-a-post">Delete a Post</a></td>
            <td>DELETE</td>
            <td><code>/stream/0/posts/{post_id}</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/reposts/#repost-a-post">Repost a Post</a></td>
            <td>POST</td>
            <td><code>/stream/0/posts/{post_id}/repost</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/reposts/#unrepost-a-post">Unrepost a Post</a></td>
            <td>DELETE</td>
            <td><code>/stream/0/posts/{post_id}/repost</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/stars/#star-a-post">Star a Post</a></td>
            <td>POST</td>
            <td><code>/stream/0/posts/{post_id}/star</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/stars/#unstar-a-post">Unstar a Post</a></td>
            <td>DELETE</td>
            <td><code>/stream/0/posts/{post_id}/star</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/lookup/#retrieve-multiple-posts">Retrieve multiple Posts</a></td>
            <td>GET</td>
            <td><code>/stream/0/posts</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-posts-created-by-a-user">Retrieve a User's posts</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}/posts</code></td>
            <td>None</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/stars/#retrieve-posts-starred-by-a-user">Retrieve a User's starred posts</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}/stars</code></td>
            <td>None</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-posts-mentioning-a-user">Retrieve Posts mentioning a User</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}/mentions</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-tagged-posts">Retrieve Posts containing a hashtag</a></td>
            <td>GET</td>
            <td><code>/stream/0/posts/tag/{hashtag}</code></td>
            <td>None</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/replies">Retrieve replies to a Post</a></td>
            <td>GET</td>
            <td><code>/stream/0/posts/{post_id}/replies</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-a-users-personalized-stream">Retrieve a User's personalized stream</a></td>
            <td>GET</td>
            <td><code>/stream/0/posts/stream</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-a-users-unified-stream">Retrieve a User's unified stream</a></td>
            <td>GET</td>
            <td><code>/stream/0/posts/stream/unified</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/streams/#retrieve-the-global-stream">Retrieve the Global stream</a></td>
            <td>GET</td>
            <td><code>/stream/0/posts/stream/global</code></td>
            <td>None</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/report/#report-a-post">Report a Post</a></td>
            <td>POST</td>
            <td><code>/stream/0/posts/{post_id}/report</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/post/search/#search-for-posts">Search for Posts</a></td>
            <td>GET</td>
            <td><code>/stream/0/posts/search</code></td>
            <td>Any</td>
        </tr>
    </tbody>
</table>
