---
title: "Explore Stream"
---

# Explore Stream

* TOC
{:toc}

An Explore Stream is a subset of all public posts flowing through App.net's Global Stream. These Explore Streams are defined by App.net to provide developers and users new ways to discover posts. **We will be adding and removing Explore Streams so in your app please [Retrieve all Explore Streams](#retrieve-all-explore-streams) and cache that list for up to 24 hours instead of hardcoding the current Explore Streams into your app.**

<%= json(:explore_stream) %>

## Explore Stream Fields

<table class='table table-striped'>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>slug</code></td>
        <td>string</td>
        <td>Primary identifier for an explore stream. A lowercase alphanumeric string.</td>
    </tr>
    <tr>
        <td><code>title</code></td>
        <td>string</td>
        <td>A human-friendly name for this Explore Stream.</td>
    </tr>
    <tr>
        <td><code>description</code></td>
        <td>string</td>
        <td>A short description of this Explore Stream for displaying to the User.</td>
    </tr>
    <tr>
        <td><code>url</code></td>
        <td>string</td>
        <td>The fully qualified url to the Explore Stream.</td>
    </tr>
</table>

## Retrieve all Explore Streams

Retrieve a list of all Explore Streams. The list of Explore Streams are dynamic and will sometimes change. **Please cache them for 24 hours in your app.** Also, please note that this endpoint is not paginated.

<%= endpoint "GET", "posts/stream/explore", "None" %>

#### Example

<%= curl_example(:get, "posts/stream/explore", :explore_stream, {:response => :collection}) %>

## Retrieve an Explore Stream

Retrieve the Posts in an Explore Stream.

<%= pagination_note %>

<%= endpoint "GET", "posts/stream/explore/[slug]", "None" %>

<%= url_params [
    ["slug", "The slug of the Explore Stream to retrieve."]
]%>

#### Example

<%= curl_example(:get, "posts/stream/explore/photos", :explore_stream, {:response => :paginated}) do |h|
    h["meta"].merge!({
        "max_id" => "3382496",
        "min_id" => "3382480",
        "marker" => {
            "name" => "explore:photos"
        },
        "explore_stream" => get_hash(:explore_stream)
    })
    h["data"] = ["...post objects..."]
end %>
