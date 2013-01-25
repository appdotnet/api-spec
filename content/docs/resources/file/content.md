---
title: "File Content"
---

# Content

* TOC
{:toc}

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
