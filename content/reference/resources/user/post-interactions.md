---
title: "User Post Interactions"
---

# Post Interactions

* TOC
{:toc}

## List Users who have reposted a Post

List all the Users who have reposted a given Post.

<%= general_params_note_for "user" %>

<%= endpoint "GET", "posts/[post_id]/reposters", "Any" %>

<%= url_params [
  ["post_id","The id of the target Post."]
]%>

#### Example

<%= curl_example(:get, "posts/1/reposters", :user, {:response => :paginated}) do |h|
    h["data"][0]["pagination_id"] = "345"
    h["meta"]["more"] = true
end %>

## List Users who have starred a Post

List all the Users who have starred a given Post.

<%= general_params_note_for "user" %>

<%= endpoint "GET", "posts/[post_id]/stars", "Any" %>

<%= url_params [
  ["post_id","The id of the target post."]
]%>

#### Example

<%= curl_example(:get, "posts/1/stars", :user, {:response => :paginated}) do |h|
    h["data"][0]["pagination_id"] = "1356"
    h["meta"]["more"] = true
end %>
