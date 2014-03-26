---
title: "Stars"
---

# Stars

* TOC
{:toc}

## Star a Post

Save a given Post to the current User's stars. This is just a "save" action, not a sharing action. A User's stars are visible to others, but they are not automatically added to your followers' streams.

*Note: A repost cannot be starred. Please star the parent Post.*

<%= general_params_note_for "post" %>

<%= endpoint "POST", "posts/[post_id]/star", "User", "write_post" %>

<%= url_params [
    ["post_id", "The id of the Post to star."]
]%>

#### Example

<%= curl_example(:get, "posts/#{get_id(:post)}/star", :post) do |h|
    h["data"]["num_stars"] += 1
    h["data"]["you_starred"] = true
end %>

## Unstar a Post

Remove a Star from a Post.

<%= general_params_note_for "post" %>

<%= endpoint "DELETE", "posts/[post_id]/star", "User", "write_post" %>

<%= url_params [
    ["post_id", "The id of the Post to unstar."]
]%>

#### Example

<%= curl_example(:delete, "posts/#{get_id(:post)}/star", :post) do |h|
    h["data"]["you_starred"] = false
end %>

## Retrieve Posts starred by a User

Get the most recent [Posts](/reference/resources/post/) starred by a specific [User](/reference/resources/user/) in reverse post order. Stars are a way for Users to save posts without rebroadcasting the Post to their followers.

<%= general_params_note_for "post" %>

<%= pagination_note %>

<%= endpoint "GET", "users/[user_id]/stars", "None" %>

<%= url_params [
    ["user_id", "The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

*See [General Parameters](/reference/resources/post/#general-parameters) for optional parameters you can use with this query.*

#### Example

<%= curl_example(:get, "users/#{get_id(:user)}/stars", :post, {:response => :paginated}) do |h|
    h["data"][0]["num_stars"] += 1
    h["data"][0]["you_starred"] = true
end %>