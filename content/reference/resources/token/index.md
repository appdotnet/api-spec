---
title: "Token"
---

# Token

* TOC
{:toc}

## Retrieve current token

Returns info about the current [OAuth access token](/reference/authentication/#access-tokens). If the token is a user token the response will include a [User](/reference/resources/user/) object.

<%= endpoint "GET", "token", "Any" %>

#### Example (App Token)

<%= curl_example(:get, "token", :user_token, {:token => "YOUR APP TOKEN"}) %>

#### Example (User Token)

<%= curl_example(:get, "token", :user_token) %>


## Deauthorize current token

Deauthorize the current [OAuth access token](/reference/authentication/#access-tokens). This works for User tokens and App tokens.

<%= endpoint "DELETE", "token", "Any" %>

#### Example

Requested with a user access token:

<%= curl_example(:delete, "token", :user_token) %>

## Retrieve authorized User IDs for an app

Returns a list of ids of Users that have authorized an app. Must be requested using an [app access token](/reference/authentication/#access-tokens). 

<%= endpoint "GET", "apps/me/tokens/user_ids", "App" %>

#### Example

<%= curl_example(:get, "apps/me/tokens/user_ids", ["2", "3"]) %>

## Retrieve authorized User tokens for an app

Returns a list of User tokens corresponding to an app token. Must be requested using an [app access token](/reference/authentication/#access-tokens). 

<%= pagination_note %>

<%= endpoint "GET", "apps/me/tokens", "App" %>

#### Example

<%= curl_example(:get, "apps/me/tokens", :user_token, {:response => :paginated}) do |h|
    h["data"][0]["pagination_id"] = "10723"
end %>
