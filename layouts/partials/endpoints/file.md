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
            <td><a href="/docs/resources/file/lifecycle/#create-a-file">Create a File</a></td>
            <td>POST</td>
            <td>/stream/0/files</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/file/#how-to-upload-custom-derived-files">Create a Derived File</a></td>
            <td>POST</td>
            <td>/stream/0/files/[file_id]/[derived_key]</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/file/lookup/#retrieve-a-file">Retrieve a File</a></td>
            <td>GET</td>
            <td>/stream/0/files/[file_id]</td>
            <td>Varies</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/file/lookup/#retrieve-multiple-files">Retrieve multiple Files</a></td>
            <td>GET</td>
            <td>/stream/0/files</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/file/lifecycle/#delete-a-file">Delete a File</a></td>
            <td>DELETE</td>
            <td>/stream/0/files/[file_id]</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/file/lookup/#retrieve-my-files">Retrieve my Files</a></td>
            <td>GET</td>
            <td>/stream/0/users/me/files</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/file/lifecycle/#update-a-file">Update a File</a></td>
            <td>PUT</td>
            <td>/stream/0/files/[file_id]</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/file/content/#get-file-content">Get File content</a></td>
            <td>GET</td>
            <td>/stream/0/files/[file_id]/content</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/file/content/#set-file-content">Set File content</a></td>
            <td>PUT</td>
            <td>/stream/0/files/[file_id]/content</td>
            <td>User</td>
        </tr>
        <tr>
            <td><a href="/docs/resources/file/content/#set-derived-file-content">Set Derived File content</a></td>
            <td>PUT</td>
            <td>/stream/0/files/[file_id]/content/[derived_key]</td>
            <td>User</td>
        </tr>
    </tbody>
</table>
