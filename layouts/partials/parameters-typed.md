#### <%= header %>

<table style="width: auto">
    <thead>
        <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <% params.each do |param| %>
        <tr>
            <td><code><%= param[0] %></code></td>
            <td><%= param[1] %></td>
            <td><%= param[2] %></td>
        </tr>
        <% end %>
    </tbody>
</table>