---
title: "Channel Search"
---

# Search

* TOC
{:toc}

## Search for Channels

Returns [Channel](/docs/resources/channel/) objects which match a given search query. Because channels have no inherent notion of description or name, we take textual data from common channel annotations which contain such fields, e.g. <code>net.patter-app.settings</code>. We also allow filtering on specific channel properties, such as channel type. No matter what query data is supplied, the search results will respect channel ACLs, and results are limited to non-private channels if the requesting access token does not have the <code>messages</code> scope.

<%= general_params_note_for "channel" %> Note: Pagination works for all orderings on this endpoint. Be sure to make requests with before_id=max_id or since_id=min_id as usual when paginating the popularity-sorted results. Separate lists of terms by spaces.

<%= endpoint "GET", "channels/search", "User", "public_messages</code> or <code>messages" %>

<%= query_params_typed 'General Parameters', [

    ["order", :optional, "string", "One of: <code>popularity</code> (default), <code>id</code>, or <code>activity</code>. Searches of ordering <code>popularity</code> are returned in an order that roughly matches the popularity of the channels. <code>activity</code> searches will order results roughly by time of last message (precise sorting of very recent messages is not guaranteed)."],

]%>

<%= query_params_typed 'Search Query Parameters', [

    ["q", :optional, "string", "Searches any textual fields extracted from channel annotations. We may tweak which annotations and fields are included by this search over time."],

]%>


<%= query_params_typed 'Filter Parameters', [
    ["type", :optional, "string", "Only include channels which were created with a specific channel type"],
    ["creator_id", :optional, "string", "Only include channels which were created by a user with a certain id"],
    ["tags", :optional, "string", "Only include channels which are tagged with certain tags. This data is extracted from channel annotations"],
    ["is_private", :optional, "boolean", "Only include channels which have <code>any_user</code> set to false for read and write ACLs"],
    ["is_public", :optional, "boolean", "Only include channels which have <code>public</code> set to true for read ACLs"],

]%>

#### Example

> GET https://alpha-api.app.net/stream/0/channels/search?q=kerbal&order=popularity

~~~ js
{
    "data": [
        ...
        {
            "counts": {
                "messages": 178
            },
            "has_unread": false,
            "id": "13797",
            "is_inactive": false,
            "owner": {
                ...
            },
            "readers": {
                "any_user": false,
                "immutable": false,
                "public": true,
                "user_ids": [],
                "you": true
            },
            "recent_message_id": "1222525",
            "type": "net.patter-app.room",
            "writers": {
                "any_user": true,
                "immutable": false,
                "public": false,
                "user_ids": [],
                "you": true
            },
            "you_can_edit": true,
            "you_muted": false,
            "you_subscribed": true,
            "annotations": [
                {
                    "type": "net.patter-app.settings",
                    "value": {
                        "blurb": "Discussion for the wonderful space simulator "Kerbal Space Program." Rocket designs, missions, anecdotes etc. welcome",
                        "blurb_id": "417309",
                        "categories": ["fun"],
                        "name": "Kerbonauts"
                    }
                },
                {
                    "type": "net.app.core.fallback_url",
                    "value": {
                        "url": "http://patter-app.net/room.html?channel=13797"
                    }
                }
            ]
        }
    ],
    "meta": {
        "code": 200,
        "max_id": "1",
        "min_id": "1",
        "more": false
    }
}
~~~
