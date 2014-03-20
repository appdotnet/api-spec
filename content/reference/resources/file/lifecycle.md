---
title: "File Lifecycle"
---

# File Lifecycle

* TOC
{:toc}

## Create a File

Create a new [File](/reference/resources/file/).

An App.net File object can be created without setting the file content. This is called an "incomplete" file object. To create an incomplete file object, POST a JSON document that matches the [File schema](/reference/resources/file/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be `kind`, `type`, `name`, `public` and `annotations`. You can also send those keys as standard form data instead of as JSON. Once you have an incomplete file object, you can [set the file content](/reference/resources/file/content/#set-file-content) in a later request.

You can also create a complete File object with one request by including the file content with the File metadata. To create a complete file object, send a POST with an HTTP header of `Content-Type: multipart/form-data`. Our API expects one part of the request body to contain a `Content-Disposition` header with a value for `filename` and `name="content"`. The data from this part will be used as the file's content. If you wish to send your data as Base64 encoded instead of as a byte stream you must include a `Content-Transfer-Encoding: base64` header. If there is a part with `name="metadata"` and `Content-Type: application/json` then we will parse that JSON as the file's metadata. Otherwise, we will construct the metadata from the `form-data` sent in the request body. If you send extra parts with a value for `filename`, the `name`

When creating a complete file, this endpoint could return a `507 Insufficient Storage` error if the user doesn't have enough space for this file. For more information, see [file storage limits](/reference/resources/file/#limits).

<%= general_params_note_for "file" %>

<%= endpoint "POST", "files", "User" %>

<%= file_token_reminder %>

#### Example

##### JSON Metadata 2

The most comprehensive way to to specify a file's attributes are to upload json data that fits the File schema with the file itself.

<%= curl_example(:post, "files", :none, {
    :files => {
        "metadata" => "@-;type=application/json",
        "content" => "@filename.jpg",
    },
    :stdin => JSON.pretty_generate({
        "type" => "com.example.test",
        "annotations" => [
            {
                "type" => "com.example.annotation",
                "value" => {
                    "foo" => "bar"
                }
            }
        ]
    })
}) %>

##### Form-data metadata

The metadata can also be submitted as normal post data. If you want to create annotations on the file, you must use the JSON metadata format to do so.

Here is some [sample File upload code written in Python](https://gist.github.com/4659409). You can also use the following curl command to upload a file:

<%= curl_example(:post, "files", :none, {
    :files => {
        "type" => "com.example.test",
        "content" => "@filename.jpg",
    },
}) %>

##### Custom derived files

If you'd like to upload [custom derived files](/reference/resources/file/#derived-files) at the same time as the original file, you can include the derived files as extra parts:

<%= curl_example(:post, "files", :file, {
    :files => {
        "type" => "com.example.test",
        "content" => "@filename.jpg",
        "derived_key1" => "@derived_file1.png;type=image/png",
        "derived_key2" => "@derived_file2.png;type=image/png",
    }
}) %>

## Update a File

Updates a specific [File](/reference/resources/file/) object. You can update a file by PUTing an object that matches the [File schema](/reference/resources/file/) with an HTTP header of `Content-Type: application/json`. The only keys that can be updated are `annotations`, `name` and `public`. Only the File owner can update a File.

This endpoint currently works identically for the `PUT` and `PATCH` HTTP methods.

<%= general_params_note_for "file" %>

<%= endpoint "PUT", "files/[file_id]", "User"%>

<%= file_token_reminder %>

<%= url_params [
    ["file_id", "The id of the File to update."]
]%>

#### Example

<% data = {"name" => "update_filename.jpg"}%>
<%= curl_example(:put, "files/1", :file, {:data => data}) do |h|
    h["data"]["name"] = data["name"]
end %>

## Delete a File

Delete a file. The current user must be the same user who created the File. It returns the deleted File on success. *Since a File could be referenced by multiple resources we recommend that you don't automatically delete files when you delete Posts. Deleting a file should be a more explicit action taken by the user.*

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/reference/authentication/#making-authenticated-api-requests).*

<%= general_params_note_for "file" %>

<%= endpoint "DELETE", "files/[file_id]", "User" %>

<%= file_token_reminder %>

<%= url_params [
    ["file_id", "The id of the File to delete."]
]%>

#### Example

<%= curl_example(:delete, "files/1", :file) %>
