<table>
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
            <td><a href="/docs/resources/message/lifecycle/#retrieve-the-messages-in-a-channel">Retrieve the Messages in a Channel</a></td>
            <td>GET</td>
            <td>/stream/0/channels/[channel_id]/messages</td>
            <td>Varies</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/message/lifecycle/#create-a-message">Create a Message</a></td>
            <td>POST</td>
            <td>/stream/0/channels/[channel_id]/messages</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/message/lookup/#retrieve-a-message">Retrieve a Message</a></td>
            <td>GET</td>
            <td>/stream/0/channels/[channel_id]/messages/[message_id]</td>
            <td>Varies</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/message/lookup/#retrieve-multiple-messages">Retrieve multiple Messages</a></td>
            <td>GET</td>
            <td>/stream/0/channels/messages</td>
            <td>Varies</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/message/lookup/#retrieve-my-messages">Retrieve my Messages</a></td>
            <td>GET</td>
            <td>/stream/0/users/me/messages</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/message/lifecycle/#delete-a-message">Delete a Message</a></td>
            <td>DELETE</td>
            <td>/stream/0/channels/[channel_id]/messages/[message_id]</td>
            <td>User</td>
        </tr>
    </tbody>
</table>