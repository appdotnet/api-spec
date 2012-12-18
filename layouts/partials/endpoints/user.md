<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">Method</th>
            <th width="280">Path</th>
            <th width="80">Authorization</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/user/lookup/#retrieve-a-user">Retrieve a User</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]</td>
            <td>None</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/profile/#update-a-user">Update a User</a></td>
            <td>PUT</td>
            <td>/stream/0/users/me</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/profile/#retrieve-a-users-avatar-image">Retrieve a User's avatar image</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/avatar</td>
            <td>None</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/profile/#update-a-users-avatar-image">Update a User's avatar image</a></td>
            <td>POST</td>
            <td>/stream/0/users/me/avatar</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/profile/#retrieve-a-users-cover-image">Retrieve a User's cover image</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/cover</td>
            <td>None</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/profile/#update-a-users-cover-image">Update a User's cover image</a></td>
            <td>POST</td>
            <td>/stream/0/users/me/cover</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#follow-a-user">Follow a User</a></td>
            <td>POST</td>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#unfollow-a-user">Unfollow a User</a></td>
            <td>DELETE</td>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/muting/#mute-a-user">Mute a User</a></td>
            <td>POST</td>
            <td>/stream/0/users/[user_id]/mute</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/muting/#unmute-a-user">Unmute a User</a></td>
            <td>DELETE</td>
            <td>/stream/0/users/[user_id]/mute</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/lookup/#retrieve-multiple-users">Retrieve multiple Users</a></td>
            <td>GET</td>
            <td>/stream/0/users</td>
            <td>Any token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/lookup/#search-for-users">Search for Users</a></td>
            <td>GET</td>
            <td>/stream/0/users/search</td>
            <td>Any token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#list-users-a-user-is-following">Retrieve Users a User is following</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/following</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#list-users-following-a-user">Retrieve Users following a User</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/followers</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#list-user-ids-a-user-is-following">Retrieve IDs of Users a User is following</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/following/ids</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/following/#list-user-ids-following-a-user">Retrieve IDs of Users following a User</a></td>
            <td>GET</td>
            <td>/stream/0/users/[user_id]/followers/ids</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/muting/#list-muted-users">Retrieve Users muted by the current User</a></td>
            <td>GET</td>
            <td>/stream/0/users/me/muted</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/post-interactions/#list-users-who-have-reposted-a-post">Retrieve Users who reposted a Post</a></td>
            <td>GET</td>
            <td>/stream/0/posts/[post_id]/reposters</td>
            <td>Any token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/user/post-interactions/#list-users-who-have-starred-a-post">Retrieve Users who starred a Post</a></td>
            <td>GET</td>
            <td>/stream/0/posts/[post_id]/stars</td>
            <td>Any token</td>
        </tr>
    </tbody>
</table>