---
title: "Interactions"
---

# Interactions

* TOC
{:toc}

Interactions are objects that represent users taking certain actions on App.net. Interactions are structured to form a sentence like: User X took action Y on object Z. If multiple users take the same action (e.g. multiple users reply to one post) within a set time window those events will be combined into a single Interaction.

> The `objects` list of an Interaction will vary based on the `action`

(Example) @dalton and @berg reposted post 1:

<%= json_output(:repost_interaction) %>

(Example) @berg started following @dalton:

<%= json(:follow_interaction) %>

## Interactions Fields

<table class='table table-striped'>
    <thead>
        <tr>
            <th>Field</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>action</code></td>
            <td>string</td>
            <td>What <code>users</code> did. Currently one of <code>follow</code>, <code>reply</code>, <code>repost</code>, <code>star</code>, <code>welcome</code>, <code>broadcast_create</code>, <code>broadcast_subscribe</code>, or <code>broadcast_unsubscribe</code>.</td>
        </tr>
        <tr>
            <td><code>event_date</code></td>
            <td>string</td>
            <td>The time of the most recent interaction occurred at in <a href='http://en.wikipedia.org/wiki/ISO_8601'>ISO 8601</a> format.</td>
        </tr>
        <tr>
            <td><code>objects</code></td>
            <td>list</td>
            <td><code>users</code> took <code>action</code> on. These objects will be Users if <code>action=follow</code>. For <code>star, repost, reply</code> these objects will be Posts. For <code>broadcast_create, broadcast_subscribe, broadcast_subscribe</code> these will be channels. For <code>welcome</code> this will be empty.</td>
        </tr>
        <tr>
            <td><code>users</code></td>
            <td>list</td>
            <td>A list of User objects that took <code>action</code> on <code>objects</code>.</td>
        </tr>
    </tbody>
</table>

## List User interactions with me

List all the [Interactions](/reference/resources/interaction/) other users have had with me. 

<%= pagination_note %>

> You can only request this list for the current user.

<!-- blockquote break -->
> Although this endpoint supports paging, a user's Interactions stream is continuously rebuilt as new actions in the system occur, so developers should generally plan to refetch the stream whenever switching to display it as Interactions may have shifted their position, with users being added or removed. If you need to keep track of activity in a more precise manner, you should using the [Streaming API](/reference/resources/app-stream/) to monitor the global feed for relevant activity.

This endpoint accepts the `interaction_actions` as a query string parameter whose value is a comma separated list of actions you're interested in. For instance, if you're only interested in repost and follow interactions you could request `stream/0/users/me/interactions?interaction_actions=repost,follow`.

<%= endpoint "GET", "users/me/interactions", "User" %>

#### Example

<%= curl_example(:get, "users/me/interactions", :repost_interaction, {:response => :paginated}) do |h|
    h["data"][0]["pagination_id"] = "10"
end %>
