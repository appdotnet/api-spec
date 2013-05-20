---
title: "File Lifecycle"
---

# File Lifecycle

* TOC
{:toc}

## Create a File

Create a new [File](/docs/resources/file/).

An App.net File object can be created without setting the file content. This is called an "incomplete" file object. To create an incomplete file object, POST a JSON document that matches the [File schema](/docs/resources/file/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be `kind`, `type`, `name`, `public` and `annotations`. You can also send those keys as standard form data instead of as JSON. Once you have an incomplete file object, you can [set the file content](/docs/resources/file/content/#set-file-content) in a later request.

You can also create a complete File object with one request by including the file content with the File metadata. To create a complete file object, send a POST with an HTTP header of `Content-Type: multipart/form-data`. Our API expects one part of the request body to contain a `Content-Disposition` header with a value for `filename` and `name="content"`. The data from this part will be used as the file's content. If you wish to send your data as Base64 encoded instead of as a byte stream you must include a `Content-Transfer-Encoding: base64` header. If there is a part with `name="metadata"` and `Content-Type: application/json` then we will parse that JSON as the file's metadata. Otherwise, we will construct the metadata from the `form-data` sent in the request body. If you send extra parts with a value for `filename`, the `name`

When creating a complete file, this endpoint could return a `507 Insufficient Storage` error if the user doesn't have enough space for this file. For more information, see [file storage limits](/docs/resources/file/#limits).

<%= general_params_note_for "file" %>

<%= endpoint "POST", "files", "User" %>

<%= file_token_reminder %>

#### Example

##### JSON Metadata

~~~
POST https://alpha-api.app.net/stream/0/files

Content-Type: multipart/form-data; boundary=82481319dca6

REQUEST BODY:
--82481319dca6
Content-Disposition: form-data; name="content"; filename="filename.png"
Content-Type: image/png

...contents of file...
--82481319dca6
Content-Disposition: form-data; name="metadata"; filename="metadata.json"
Content-Type: application/json

{"type": "com.example.test"}
~~~

##### Form-data metadata

The metadata can also be submitted as normal post data in which case that part of the request body will look like:

~~~
--82481319dca6
Content-Disposition: form-data; name="type"

com.example.test
~~~

Here is some [sample File upload code written in Python](https://gist.github.com/4659409). You can also use the following curl command to upload a file:

    curl -k -H 'Authorization: BEARER ...' https://alpha-api.app.net/stream/0/files -F 'type=com.example.test' -F content=@filename.png -X POST

##### Custom derived files

If you'd like to upload [custom derived files](/docs/resources/file/#derived-files) at the same time as the original file, you can include the derived files as extra parts:

    curl -k -H ‘Authorization: BEARER …’ https://alpha-api.app.net/stream/0/files -X POST -F ‘type=com.example.test’ -F “content=@filename.jpg” -F “derived_key1=@derived_file1.png;type=image/png” -F “derived_key2=@derived_file2.png;type=image/png”

<%= response(:file) %>

## Update a File

Updates a specific [File](/docs/resources/file/) object. You can update a file by PUTing an object that matches the [File schema](/docs/resources/file/) with an HTTP header of `Content-Type: application/json`. The only keys that can be updated are `annotations`, `name` and `public`. Only the File owner can update a File.

<%= general_params_note_for "file" %>

<%= endpoint "PUT", "files/[file_id]", "User"%>

<%= file_token_reminder %>

<%= url_params [
    ["file_id", "The id of the File to update."]
]%>

#### Example

> PUT https://alpha-api.app.net/stream/0/files/1
>
> Content-Type: application/json
> 
> DATA {"name": "updated_filename.jpg"}

<%= response(:file) {|h| h["data"]["name"] = "updated_filename.jpg"; h} %>

## Delete a File

Delete a file. The current user must be the same user who created the File. It returns the deleted File on success. *Since a File could be referenced by multiple resources we recommend that you don't automatically delete files when you delete Posts. Deleting a file should be a more explicit action taken by the user.*

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/docs/authentication/#making-authenticated-api-requests).*

<%= general_params_note_for "file" %>

<%= endpoint "DELETE", "files/[file_id]", "User" %>

<%= file_token_reminder %>

<%= url_params [
    ["file_id", "The id of the File to delete."]
]%>

#### Example

> DELETE https://alpha-api.app.net/stream/0/files/1

<%= response(:file) %>
