---
title: "Post Lifecycle"
---

# Post Lifecycle

* TOC
{:toc}

## Create a Post

Create a new <a href="/reference/resources/post/">Post</a> object. Mentions and hashtags will be parsed out of the post text, as will bare URLs.

You can also create a Post by sending JSON in the HTTP post body that matches the <a href="/reference/resources/post/">post schema</a> with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```text```, ```reply_to```, ```machine_only```, ```annotations``` and ```entities```. To create complex posts (including [machine only posts](/reference/resources/post/#machine-only-posts)), you must use the JSON interface. See the [JSON example](#json-example) below. If you would like to specify your own entities, please refer to the [user specified entities](/reference/meta/entities/#user-specified-entities) documentation.

If you want to test how your text will be processed you can use the [text processor](/reference/resources/text-processor).

*Note: You cannot reply to a repost. Please reply to the parent Post.*

<%= general_params_note_for "post" %>

<%= endpoint "POST", "posts", "User", "write_post" %>

<%= post_params [
    ["text", "The raw text of the post."],
    ["reply_to", "(Optional) The id of the Post that this new Post is replying to."]
]%>

#### Example

<%= curl_example(:post, "posts", :first_post, {:data => "text=%40berg+FIRST+post+on+this+new+site+%23newsocialnetwork", :content_type => nil}) %>

#### Example (JSON Data)

<% data = {
    "text" => "@berg FIRST post on this new site #newsocialnetwork",
    "annotations" => [{
        "type" => "net.app.core.geolocation",
        "value" => {
            "latitude" => 74.0064,
            "longitude" => 40.7142
        }
    }]
} %>
<%= curl_example(:post, "posts?include_post_annoations=1", :first_post, {:data => data}) do |h|
    h["data"]["annotations"] = data["annotations"]
end %>

## Delete a Post

Delete a <a href="/reference/resources/post/">Post</a>. The current user must be the same user who created the Post. It returns the deleted Post on success.

<%= general_params_note_for "post" %>

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/reference/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "posts/[post_id]", "User", "write_post" %>

<%= url_params [
    ["post_id", "The id of the Post to delete."]
]%>

#### Example

<%= curl_example(:delete, "posts/1", :post) do |h|
    h["data"]["is_deleted"] = true
    h["data"].delete("text")
    h["data"].delete("html")
    h["data"]["entities"].each { |k, v| h["data"]["entities"][k] = []}
end %>
