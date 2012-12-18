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
            <td><a href="/docs/resources/message/lifecycle/#retrieve-the-messages-in-a-channel">Retrieve the Messages in a Channel</a></td>
            <td>GET</td>
            <td>/stream/0/channels/[channel_id]/messages</td>
            <td>Depends on Channel permissions</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/message/lifecycle/#create-a-message">Create a Message</a></td>
            <td>POST</td>
            <td>/stream/0/channels/[channel_id]/messages</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/message/lifecycle/#retrieve-a-message">Retrieve a Message</a></td>
            <td>GET</td>
            <td>/stream/0/channels/[channel_id]/messages/[message_id]</td>
            <td>Depends on Channel permissions</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/message/lifecycle/#delete-a-message">Delete a Message</a></td>
            <td>DELETE</td>
            <td>/stream/0/channels/[channel_id]/messages/[message_id]</td>
            <td>User token</td>
        </tr>
    </tbody>
</table>