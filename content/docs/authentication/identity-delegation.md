---
title: "Identity Delegation"
---

# Identity Delegation

* TOC
{:toc}

The purpose of this specification is to define a method by which one App.net app is able to verifiably prove to another application that it has access to a specific user's account without sharing any secret credentials.

## Definitions

> Unless otherwise defined here, terms should have the same approximate usage as the OAuth 2.0 draft specification.

* **delegate client**: The client to which the identity delegation is made (e.g., a photo hosting service)
* **authorized client**: The client wishing to make a request to the delegate client (e.g., an App.net mobile client application)

## Scope

Intentionally not addressed in this document are the following:

* Authorization of delegate client to make requests to the request server on behalf of the resource owner
* Discovery of delegate client `client_id`
* Discovery of user identity endpoints
* Format of user identity endpoint

## Steps

1. The authorized client completes an OAuth authorization flow and obtains an access token from the resource server. This is outside the scope of this document.

1. The authorized client makes an authenticated POST request to the resource server OAuth token endpoint:

        POST /oauth/access_token HTTP/1.1
        Host: account.app.net
        Authorization: Bearer [access_token]
        Content-Length: 59
        Content-Type: application/x-www-form-urlencoded

        grant_type=delegate&delegate_client_id=[delegate client_id]

    which returns in the body of the reply:

        {"delegate_token": "[delegate token]"}

    > For App.net, the OAuth token endpoint is: `https://account.app.net/oauth/access_token`

1. The authorized client makes a request to the delegate client with two additional headers, `Identity-Delegate-Token` and `Identity-Delegate-Endpoint`:

        POST /protected/resource HTTP/1.1
        Host: delegate-client.example.com
        Identity-Delegate-Token: [delegate_token]
        Identity-Delegate-Endpoint: https://alpha-api.app.net/stream/0/token
        Content-Length: 100
        Content-Type: application/x-www-form-urlencoded

        do_some_stuff=1&fo_reals=1

    The Authorization header is purposefully not used, as another mechanism may be in place for authentication.

    > The delegate token and delegate endpoint may also be sent as delegate_token and delegate_endpoint in the query string or POST body.

1. The delegate client identifies the resource server by using the `Identity-Delegate-Endpoint` header and makes a request to that endpoint with the Authorization header set.

    > The query string parameters `delegate_token`, `client_id` and `client_secret` may be used in place of HTTP headers if desired.

        GET /stream/0/token HTTP/1.1
        Host: alpha-api.app.net
        Authorization: Basic [base64(client_id + ":" + client_secret)]
        Identity-Delegate-Token: [delegate_token]

    which returns in the body of the reply:

        {
            "data": {
                "app": {
                    "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                    "link": "http://foo.example.com",
                    "name": "Bryan's app for testing"
                },
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "scopes": [
                    "follow",
                    "write_post",
                    "stream"
                ],
                "user": {
                    "created_at": "2012-07-30T18:57:05Z",
                    "id": "16",
                    "locale": "en_US",
                    "name": "Bryan Berg",
                    "timezone": "America/Los_Angeles",
                    "type": "human",
                    "username": "bryan"
                    [... truncated for the sake of brevity ...],
                },
            },
            "meta": {
                "code": 200
            }
        }

    The resource server replies with an implementation-dependent description of the current user, which must include the client_id the authorized client. In the case of App.net, this is the Token object of the authorizing client's access_token as returned by the [Retrieve current Token](/docs/resources/token/#retrieve-current-token) endpoint.

    The delegate client may verify that the authorized client matches some external authentication scheme and/or list of authorized applications. If the delegate token is not valid for the delegate client's client_id, this call will return a `401 Unauthorized`.

    > For App.net, the identity delegation endpoint is: `https://alpha-api.app.net/stream/0/token`

## Notes

1. `delegate_token`s are valid as long as their associated `access_token`s are valid.
1. The delegate client may cache the return value of the identity delegate endpoint for a short period of time.
1. Feedback on this draft is welcomed. Please open an issue on the [api-spec GitHub repo](https://github.com/appdotnet/api-spec/issues). Private or security-sensitive commentary can be sent to [bryan@app.net](mailto:bryan@app.net).
