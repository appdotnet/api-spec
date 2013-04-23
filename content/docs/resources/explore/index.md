---
title: "Explore Stream"
---

# Explore Stream

* TOC
{:toc}

An Explore Stream is a subset of all public posts flowing through App.net's Global Stream. These Explore Streams are defined by App.net to provide developers and users new ways to discover posts. **We will be adding and removing Explore Streams so in your app please [Retrieve all Explore Streams](#retrieve-all-explore-streams) and cache that list for up to 24 hours instead of hardcoding the current Explore Streams into your app.**

~~~ js
{
    "description": "Photos uploaded to App.net",
    "slug": "photos",
    "title": "Photos",
    "url": "https://alpha-api.app.net/stream/0/posts/stream/explore/photos"
}
~~~

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

> GET https://alpha-api.app.net/stream/0/posts/stream/explore

~~~ js
{
    "data": [
        {
            "description": "Photos uploaded to App.net",
            "slug": "photos",
            "title": "Photos",
            "url": "https://alpha-api.app.net/stream/0/posts/stream/explore/photos"
        },
        ...
    ],
    "meta": {
        "code": 200
    }
}
~~~

## Retrieve an Explore Stream

Retrieve the Posts in an Explore Stream.

<%= pagination_note %>

<%= endpoint "GET", "posts/stream/explore/[slug]", "None" %>

<%= url_params [
    ["slug", "The slug of the Explore Stream to retrieve."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/posts/stream/explore/photos

~~~ js
{
    "data": [
        ...posts...
    ],
    "meta": {
        "code": 200,
        "explore_stream": {
            "description": "Photos uploaded to App.net",
            "slug": "photos",
            "title": "Photos",
            "url": "https://alpha-api.app.net/stream/0/posts/stream/explore/photos"
        },
        "max_id": "3382496",
        "min_id": "3382480",
        "more": true,
        "marker": {
            "name": "explore:photos"
        }
    }
}
~~~
