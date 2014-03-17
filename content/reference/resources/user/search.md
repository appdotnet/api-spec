---
title: "User Search"
---

# Search

* TOC
{:toc}

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
