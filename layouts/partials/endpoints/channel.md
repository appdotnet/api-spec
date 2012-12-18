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
            <td><a href="/docs/resources/channel/subscriptions/#get-current-users-subscribed-channels">Get current user's subscribed channels</a></td>
            <td>GET</td>
            <td>/stream/0/channels</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/lifecycle/#create-a-channel">Create a Channel</a></td>
            <td>POST</td>
            <td>/stream/0/channels</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/lifecycle/#retrieve-a-channel">Retrieve a Channel</a></td>
            <td>GET</td>
            <td>/stream/0/channels/[channel_id]</td>
            <td>Depends on Channel permissions</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/lifecycle/#update-a-channel">Update a Channel</a></td>
            <td>PUT</td>
            <td>/stream/0/channels/[channel_id]</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/subscriptions/#subscribe-to-a-channel">Subscribe to a Channel</a></td>
            <td>POST</td>
            <td>/stream/0/channels/[channel_id]/subscribe</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/subscriptions/#unsubscribe-from-a-channel">Unsubscribe from a Channel</a></td>
            <td>DELETE</td>
            <td>/stream/0/channels/[channel_id]/subscribe</td>
            <td>User token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/subscriptions/#retrieve-users-subscribed-to-a-channel">Retrieve users subscribed to a Channel</a></td>
            <td>GET</td>
            <td>/stream/0/channels/[channel_id]/subscribers</td>
            <td>Depends on Channel permissions</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/subscriptions/#retrieve-user-ids-subscribed-to-a-channel">Retrieve user ids subscribed to a Channel</a></td>
            <td>GET</td>
            <td>/stream/0/channels/[channel_id]/subscribers/ids</td>
            <td>Depends on Channel permissions</td>
        </tr>
    </tbody>
</table>