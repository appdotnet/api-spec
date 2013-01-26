---
title: "File Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a File

Returns a specific [File](/docs/resources/file/).

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "files/[file_id]", "Varies"%>

<%= file_token_reminder %>

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
            <td>The file id</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/files/1

<%= response(:file) %>

## Retrieve multiple Files
Returns multiple Files requested by id. At most 200 files can be requested. Files which do not exist or which the requesting user does not have authorization to view will not be returned.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "files", "User", "files"%>

<%= file_token_reminder %>

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
            <td><code>ids</code></td>
            <td>Required</td>
            <td>string</td>
            <td>A comma separated list of File ids to retrieve.</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/files?ids=1,2,6502

<%= collection_response(:file) { |h|
    second = h["data"][0].clone()
    second["id"] = "2"
    h["data"].unshift(second)
    h
} %>

## Retrieve my Files
Returns a stream of all Files the current user has created. This endpoint responds to [pagination parameters](/docs/resources/post/#general-parameters) and the [general file parameters](/docs/resources/file/#general-parameters).

<%= migration_warning ['response_envelope'] %>

<%= endpoint "GET", "users/me/files", "User", "files"%>

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/users/me/files

<%= paginated_response(:file) %>
