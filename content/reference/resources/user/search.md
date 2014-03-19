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

<%= curl_example(:get, "users/search?q=%23api", :user, {:response => :paginated}) do |h|
    h["meta"]["count"] = 1
    h["data"][0]["pagination_id"] = "10000"
end %>
