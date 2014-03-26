---
title: "User Following"
---

# Following

* TOC
{:toc}

## Follow a User

Returns the <a href="/reference/resources/user/">User</a> object of the user being followed. 

<%= general_params_note_for "user" %>

<%= endpoint "POST", "users/[user_id]/follow", "User", "follow" %>

<%= url_params [
  ["user_id","The user id to be followed. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

<%= curl_example(:post, "users/#{get_id(:user)}/follow", :user) do |h|
    h["data"]["you_follow"] = true
end %>

## Unfollow a User

Returns the <a href="/reference/resources/user/">User</a> object of the user being unfollowed.

<%= general_params_note_for "user" %>

*Remember, access tokens cannot be passed in a HTTP body for `DELETE` requests. Please refer to the [authentication documentation](/reference/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "users/[user_id]/follow", "User", "follow" %>

<%= url_params [
  ["user_id","The user id to stop following. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

<%= curl_example(:delete, "users/#{get_id(:user)}/follow", :user) do |h|
    h["data"]["you_follow"] = false
end %>

## List users a user is following

Returns a list of <a href="/reference/resources/user/">User</a> objects the specified user is following.

<%= general_params_note_for "user" %>

<%= pagination_note %>

<%= endpoint "GET", "users/[user_id]/following", "Any" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

<%= curl_example(:get, "users/2/following", :user, {:response => :paginated}) do |h|
    h["meta"]["more"] = true
    h["data"][0]["pagination_id"] = "4621"
end %>

## List users following a user

Returns a list of <a href="/reference/resources/user/">User</a> objects for users following the specified user. Please note that the pagination is not based on user or post ids.

<%= general_params_note_for "user" %>

<%= pagination_note %>

<%= endpoint "GET", "users/[user_id]/followers", "Any" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

<%= curl_example(:get, "users/2/followers", :user, {:response => :paginated}) do |h|
    h["meta"]["more"] = true
    h["data"][0]["pagination_id"] = "2889"
end %>

## List user ids a User is following

Returns an array of user ids the specified user is following.

<%= endpoint "GET", "users/[user_id]/following/ids", "Any" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

<%= curl_example(:get, "users/#{get_id(:user)}/following/ids", ["2", "3"]) %>

## List user ids following a user

Returns an array of user ids for users following the specified user.

<%= endpoint "GET", "users/[user_id]/followers/ids", "Any" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

<%= curl_example(:get, "users/#{get_id(:user)}/followers/ids", ["2", "3"]) %>
