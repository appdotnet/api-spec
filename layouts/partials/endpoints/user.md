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
            <td><a href="/reference/resources/user/lookup/#retrieve-a-user">Retrieve a User</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}</code></td>
            <td>None</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/profile/#update-a-user">Update a User</a></td>
            <td>PUT</td>
            <td><code>/stream/0/users/me</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/profile/#partially-update-a-user">Partially Update a User</a></td>
            <td>PATCH</td>
            <td><code>/stream/0/users/me</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/profile/#retrieve-a-users-avatar-image">Retrieve a User's avatar image</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}/avatar</code></td>
            <td>None</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/profile/#update-a-users-avatar-image">Update a User's avatar image</a></td>
            <td>POST</td>
            <td><code>/stream/0/users/me/avatar</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/profile/#retrieve-a-users-cover-image">Retrieve a User's cover image</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}/cover</code></td>
            <td>None</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/profile/#update-a-users-cover-image">Update a User's cover image</a></td>
            <td>POST</td>
            <td><code>/stream/0/users/me/cover</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/following/#follow-a-user">Follow a User</a></td>
            <td>POST</td>
            <td><code>/stream/0/users/{user_id}/follow</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/following/#unfollow-a-user">Unfollow a User</a></td>
            <td>DELETE</td>
            <td><code>/stream/0/users/{user_id}/follow</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/muting/#mute-a-user">Mute a User</a></td>
            <td>POST</td>
            <td><code>/stream/0/users/{user_id}/mute</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/muting/#unmute-a-user">Unmute a User</a></td>
            <td>DELETE</td>
            <td><code>/stream/0/users/{user_id}/mute</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/blocking/#block-a-user">Block a User</a></td>
            <td>POST</td>
            <td><code>/stream/0/users/{user_id}/block</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/blocking/#unblock-a-user">Unblock a User</a></td>
            <td>DELETE</td>
            <td><code>/stream/0/users/{user_id}/block</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/lookup/#retrieve-multiple-users">Retrieve multiple Users</a></td>
            <td>GET</td>
            <td><code>/stream/0/users</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/search/#search-for-users">Search for Users</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/search</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/following/#list-users-a-user-is-following">Retrieve Users a User is following</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}/following</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/following/#list-users-following-a-user">Retrieve Users following a User</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}/followers</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/following/#list-user-ids-a-user-is-following">Retrieve IDs of Users a User is following</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}/following/ids</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/following/#list-user-ids-following-a-user">Retrieve IDs of Users following a User</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}/followers/ids</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/muting/#list-muted-users">Retrieve muted Users</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}/muted</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/muting/#retrieve-muted-user-ids-for-multiple-users">Retrieve muted User IDs for multiple Users</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/muted/ids</code></td>
            <td>App</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/blocking/#list-blocked-users">Retrieve blocked Users</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/{user_id}/blocked</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/blocking/#retrieve-blocked-user-ids-for-multiple-users">Retrieve blocked User IDs for multiple Users</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/blocked/ids</code></td>
            <td>App</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/post-interactions/#list-users-who-have-reposted-a-post">Retrieve Users who reposted a Post</a></td>
            <td>GET</td>
            <td><code>/stream/0/posts/{post_id}/reposters</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/user/post-interactions/#list-users-who-have-starred-a-post">Retrieve Users who starred a Post</a></td>
            <td>GET</td>
            <td><code>/stream/0/posts/{post_id}/stars</code></td>
            <td>Any</td>
        </tr>
    </tbody>
</table>
