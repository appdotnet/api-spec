---
title: "File Content"
---

# Content

* TOC
{:toc}

## Get File content

Get the content for a complete File.

This endpoint will return a 302 Redirect to a temporary URL for the content of this file. This endpoint is useful for fetching private content from a file.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "files/[file_id]/content", "User" %>

<%= file_token_reminder %>

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

## Set File content

Set the content for an incomplete File. The content type for this request must be the content type of the file you are uploading.

This endpoint could return a `507 Insufficient Storage` error if the user doesn't have enough space for this file. For more information, see [file storage limits](/docs/resources/file/#limits).

<%= migration_warning ['response_envelope'] %>

<%= endpoint "PUT", "files/[file_id]/content", "User" %>

<%= file_token_reminder %>

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
> Content-Type: image/jpeg
>
> DATA [raw file, not base64 encoded]
>
> 204 No Content
