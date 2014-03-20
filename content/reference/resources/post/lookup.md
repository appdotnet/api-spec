---
title: "Post Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a Post

Returns a specific [Post](/reference/resources/post/).

<%= general_params_note_for "post" %>

<%= endpoint "GET", "posts/[post_id]", "None" %>

<%= url_params [
    ["post_id","The id of the Post to retrieve."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/posts/1

<%= response(:post) %>

## Retrieve multiple Posts

Returns multiple Posts requested by id. At most 200 posts can be requested.

<%= general_params_note_for "post" %>

<%= endpoint "GET", "posts", "Any" %>

<%= query_params [
    ["ids","A comma separated list of ids of Posts to retrieve."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/posts?ids=1,2,3

~~~ js
{
    "data": [
        {
            "id": "1", // note this is a string
            ...
        },
        {
            "id": "2",
            ...
        },
        {
            "id": "3",
            ...
        },
    ],
    "meta": {
        "code": 200
    }
}
~~~