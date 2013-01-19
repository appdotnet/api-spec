### Endpoint

<table style="width: auto">
    <thead>
        <tr>
            <th width="70">Method</th>
            <th width="250">Path</th>
            <th width="70">Token</th>
            <% if scope != '' %>
                <th>Scope</th>
            <% end %>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><%= method %></td>
            <td><%= path %></td>
            <td><%= token %></td>
            <% if scope != '' %>
                <td><code><%= scope %></code></td>
            <% end %>
        </tr>
    </tbody>
</table>