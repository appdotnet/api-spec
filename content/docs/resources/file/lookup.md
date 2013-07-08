---
title: "File Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a File

Returns a specific [File](/docs/resources/file/).

<%= general_params_note_for "file" %>

<%= endpoint "GET", "files/[file_id]", "Varies"%>

<%= file_token_reminder %>

<%= url_params [
    ["file_id", "The id of the File to retrieve."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/files/1

<%= response(:file) %>

## Retrieve multiple Files

Returns multiple Files requested by id. At most 200 files can be requested. Files which do not exist or which the requesting user does not have authorization to view will not be returned.

<%= general_params_note_for "file" %>

<%= endpoint "GET", "files", "User", "files"%>

<%= file_token_reminder %>

<%= query_params [
    ["ids", "A comma separated list of File ids to retrieve."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/files?ids=1,2,6502

<%= collection_response(:file) { |h|
    second = h["data"][0].clone()
    second["id"] = "2"
    h["data"].unshift(second)
} %>

## Retrieve my Files

Returns a stream of all Files the current user has created.

<%= general_params_note_for "file" %>

<%= pagination_note %>

<%= endpoint "GET", "users/me/files", "User", "files"%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/me/files

<%= paginated_response(:file) %>
