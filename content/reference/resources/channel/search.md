---
title: "Channel Search"
---

# Search

* TOC
{:toc}

## Search for Channels

Returns [Channel](/reference/resources/channel/) objects which match a given search query. Because channels have no inherent notion of description or name, we take textual data from common channel annotations which contain such fields, e.g. <code>net.patter-app.settings</code>. We also allow filtering on specific channel properties, such as channel type. No matter what query data is supplied, the search results will respect channel ACLs, and results are limited to non-private channels if the requesting access token does not have the <code>messages</code> scope.

<%= general_params_note_for "channel" %> Note: Pagination works for all orderings on this endpoint. Be sure to make requests with before_id=min_id or since_id=max_id as usual when paginating the popularity-sorted results. Separate lists of terms by spaces.

<%= endpoint "GET", "channels/search", "User", "public_messages</code> or <code>messages" %>

<%= query_params_typed 'General Parameters', [

    ["order", :optional, "string", "One of: <code>popularity</code> (default), <code>id</code>, or <code>activity</code>. Searches of ordering <code>popularity</code> are returned in an order that roughly matches the popularity of the channels. <code>activity</code> searches will order results roughly by time of last message (precise sorting of very recent messages is not guaranteed)."],

]%>

<%= query_params_typed 'Search Query Parameters', [

    ["q", :optional, "string", "Searches any textual fields extracted from channel annotations. We may tweak which annotations and fields are included by this search over time."],

]%>


<%= query_params_typed 'Filter Parameters', [
    ["type", :optional, "string", "Only include channels which were created with a specific channel type"],
    ["creator_id", :optional, "string", "Only include channels which were created by a user with a certain id"],
    ["tags", :optional, "string", "Only include channels which are tagged with certain tags. This data is extracted from channel annotations"],
    ["is_private", :optional, "boolean", "Only include channels which have <code>any_user</code> and <code>public</code> set to false for read and write ACLs"],
    ["is_public", :optional, "boolean", "Only include channels which have <code>public</code> set to true for read ACLs"],

]%>

#### Example

> GET https://alpha-api.app.net/stream/0/channels/search?q=kerbal&order=popularity

<%= paginated_response(:channel) do |h|
    h["meta"]["count"] = 1
    h["meta"]["max_id"] = "10000"
    h["meta"]["min_id"] = "10000"
end %>
