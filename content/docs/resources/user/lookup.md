---
title: "User Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a User

Returns a specific <a href="/docs/resources/user/">User</a> object.

<%= general_params_note_for "user" %>

<%= endpoint "GET", "users/[user_id]", "None" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/1

<%= response(:user) %>

## Retrieve multiple Users
Returns multiple Users requested by id. At most 200 users can be requested.

<%= general_params_note_for "user" %>

<%= endpoint "GET", "users", "Any" %>

<%= query_params [
  ["ids","A comma separated list of User ids to retrieve."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users?ids=1,2,3

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
        "code": 200,
    }
}
~~~

## Search for Users

Search the App.net userbase.

<%= general_params_note_for "user" %>

<%= endpoint "GET", "users/search", "Any" %>

<%= query_params [
  ["q","The search query. Supports @username or #tag searches as well as normal search terms. Searches username, display name, bio information. <b>Does not search posts.</b>"],
  ["count","(Optional) The number of Users to return, up to a maximum of 200. Defaults to 20 if not specified."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/search?q=%23api

<%= collection_response(:user) %>
