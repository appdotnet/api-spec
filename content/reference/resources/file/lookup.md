---
title: "File Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a File

Returns a specific [File](/reference/resources/file/).

<%= general_params_note_for "file" %>

<%= endpoint "GET", "files/[file_id]", "Varies"%>

<%= file_token_reminder %>

<%= url_params [
    ["file_id", "The id of the File to retrieve."]
]%>

#### Example

<%= curl_example(:get, "files/1", :file) %>

## Retrieve multiple Files

Returns multiple Files requested by id. At most 200 files can be requested. Files which do not exist or which the requesting user does not have authorization to view will not be returned.

<%= general_params_note_for "file" %>

<%= endpoint "GET", "files", "User", "files"%>

<%= file_token_reminder %>

<%= query_params [
    ["ids", "A comma separated list of File ids to retrieve."]
]%>

#### Example

In the following example, file 6502 is omitted because it doesn't exist or we don't have permission to view it.

<%= curl_example(:get, "files?ids=1,2,6502", :file, {:response => :collection}) do |h|
    second = h["data"][0].clone()
    second["id"] = "2"
    h["data"].unshift(second)
end %>

## Retrieve my Files

Returns a stream of all Files the current user has created.

<%= general_params_note_for "file" %>

<%= pagination_note %>

<%= endpoint "GET", "users/me/files", "User", "files"%>

#### Example

<%= curl_example(:get, "users/me/files", :file, {:response => :paginated}) %>
