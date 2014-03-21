---
title: "File Content"
---

# Content

* TOC
{:toc}

## Get File content

Get the content for a complete File.

This endpoint will return a 302 Redirect to a temporary URL for the content of this file. This endpoint is useful for fetching private content from a file.

<%= endpoint "GET", "files/[file_id]/content", "User" %>

<%= file_token_reminder %>

<%= url_params [
    ["file_id", "The id of the File to retrieve content for."]
]%>

## Set File content

Set the content for an incomplete File. The content type for this request must be the content type of the file you are uploading. This endpoint can optionally accept a header field `x-adn-filename` to set the File's name.

This endpoint could return a `507 Insufficient Storage` error if the user doesn't have enough space for this file. For more information, see [file storage limits](/reference/resources/file/#limits).

When successful, this endpoint will return a `204 No Content` response.

<%= endpoint "PUT", "files/[file_id]/content", "User" %>

<%= file_token_reminder %>

<%= url_params [
    ["file_id", "The id of the File to set content for."]
]%>

#### Example

<%= curl_example(:put, "files/1/content", "204 No Content", {
    :content_type => "image/png",
    :data_binary => "@filename.png",
    :response => :raw
}) %>

## Get Derived File content

Get the content for a derived file of a complete File.

This endpoint will return a 302 Redirect to a temporary URL for the content of this derived file.

<%= endpoint "GET", "files/[file_id]/content/[derived_file_key]", "User" %>

<%= file_token_reminder %>

<%= url_params [
    ["file_id", "The id of the File to retrieve content for."],
    ["derived_file_key", "The key identifying the derived file you want the content for."]
]%>

## Set Derived File content

Set the content for a derived file of an incomplete File. The content type for this request must be the content type of the file you are uploading. This endpoint can optionally accept a header field `x-adn-filename` to set the Derived File's name.

This endpoint could return a `507 Insufficient Storage` error if the user doesn't have enough space for this derived file. For more information, see [file storage limits](/reference/resources/file/#limits).

<%= endpoint "PUT", "files/[file_id]/content/[derived_file_key]", "User" %>

<%= file_token_reminder %>

<%= url_params [
    ["file_id", "The id of the File to set content for."],
    ["derived_file_key", "The key identifying the derived file you want to create."]
]%>

#### Example

<%= curl_example(:put, "files/1/content/thumbnail_png", "204 No Content", {
    :content_type => "image/png",
    :data_binary => "@filename.png",
    :response => :raw
}) %>
