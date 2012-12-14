---
title: "App Access Token Flow"
---

# App Access Token Flow

* TOC
{:toc}

The App Access Token Flow is used to request a token that is tied to your application instead of a specific user. **App access tokens cannot be distributed and must only be used from a server. You should consider them secret.** If you would like a client (i.e. mobile) application to use an app access token, that app must connect to a server you control that stores the app access token.

To retrieve an app access token, your app must make the following request:

    POST https://account.app.net/oauth/access_token

with URL-encoded POST body:

        client_id=[your client ID]
        &client_secret=[your client secret]
        &grant_type=client_credentials

> Note: we also accept the `client_id` and `client_secret` parameters via the Authorization header, as described in [section 2.3.1 of the spec](http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-2.3.1).

App.net will respond with a JSON-encoded token:

    {"access_token": "[app access token]"}

You can use this access_token to make authenticated calls to the App.net API on behalf of your app.
