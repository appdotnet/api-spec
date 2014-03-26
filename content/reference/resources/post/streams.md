---
title: "Post Streams"
---

# Post Streams

* TOC
{:toc}

## Retrieve the Global stream

Return the 20 most recent [Posts](/reference/resources/post/) from the Global stream.

<%= general_params_note_for "post" %>

<%= pagination_note %>

<%= endpoint "GET", "posts/stream/global", "None" %>

#### Example

<%= curl_example(:get, "posts/stream/global", :post, {:response => :paginated}) %>

## Retrieve Posts created by a User

Get the most recent [Posts](/reference/resources/post/) created by a specific [User](/reference/resources/user/) in reverse post order.

<%= general_params_note_for "post" %>

<%= pagination_note %>

<%= endpoint "GET", "users/[user_id]/posts", "None" %>

<%= url_params [
    ["user_id", "The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

<%= curl_example(:get, "users/1/posts", :post, {:response => :paginated}) %>

## Retrieve Posts mentioning a User

Get the most recent [Posts](/reference/resources/post/) mentioning by a specific [User](/reference/resources/user/) in reverse post order.

<%= general_params_note_for "post" %>

<%= pagination_note %>

<%= endpoint "GET", "users/[user_id]/mentions", "Any" %>

<%= url_params [
    ["user_id", "The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

<%= curl_example(:get, "users/2/mentions", :post, {:response => :paginated}) %>

## Retrieve a User's personalized stream

Return the 20 most recent [Posts](/reference/resources/post/) from the current User and the Users they follow.

<%= general_params_note_for "post" %>

<%= stream_facet_note %>

<%= pagination_note %>

<%= endpoint "GET", "posts/stream", "User", "stream" %>

#### Example

<%= curl_example(:get, "posts/stream", :post, {:response => :paginated}) %>

## Retrieve a User's unified stream

Return the 20 most recent [Posts](/reference/resources/post/) from the current user's [personalized stream](#retrieve-a-users-personalized-stream) and [mentions stream](#retrieve-posts-mentioning-a-user) merged into one stream.

<%= general_params_note_for "post" %>

<%= pagination_note %>

<%= stream_facet_note %>

<%= endpoint "GET", "posts/stream/unified", "User", "stream" %>

#### Example

<%= curl_example(:get, "posts/stream/unified", :post, {:response => :paginated}) %>

## Retrieve tagged Posts

Return the 20 most recent [Posts](/reference/resources/post/) for a specific hashtag.

<%= general_params_note_for "post" %>

<%= pagination_note %>

<%= endpoint "GET", "posts/tag/[hashtag]", "None" %>

#### Example

<%= curl_example(:get, "posts/tag/joinus", :post, {:response => :paginated}) %>
