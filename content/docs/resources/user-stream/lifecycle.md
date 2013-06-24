---
title: "User Stream Lifecycle"
---

# User Stream Lifecycle

* TOC
{:toc}

## Delete a User Stream

Delete a [User Stream](/docs/resources/user-stream/). The User Stream must belong to the current token. It disconnects any sockets with this User Stream open and returns an HTTP 204 No Content on success.

If you'd like your user stream to be automatically deleted when you disconnect from it, please add the [`auto_delete=1`](/docs/resources/user-stream/#limits) query string parameter when you create the user stream.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/docs/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "users/me/streams/[connection_id]", "User" %>

<%= url_params [
    ["connection_id", "The connection id of the User Stream to delete."]
]%>

### Example

> DELETE https://alpha-api.app.net/stream/0/streams/sxousNClc4Cq12du3f6GTZXNUvaHoJnFnjdOt6fH2xhJolPdDfR3rOxxjdPfPOIf
>
> 204 No Content

## Delete a User Stream subscription

Delete a subscription of a [User Stream](/docs/resources/user-stream/). The User Stream must belong to the current token. It returns an HTTP 204 No Content on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/docs/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "users/me/streams/[connection_id]/[subscription_id]", "User" %>

<%= url_params [
    ["connection_id", "The connection id of the User Stream the subscription belongs to."],
    ["subscription_id", "The subscription id of the subscription to cancel"]
]%>

### Example

> DELETE https://alpha-api.app.net/stream/0/streams/sxousNClc4Cq12du3f6GTZXNUvaHoJnFnjdOt6fH2xhJolPdDfR3rOxxjdPfPOIf/bf42ca05-e67e-4e26-8bd0-8b042dd5b04c
>
> 204 No Content
