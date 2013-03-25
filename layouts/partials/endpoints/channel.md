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
            <td><a href="/docs/resources/channel/subscriptions/#get-current-users-subscribed-channels">Get current user's subscribed channels</a></td>
            <td>GET</td>
            <td>/stream/0/channels</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/lifecycle/#create-a-channel">Create a Channel</a></td>
            <td>POST</td>
            <td>/stream/0/channels</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/lookup/#retrieve-a-channel">Retrieve a Channel</a></td>
            <td>GET</td>
            <td>/stream/0/channels/[channel_id]</td>
            <td>Varies</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/lookup/#retrieve-multiple-channels">Retrieve multiple Channels</a></td>
            <td>GET</td>
            <td>/stream/0/channels</td>
            <td>Varies</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/lookup/#retrieve-my-channels">Retrieve my Channels</a></td>
            <td>GET</td>
            <td>/stream/0/users/me/channels</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/lookup/#retrieve-number-of-unread-pm-channels">Retrieve number of unread PM Channels</a></td>
            <td>GET</td>
            <td>/stream/0/users/me/channels/pm/num_unread</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/lifecycle/#update-a-channel">Update a Channel</a></td>
            <td>PUT</td>
            <td>/stream/0/channels/[channel_id]</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/subscriptions/#subscribe-to-a-channel">Subscribe to a Channel</a></td>
            <td>POST</td>
            <td>/stream/0/channels/[channel_id]/subscribe</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/subscriptions/#unsubscribe-from-a-channel">Unsubscribe from a Channel</a></td>
            <td>DELETE</td>
            <td>/stream/0/channels/[channel_id]/subscribe</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/subscriptions/#retrieve-users-subscribed-to-a-channel">Retrieve users subscribed to a Channel</a></td>
            <td>GET</td>
            <td>/stream/0/channels/[channel_id]/subscribers</td>
            <td>Varies</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/subscriptions/#retrieve-user-ids-subscribed-to-a-channel">Retrieve user ids subscribed to a Channel</a></td>
            <td>GET</td>
            <td>/stream/0/channels/[channel_id]/subscribers/ids</td>
            <td>Varies</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/subscriptions/#retrieve-user-ids-subscribed-to-a-channel">Retrieve user ids subscribed to multiple Channels</a></td>
            <td>GET</td>
            <td>/stream/0/channels/subscribers/ids</td>
            <td>Varies</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/muting/#mute-a-channel">Mute a Channel</a></td>
            <td>POST</td>
            <td>/stream/0/channels/[channel_id]/mute</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/muting/#unmute-a-channel">Unmute a Channel</a></td>
            <td>DELETE</td>
            <td>/stream/0/channels/[channel_id]/mute</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/channel/muting/#get-current-users-muted-channels">Get current user's muted Channels</a></td>
            <td>GET</td>
            <td>/stream/0/users/me/channels/muted</td>
            <td>User</td>
        </tr>
    </tbody>
</table>
