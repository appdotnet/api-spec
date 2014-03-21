---
title: "Message Search"
---

# Search

* TOC
{:toc}

## Search for Messages

Returns [Message](/reference/resources/message/) objects which match a given search query. This endpoint responds to a list of channel IDs which can either given specifically or performed on all PM or Broadcast channels that the user is subscribed to. Searches can either be ordered by `id` or `score`. Searches ordered by `id` require at least one query or filter to be specified; searches ordered by `score` require at least one query and zero or more filters to be specified. All parameters should be passed in the query string.

<%= general_params_note_for "message" %> Note: Pagination is currently only available for the `id` ordering. All queries and filters are combined with an AND operation. Query parameters (not filter parameters) can use <em>"quoted strings"</em> for phrases, search syntax like <em>+foo -bar</em> and <em>foo OR baz</em> for boolean queries. Separate lists of terms by spaces.

<%= endpoint "GET", "channels/messages/search", "Any" %>

<%= query_params_typed 'General Parameters', [

    ["index", :optional, "string", "Type of index to use. The default (and currently, the only) index is <code>complete</code>, which searches all messages. <em>We may add additional index types later (e.g., an index only of recent messages, for speed.)</em>"],

    ["order", :optional, "string", "One of: <code>id</code> (default), <code>score</code>. Searches of ordering <code>id</code> are returned in roughly the same order as other streams, and support pagination. Searches of ordering <code>score</code> are returned by a relevance score. Currently, the only ordering that supports pagination is <code>id</code>, and we are working on improving relevance scores."],

]%>

<%= query_params_typed 'Search Query Parameters', [

    ["query", :optional, "string", "Automatically attempts to extract hashtags and mentions while searching text. If you do not want this behavior, you can use more specific parameters below."],
    ["text", :optional, "string", "Include messages containing certain text."],
    ["channel_ids", :required, "string", "Specifies the list of channels to search through. This must either be a list of IDs or one of `pm`, `broadcast`. Channel ACLs will be respected (read permission must be granted to the user)."],


]%>

<%= query_params_typed 'Filter Parameters', [
    ["hashtags", :optional, "string", "Only include messages tagged with certain hashtags. Do not include #"],
    ["links", :optional, "string", "Only include messages linking to certain URLs"],
    ["link_domains", :optional, "string", "Only include messages linking to certain domains. Do not include \"www.\""],
    ["mentions", :optional, "string", "Only include messages mentioning certain users, by username. Do not include @"],
    ["leading_mentions", :optional, "string", "Only include messages directed at users, by username. Do not include @"],
    ["annotation_types", :optional, "string", "Only include messages with a specific annotation type, e.g., <code>net.app.core.fallback_url</code>"],
    ["attachment_types", :optional, "string", "Only include messages with a specific file type attached via the <code>net.app.core.file_list</code> annotation"],
    ["place_id", :optional, "string", "Only include messages which are check-ins at a specific place, via the <code>net.app.core.checkin</code> annotation"],

    ["is_reply", :optional, "int (0 or 1)", "Only include replies"],
    ["is_directed", :optional, "int (0 or 1)", "Only include messages with leading mentions, i.e., messages which were directed at other users"],
    ["has_location", :optional, "int (0 or 1)", "Only include messages containing geo coordinates, i.e., tagged with the <code>net.app.core.geolocation</code> annotation"],
    ["has_checkin", :optional, "int (0 or 1)", "Only include messages containing place IDs, i.e., tagged with the <code>net.app.core.checkin</code> annotation"],
    ["has_attachment", :optional, "int (0 or 1)", "Only include messages with file attachments"],
    ["has_oembed_photo", :optional, "int (0 or 1)", "Only include messages with photo oembed annotations"],
    ["has_oembed_video", :optional, "int (0 or 1)", "Only include messages with video (not html5video) oembed annotations"],
    ["has_oembed_html5video", :optional, "int (0 or 1)", "Only include messages with html5video oembed annotations"],
    ["has_oembed_rich", :optional, "int (0 or 1)", "Only include messages with rich oembed annotations"],

    ["language", :optional, "string", "Only include messages with a certain language tagged with the <code>net.app.core.language</code> annotation."],
    ["client_id", :optional, "string", "Only include messages created by a certain app. Use the alphanumeric client_id"],
    ["creator_id", :optional, "string", "Only include messages created by a specific user. Use the user ID, not the username"],
    ["reply_to", :optional, "string", "Only include immediate replies to a given message ID"],
    ["thread_id", :optional, "string", "Only include messages on a specific thread"],

]%>

#### Example

<%= curl_example(:get, "channels/messages/search?query=hello&channel_ids=1&count=1", :message, {:response => :paginated}) do |h|
    h["meta"]["count"] = 1
end %>
