---
title: "User Profile"
---

# Profile

* TOC
{:toc}

## Update a User

Updates a specific user's profile details. You can update a user by PUTing an object that matches the [User schema](/reference/resources/user/) with an HTTP header of `Content-Type: application/json`. You must provide values for each of the following keys: `name`, `locale`, `timezone`, and `description`. If you would only like to update a subset of those keys, you can also [partially update a user](#partially-update-a-user).

For the description, you must specify `description.text` as a child key. You can also specify [custom links](/reference/meta/entities/#user-specified-entities) for a user description. If you want to test how your text will be processed you can use the [text processor](/reference/resources/text-processor).

If you want to add or update a User's annotations, you may include the optional `annotations` key and pass in the annotations that are changing.

<%= general_params_note_for "user" %>

<%= endpoint "PUT", "users/me", "User", "update_profile" %>

### Example

<% data = {
    "name" => "Mark Thurman 2",
    "locale" => "en",
    "timezone" => "US/Central",
    "description" => {
        "text" => "new description"
    },
    "annotations" => [{
        "type" => "net.app.core.directory.blog",
        "value" => {
            "url" => "http://mynewblog.com"
        }
    }]
} %>
<%= curl_example(:put, "users/me?include_user_annotations=1", :user_self, {:data => data}) do |h|
    h["data"]["name"] = data["name"]
    h["data"]["locale"] = "en_US"
    h["data"]["description"]["text"] = data["description"]["text"]
    h["data"]["description"]["html"] = data["description"]["text"]
    h["data"]["description"]["entities"] = {}
    h["data"]["timezone"] = data["timezone"]
    h["data"]["annotations"] = data["annotations"]
end %>

## Partially Update a User

Updates a subset of a specific user's profile details. You can update a user by passing the keys you'd like to update from the [User schema](/reference/resources/user/) with an HTTP header of `Content-Type: application/json`. You can also specify [custom links](/reference/meta/entities/#user-specified-entities) for a user description. If you want to test how your text will be processed you can use the [text processor](/reference/resources/text-processor).

<%= general_params_note_for "user" %>

<%= endpoint "PATCH", "users/me", "User", "update_profile" %>

### Example

<% data = {
    "name" => "Mark Thurman 3",
} %>

<%= curl_example(:patch, "users/me", :user_self, {:data => data}) do |h|
    h["data"]["name"] = data["name"]
end %>

## Retrieve a User's avatar image

Retrieve a User's avatar image. This endpoint does not require authentication, is not rate limited, and will return an HTTP 302 redirect to the user's current avatar image. It will include any [query string parameters](/reference/resources/user/#images) you pass to the endpoint.

<%= endpoint "GET", "users/[user_id]/avatar", "None" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

### Example

<%= curl_example(:get, "users/me/avatar", "<the binary contents of your avatar image>", {:response => :raw, :follow_redirects => true}) %>

## Update a User's avatar image

Replace a User's avatar image with the uploaded file. The uploaded image Will be cropped to square and must be smaller than 1 MB. The optimal size for this image is 200×200 pixels. The content type for this request must be `multipart/form-data`.


<%= endpoint "POST", "users/me/avatar", "User", "update_profile" %>

### Data

<table class='table table-striped'>
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
            <td><code>avatar</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The MIME encoded image to replace the current user's image.</td>
        </tr>
    </tbody>
</table>

### Example

<%= curl_example(:post, "users/me/avatar", :user_self, {:files => {"avatar" => "@new_avatar_image.jpg"}}) do |h|
    h["data"]["avatar_image"]["url"] = "https://example.com/new_avatar_image.jpg"
end %>

## Retrieve a User's cover image

Retrieve a User's cover image. This endpoint does not require authentication, is not rate limited, and will return an HTTP 302 redirect to the user's current cover image. It will include any [query string parameters](/reference/resources/user/#images) you pass to the endpoint.

<%= endpoint "GET", "users/[user_id]/cover", "None" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

### Example

<%= curl_example(:get, "users/me/cover", "<the binary contents of your cover image>", {:response => :raw, :follow_redirects => true}) %>

## Update a User's cover image

Replace a User's cover image with the uploaded file. The uploaded image must be at least 960px wide and less than 4 MB in size. The content type for this request must be `multipart/form-data`.

<%= general_params_note_for "user" %>

<%= endpoint "POST", "users/me/cover", "User", "update_profile" %>

### Data

<table class='table table-striped'>
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
            <td><code>cover</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The MIME encoded image to replace the current user's image.</td>
        </tr>
    </tbody>
</table>

### Example

<%= curl_example(:post, "users/me/cover", :user_self, {:files => {"cover" => "@new_cover_image.jpg"}}) do |h|
    h["data"]["cover_image"]["url"] = "https://example.com/new_cover_image.jpg"
end %>
