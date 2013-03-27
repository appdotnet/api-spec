#### Endpoint

<table style="width: auto">
    <thead>
        <tr>
            <th width="">Method</th>
            <th width="">URL</th>
            <th width="">Token</th>
            <% if scope != '' %>
                <th>Scope</th>
            <% end %>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><span class="label label-<%= method %>"><%= method %></span></td>
            <td><%= path %></td>
            <td><%= token %></td>
            <% if scope != '' %>
                <td><code><%= scope %></code></td>
            <% end %>
        </tr>
    </tbody>
</table>