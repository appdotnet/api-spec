---
title: "Reposts"
---

# Reposts

* TOC
{:toc}

## Repost a Post

Share a Post (specified with post_id) with your followers. Reposts are intended solely as a routing mechanism; a repost's text, entities, and html are "inherited" from the original Post. If a user would like to quote, comment on, or alter a Post, reposts are not the solution. Reposts are meant to be pointers to another Post.

For compatibility with clients who don't wish to show reposts specially, we set a repost's text field to be `>> @username: original text`. **Thus the text field could actually be slightly longer than 256 characters.** Most clients will probably want to display the original post (with some indication that is has been reposted). When rendering a repost, we recommend you pull most of your information from `repost_of` and make use of the `repost_of.reposters` field.

- Reposts cannot be reposted, starred, or replied to. Please take those actions on the parent post.
- Reposts do not show up in the hashtags, mentions or global streams.
- A repost of Post A will only show up in a User's stream if they have not seen Post A (or another repost of Post A) in a reasonable amount of time (currently 1 week).

<%= general_params_note_for "post" %>

<%= endpoint "POST", "posts/[post_id]/repost", "User", "write_post" %>

<%= url_params [
    ["post_id", "The id of the Post to repost."]
]%>

#### Example

<%= curl_example(:get, "posts/#{get_id(:post)}/repost", :repost) do |h|
    h["data"]["repost_of"]["you_reposted"] = true
end %>

## Unrepost a Post

Given the original `post_id`, delete the current user's repost. *Note: this same functionality can be accomplished by [deleting using the repost's post_id](/reference/resources/post/lifecycle/#delete-a-post)*.

<%= general_params_note_for "post" %>

<%= endpoint "DELETE", "posts/[post_id]/repost", "User", "write_post" %>

<%= url_params [
    ["post_id", "The id of the Post to unrepost."]
]%>

#### Example

<%= curl_example(:delete, "posts/#{get_id(:post)}/repost", :post) do |h|
    h["data"]["you_reposted"] = false
end %>