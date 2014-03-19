---
title: "User Blocking"
---

# Blocking

* TOC
{:toc}

## Block a User

Block a user from seeing your App.net content. This means the user will not be able to see, star, reply to, or repost your content. This user will also effectively be muted for you. This will automatically unfollow both users from each other. A user may be able to  tell if they've been blocked by a user. For instance if @mthurman blocks @berg and @berg logs out of alpha.app.net, he could see @mthurman's profile.

In most cases, [muting a user](/reference/resources/user/muting/#mute-a-user) is probably sufficient since that hides all of a user's content from you. If a user is aggressively reposting or starring your content, blocking them will prevent them from interacting with your content at all.

<%= general_params_note_for "user" %>

<%= endpoint "POST", "users/[user_id]/block", "User", "follow" %>

<%= url_params [
  ["user_id","The id of the User to block. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> POST https://alpha-api.app.net/stream/0/users/1/block

<%= response(:user) do |h|
    h["data"]["you_blocked"] = true
    h["data"]["you_follow"] = false
end %>

## Unblock a User

Allow a blocked user to interact with my content.

<%= general_params_note_for "user" %>

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/reference/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "users/[user_id]/block", "User", "follow" %>

<%= url_params [
  ["user_id","The id of the User to block. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> DELETE https://alpha-api.app.net/stream/0/users/1/block

<%= response(:user) do |h|
    h["data"]["you_blocked"] = false
    h["data"]["you_follow"] = false
end %>

## List blocked Users

Retrieve a list of blocked users.

<%= general_params_note_for "user" %>

<%= endpoint "GET", "users/[user_id]/blocked", "Any" %>

<%= url_params [
  ["user_id",'The id of the user to retrieve a list of muted users for. If requested with a <a href="/reference/authentication/#access-tokens">user token</a> you can request blocked users for the current user by using <code>me</code> as the user id. If requested with an <a href="/reference/authentication/#access-tokens">app token</a> you can request blocked users for any user that has authorized your app.']
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/me/blocked

<%= collection_response(:user) do |h|
    h["data"][0]["you_blocked"] = true
    h["data"][0]["you_follow"] = false
end %>

## Retrieve blocked User IDs for multiple Users

Returns a list of blocked User ids for each User id requested. At most 200 User ids can be requested.

<%= endpoint "GET", "users/blocked/ids", "App" %>

<%= query_params [
  ["ids","A comma separated list of User ids to retrieve blocked User ids for."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/blocked/ids?ids=1,2

<%= response({
    "1" => ["3", "29"],
    "2" => []
}) %>
