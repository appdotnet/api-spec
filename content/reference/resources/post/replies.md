---
title: "Post Replies"
---

# Replies

* TOC
{:toc}

## Retrieve the replies to a Post

Retrieve all the [Posts](/reference/resources/post/) that are in the same thread as this post. The specified Post does not have to be the root of the conversation. Additionally, the specified Post will be included in the response at the appropriate place.

**This endpoint would be more accurately named `stream/0/posts/{post_id}/thread` and may be renamed in a later API version.**

<%= general_params_note_for "post" %>

<%= pagination_note %>

<%= endpoint "GET", "posts/[post_id]/replies", "Any" %>

<%= url_params [
    ["post_id","The id of a Post in the thread to retrieve."]
]%>

#### Example

<%= curl_example(:get, "posts/1/replies", :post_reply, {:response => :paginated}) %>
