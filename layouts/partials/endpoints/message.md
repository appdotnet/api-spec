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
            <td><a href="/reference/resources/message/lifecycle/#retrieve-the-messages-in-a-channel">Retrieve the Messages in a Channel</a></td>
            <td>GET</td>
            <td><code>/stream/0/channels/{channel_id}/messages</code></td>
            <td>Varies</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/message/lifecycle/#create-a-message">Create a Message</a></td>
            <td>POST</td>
            <td><code>/stream/0/channels/{channel_id}/messages</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/message/lookup/#retrieve-a-message">Retrieve a Message</a></td>
            <td>GET</td>
            <td><code>/stream/0/channels/{channel_id}/messages/{message_id}</code></td>
            <td>Varies</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/message/lookup/#retrieve-multiple-messages">Retrieve multiple Messages</a></td>
            <td>GET</td>
            <td><code>/stream/0/channels/messages</code></td>
            <td>Any</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/message/lookup/#retrieve-my-messages">Retrieve my Messages</a></td>
            <td>GET</td>
            <td><code>/stream/0/users/me/messages</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/message/lifecycle/#delete-a-message">Delete a Message</a></td>
            <td>DELETE</td>
            <td><code>/stream/0/channels/{channel_id}/messages/{message_id}</code></td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/reference/resources/message/search/#search-for-messages">Search for Messages</a></td>
            <td>GET</td>
            <td><code>/stream/0/channels/messages/search</code></td>
            <td>Any</td>
        </tr>
    </tbody>
</table>
