---
title: "File Lifecycle"
---

# File Lifecycle

* TOC
{:toc}

## Create a File

Create a new [File](/docs/resources/file/).

An App.net File object can be created without setting the file content. This is called an "incomplete" file object. To create an incomplete file object, POST a JSON document that matches the [File schema](/docs/resources/file/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be `kind`, `type`, `name`, and `annotations`. You can also send those keys as standard form data instead of as JSON. Once you have an incomplete file object, you can [set the file content](/docs/resources/file/content/#set-file-content) in a later request.

You can also create a complete File object with one request by including the file content with the File metadata. To create a complete file object, send a POST with an HTTP header of `Content-Type: multipart/form-data`. Our API expects one part of the request body to contain a `Content-Disposition` header with a value for `filename` and `name="content"`. The data from this part will be used as the file's content. If there is a part with `name="metadata"` and `Content-Type: application/json` then we will parse that JSON as the file's metadata. Otherwise, we will construct the metadata from the `form-data` sent in the request body.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "POST", "files", "User" %>

### Data

None.

### Example

> POST https://alpha-api.app.net/stream/0/files
>
> Content-Type: multipart/form-data; boundary=82481319dca6
>
> DATA
> 
> --82481319dca6
> Content-Disposition: file; name="content"; filename="filename.png"
> Content-Type: image/png
> 
> ...contents of file...
> --82481319dca6
> Content-Disposition: file; name="metadata"; filename="metadata.json"
> Content-Type: application/json
> 
> {"type": "com.example.test"}

<%= response(:file) %>

## Update a File

Updates a specific [File](/docs/resources/file/) object. You can update a file by PUTing an object that matches the [File schema](/docs/resources/file/) with an HTTP header of ```Content-Type: application/json```. The only keys that can be updated are ```annotations``` and ```name```. Only the File owner can update a file.

If you want to add or update a File's annotations, you may include the optional ```annotations``` key and pass in the annotations that are changing.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "PUT", "files/[file_id]", "User"%>

### Data

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>file_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The id of the File to update</td>
        </tr>
    </tbody>
</table>

### Example

> PUT https://alpha-api.app.net/stream/0/files/1
>
> Content-Type: application/json
> 
> DATA {"name": "updated_filename.jpg"}

<%= response(:file) {|h| h["data"]["name"] = "updated_filename.jpg"; h} %>

## Delete a File

Delete a file. The current user must be the same user who created the File. It returns the deleted File on success. *Since a File could be referenced by multiple resources we recommend that you don't automatically delete files when you delete Posts. Deleting a file should be a more explicit action taken by the user.*

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/docs/authentication/#making-authenticated-api-requests).*

<%= migration_warning ['response_envelope'] %>

<%= endpoint "DELETE", "files/[file_id]", "User" %>

### Data

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>file_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The id of the File you'd like to delete</td>
        </tr>
    </tbody>
</table>

### Example

> DELETE https://alpha-api.app.net/stream/0/files/1

<%= response(:file) %>
