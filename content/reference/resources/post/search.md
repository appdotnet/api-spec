---
title: "Post Search"
---

# Search

* TOC
{:toc}

## Search for Posts

Returns [Post](/reference/resources/post/) objects which match a given search query. Searches ordered by `id` require at least one query or filter to be specified; searches ordered by `score` require at least one query and zero or more filters to be specified. Searches require an ordering and at least one search query to be specified, and allow for zero or more filters to be added. All parameters should be passed in the query string.

<%= general_params_note_for "post" %> Note: Pagination is currently only available for the `id` ordering. All queries and filters are combined with an AND operation. Query parameters (not filter parameters) can use <em>"quoted strings"</em> for phrases, search syntax like <em>+foo -bar</em> and <em>foo OR baz</em> for boolean queries. Machine-only posts are not included in the search index. Separate lists of terms by spaces.

<%= endpoint "GET", "posts/search", "Any" %>

<%= query_params_typed 'General Parameters', [

    ["index", :optional, "string", "Type of index to use. The default (and currently, the only) index is <code>complete</code>, which searches all posts. <em>We may add additional index types later (e.g., an index only of recent posts, for speed.)</em>"],

    ["order", :optional, "string", "One of: <code>id</code> (default), <code>score</code>. Searches of ordering <code>id</code> are returned in roughly the same order as other streams, and support pagination. Searches of ordering <code>score</code> are returned by a relevance score. Currently, the only ordering that supports pagination is <code>id</code>, and we are working on improving relevance scores."],

]%>

<%= query_params_typed 'Search Query Parameters', [

    ["query", :optional, "string", "Automatically attempts to extract hashtags and mentions while searching text. If you do not want this behavior, you can use more specific parameters below."],
    ["text", :optional, "string", "Include posts containing certain text."],


]%>

<%= query_params_typed 'Filter Parameters', [
    ["hashtags", :optional, "string", "Only include posts tagged with certain hashtags. Do not include #"],
    ["links", :optional, "string", "Only include posts linking to certain URLs"],
    ["link_domains", :optional, "string", "Only include posts linking to certain domains. Do not include \"www.\""],
    ["mentions", :optional, "string", "Only include posts mentioning certain users, by username. Do not include @"],
    ["leading_mentions", :optional, "string", "Only include posts directed at users, by username. Do not include @"],
    ["annotation_types", :optional, "string", "Only include posts with a specific annotation type, e.g., <code>net.app.core.fallback_url</code>"],
    ["attachment_types", :optional, "string", "Only include posts with a specific file type attached via the <code>net.app.core.file_list</code> annotation"],
    ["crosspost_url", :optional, "string", "Only include posts which are crossposts of a specific URL, via the <code>net.app.core.crosspost</code> annotation"],
    ["crosspost_domain", :optional, "string", "Similar to <code>crosspost_url</code>, but only match on the host portion of the URL. Do not include \"www.\""],
    ["place_id", :optional, "string", "Only include posts which are check-ins at a specific place, via the <code>net.app.core.checkin</code> annotation"],

    ["is_reply", :optional, "int (0 or 1)", "Only include replies"],
    ["is_directed", :optional, "int (0 or 1)", "Only include posts with leading mentions, i.e., posts which were directed at other users"],
    ["has_location", :optional, "int (0 or 1)", "Only include posts containing geo coordinates, i.e., tagged with the <code>net.app.core.geolocation</code> annotation"],
    ["has_checkin", :optional, "int (0 or 1)", "Only include posts containing place IDs, i.e., tagged with the <code>net.app.core.checkin</code> annotation"],
    ["is_crosspost", :optional, "int (0 or 1)", "Only include posts which are crossposts, i.e., tagged with the <code>net.app.core.crosspost</code> annotation"],
    ["has_attachment", :optional, "int (0 or 1)", "Only include posts with file attachments"],
    ["has_oembed_photo", :optional, "int (0 or 1)", "Only include posts with photo oembed annotations"],
    ["has_oembed_video", :optional, "int (0 or 1)", "Only include posts with video (not html5video) oembed annotations"],
    ["has_oembed_html5video", :optional, "int (0 or 1)", "Only include posts with html5video oembed annotations"],
    ["has_oembed_rich", :optional, "int (0 or 1)", "Only include posts with rich oembed annotations"],

    ["language", :optional, "string", "Only include posts with a certain language tagged with the <code>net.app.core.language</code> annotation."],
    ["client_id", :optional, "string", "Only include posts created by a certain app. Use the alphanumeric client_id"],
    ["creator_id", :optional, "string", "Only include posts created by a specific user. Use the user ID, not the username"],
    ["reply_to", :optional, "string", "Only include immediate replies to a given post ID"],
    ["thread_id", :optional, "string", "Only include posts on a specific thread"],

]%>

#### Example

<%= curl_example(:get, "posts/search?hashtags=joinus&mentions=berg&count=-1", :post, {:response => :paginated}) do |h|
    h["meta"]["count"] = 1
    h["data"][0]["pagination_id"] = "10000"
end %>
