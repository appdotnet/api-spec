---
title: "Message Lookup"
---

# Lookup

* TOC
{:toc}

## Retrieve a Message

Returns a specific [Message](/reference/resources/message/).

*You can always retrieve a message you created even if you are no longer able to view the rest of the Channel anymore.*

<%= general_params_note_for "message" %>

<%= endpoint "GET", "channels/[channel_id]/messages/[message_id]", "Any" %>

<%= url_params [
    ["channel_id", "The id of the Channel containing the Message."],
    ["message_id", "The id of the Message to retrieve."]
]%>

#### Example

<%= curl_example(:get, "channels/1/messages/1", :message) %>

## Retrieve multiple Messages

Returns multiple Messages requested by id. At most 200 messages can be requested. Messages may be requested from more than one channel at a time. Messages which do not exist or which the requesting user does not have authorization to view will not be returned.

<%= general_params_note_for "message" %>

<%= endpoint "GET", "channels/messages", "Any" %>

<%= query_params [
    ["ids", "A comma separated list of ids of the Messages to retrieve."]
]%>

#### Example

<%= curl_example(:get, "channels/messages?ids=1,2", :message, {:response => :collection}) %>

## Retrieve my Messages

Retrieve a stream of the Messages the current user has created.

<%= general_params_note_for "message" %>

<%= pagination_note %>

<%= endpoint "GET", "users/me/messages", "User", "public_messages</code> or <code>messages" %>

#### Example

<%= curl_example(:get, "users/me/messages", :message, {:response => :paginated}) %>
