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

> GET https://alpha-api.app.net/stream/0/posts/1/reposters

<%= paginated_response(:user) do |h|
    h["meta"]["min_id"] = "345"
    h["meta"]["max_id"] = "345"
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

> GET https://alpha-api.app.net/stream/0/posts/1/stars

<%= paginated_response(:user) do |h|
    h["meta"]["min_id"] = "1356"
    h["meta"]["max_id"] = "1356"
    h["meta"]["more"] = true
end %>
