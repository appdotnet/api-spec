---
title: "User Muting"
---

# Muting

* TOC
{:toc}

## Mute a User

Hide all posts for a User in all streams. *Note: if you still explicitly request this User's stream or a Post from this User, it will not be hidden.*

<%= general_params_note_for "user" %>

<%= endpoint "POST", "users/[user_id]/mute", "User", "follow" %>

<%= url_params [
  ["user_id","The id of the User to mute. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> POST https://alpha-api.app.net/stream/0/users/1/mute

<%= response(:user) do |h|
    h["data"]["you_muted"] = true
end %>

## Unmute a User

Stop hiding all posts for a given user.

<%= general_params_note_for "user" %>

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/reference/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "users/[user_id]/mute", "User", "follow" %>

<%= url_params [
  ["user_id","The id of the User to mute. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> DELETE https://alpha-api.app.net/stream/0/users/1/mute

<%= response(:user) do |h|
  h["data"]["you_muted"] = false
end %>

## List muted Users

Retrieve a list of muted users.

<%= general_params_note_for "user" %>

<%= endpoint "GET", "users/[user_id]/muted", "Any" %>

<%= url_params [
  ["user_id",'The id of the user to retrieve a list of muted users for. If requested with a <a href="/reference/authentication/#access-tokens">user token</a> you can request muted users for the current user by using <code>me</code> as the user id. If requested with an <a href="/reference/authentication/#access-tokens">app token</a> you can request muted users for any user that has authorized your app.']
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/me/muted

<%= collection_response(:user) do |h|
    h["data"][0]["you_muted"] = true
end %>

## Retrieve muted User IDs for multiple Users

Returns a list of muted User ids for each User id requested. At most 200 User ids can be requested.

<%= endpoint "GET", "users/muted/ids", "App" %>

<%= query_params [
  ["ids","A comma separated list of User ids to retrieve muted User ids for."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/muted/ids?ids=1,2

<%= response({
    "1" => ["3", "29"],
    "2" => []
}) %>
