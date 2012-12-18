<table>
    <thead>
        <tr>
            <th>Description</th>
            <th width="80">HTTP Method</th>
            <th width="280">Path</th>
            <th width="80">Auth?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/docs/resources/stream/lifecycle/#create-a-stream">Create a Stream</a></td>
            <td>POST</td>
            <td>/stream/0/streams</td>
            <td>App token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/stream/lifecycle/#retrieve-a-stream">Retrieve a Stream</a></td>
            <td>GET</td>
            <td>/stream/0/streams/[stream_id]</td>
            <td>App token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/stream/lifecycle/#delete-a-stream">Delete a Stream</a></td>
            <td>DELETE</td>
            <td>/stream/0/streams/[stream_id]</td>
            <td>App token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/stream/lifecycle/#get-current-tokens-streams">Retrieve all Streams for the current Token</a></td>
            <td>GET</td>
            <td>/stream/0/streams</td>
            <td>App token</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/stream/lifecycle/#delete-all-of-the-current-users-streams">Delete all Streams for the current Token</a></td>
            <td>DELETE</td>
            <td>/stream/0/streams</td>
            <td>App token</td>
        </tr>
    </tbody>
</table>