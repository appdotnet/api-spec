---
title: "Post Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a Post

Returns a specific [Post](/reference/resources/post/).

<%= general_params_note_for "post" %>

<%= endpoint "GET", "posts/[post_id]", "None" %>

<%= url_params [
    ["post_id","The id of the Post to retrieve."]
]%>

#### Example

<%= curl_example(:get, "posts/1", :post) %>

## Retrieve multiple Posts

Returns multiple Posts requested by id. At most 200 posts can be requested.

<%= general_params_note_for "post" %>

<%= endpoint "GET", "posts", "Any" %>

<%= query_params [
    ["ids","A comma separated list of ids of Posts to retrieve."]
]%>

#### Example

<%= curl_example(:get, "posts?ids=1,2", :post, {:response => :collection}) do |h|
    second = h["data"][0].clone()
    second["id"] = "2"
    h["data"].unshift(second)
end %>
