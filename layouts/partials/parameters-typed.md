#### <%= header %>

<table class="table table-striped">
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th width="50">Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <% params.each do |param| %>
        <tr>
            <td><code><%= param[0] %></code></td>
            <td><%= param[1].to_s.capitalize %></td>
            <td><%= param[2] %></td>
            <td><%= param[3] %></td>
        </tr>
        <% end %>
    </tbody>
</table>
