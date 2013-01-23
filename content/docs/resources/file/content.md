---
title: "File Content"
---

# Content

* TOC
{:toc}

## Retrieve File content

Return an HTTP redirect to a File's content. In general, this endpoint should not be used directly unless you're building some kind of file management app. Files should usually be accessed through the [App.net resource they're attached to](/docs/resources/file/#attaching-files-to other-resources).

*If the file is not complete, a status code of `204 No Content` will be returned.*

<%= endpoint "GET", "files/[file_id]/content", "User" %>

### Parameters

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
            <td>The file id.</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/files/1/content
>
> 302 Location: https://example.com/file_1.jpg

## Set File content

Set the content for an incomplete File. The content type for this request must be ```multipart/form-data```.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "PUT", "files/[file_id]/content", "User" %>

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
            <td>The file id.</td>
        </tr>
    </tbody>
</table>

### Example

> PUT https://alpha-api.app.net/stream/0/files/1/content
>
> Content-Type: multipart/form-data; boundary=----------------------------82481319dca6
>
> DATA [MIME encoded image]
>
> 204 No Content
