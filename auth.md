# Authentication

**NOTE: These endpoints aren't yet live (nor is the developer dashboard). As we develop them, we're inviting the developers that will consume them to comment on them and help us make them the best they can be. If you've signed up to back the project as a developer, we'll send you a note when you can obtain OAuth credentials.**

As a developer working with App.net, you are required to follow some simple rules to ensure that the privacy and security of user data is protected. To help you achieve that, we've put together this document on how App.net intends to authenticate users.

All requests to the API—authenticated or not—must be made over HTTPS. We use the [OAuth 2.0 protocol](http://tools.ietf.org/html/draft-ietf-oauth-v2-31) for API authentication, but only certain portions of the specification. For instance, we only support the use of bearer tokens as access tokens. The specification is a little dense on the standards-speak, but we encourage you to take a look. We'll explain our specific use of OAuth 2 in this document.

## Initial Developer Setup

Once you have signed up as a developer, you will be able to create an app from the App.net developer dashboard. You will need to pre-register a **redirection URI**. This is where we will redirect users after they have succesfully authorized your application.

Once you have created an application, you will be assigned a **client ID** and **client secret**. You will use these in the authenticaion flow. The client ID may be publicly shared (e.g., included in a compiled binary or in the source code of a web page), but the client secret **must** be kept confidential.

You authenticate to our API by use of an **access token**. There are two types of access tokens—client tokens and user tokens. **Client tokens** represent access to API resources on behalf of the application and **user tokens** represent access to API resources on behalf of a specific user.

It should go without saying, but for the sake of user privacy and security, please ensure that your App.net account has a **strong password**.

## How do I get an access token?

If you're only interested in obtaining a **client token**, you can use the [Client Password](http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-2.3) flow. (Note: we support sending the `client_id` / `client_secret` parameters in the HTTP message body only.)

If you want a **user token**, you must use one of these two flows:

* If you're building a web application backed by a server, you probably want to use our **server-side flow**. (The OAuth 2.0 internet-draft calls this the "[Authorization Code Flow](http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-4.1).")
* If you're building an application without a central server, like a mobile app or a client-side Javascript app, you can use the **client-side flow**. (The spec calls this the [Implicit Grant Flow](http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-4.2).)

We also intend to provide a SDK you can embed into your mobile applications to provide seamless authentication with App.net to your application's users.

### Server-side Flow (Ruby, Python, PHP, Java, etc.)

This is the easiest way to get an access token—we recommend it to most users of the API.

You must keep your client_secret confidential. That means that you may not include it in the source code or binary of an application that you ship to end-users, even in obscured form. The [client-side flow](#client-side-flow) is the proper flow to use in these cases.

1. Direct the user that you want to authenticate to this URL:
    ```
    https://api.app.net/oauth/authenticate
        ?client_id=[your client ID]
        &response_type=code
        &redirect_uri=[your redirect URI]
        &scope=[scopes separated by spaces]
    ```

    > To avoid cross-site scripting attacks, we also support the **state** paramater. If you include a state parameter, we will append it to the query parameters when redirecting the user to your **Redirection URI**.

    We'll request that the user log in to App.net and show them a permissions dialog allowing them to choose whether to authorize your application.

1. If the user decides to authorize your application, they will be redirected to:
    `https://[your registered redirect URI]/?code=CODE`

    > If you included a query string in your redirect URI, the `code` parameter will be appended. Likewise, the scheme of your redirect URI will be respected, though we strongly recommend sending all traffic over HTTPS.

1. On your server, your application should then make the following request:
    ```
    https://api.app.net/oauth/access_token
        ?client_id=[your client ID]
        &client_secret=[your client secret]
        &grant_type=authorization_code
        &redirect_uri=[your registered redirect URI]
        &code=[code received from redirect URI]
    ```

    > Note: we also accept the `client_id` and `client_secret` parameters via the Authorization header, as described in [section 2.3.1 of the spec](http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-2.3.1).

1. App.net will respond with a JSON-encoded token:
    ```js
{"access_token": "[user access token]"}
    ```
    You can use this access_token to make authenticated calls to the App.net API on behalf of a user.

### Client-side Flow

If you're building a client-side Javascript app or a mobile app that doesn't have an associated back-end server, you'll find that you need to take some special steps to keep your `client_secret` confidential.

1. Direct the user that you want to authenticate to this URL:
    ```
    https://api.app.net/oauth/authenticate
        ?client_id=[your client ID]
        &response_type=token
        &redirect_uri=[your redirect URI]
        &scope=[scopes separated by spaces]
    ```

    > To avoid cross-site scripting attacks, we also support the **state** paramater. If you include a state parameter, we will append it to the query parameters when redirecting the user to your **Redirection URI**.

    We'll request that the user log in to App.net and show them a permissions dialog allowing them to choose whether to authorize your application.

1. If the user decides to authorize your application, they will be redirected to:
    `https://[your registered redirect URI]/#access_token=[user access token]`

    > If you included a query string in your redirect URI, the `code` parameter will be appended. Likewise, the scheme of your redirect URI will be respected, though we strongly recommend sending all traffic over HTTPS.

    The access_token will be appended to the URI in the fragment section, encoded as if it were a query string. Your client-side code should parse this for the access_token.

### Errors

If an error occurs while obtaining an access token, we'll notify you by redirecting the user to the **Redirection URI** with the following additional query string or fragment parameters:

* `error` — a single error code from [this list](http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-4.1.2.1)
* `error_description` — a human readable error description.
* `error_uri` — a URI identifying a human-readable webpage with information about the error.

If a user is redirected to your application with an error code, you should be sure to give your user an informative error message.

### Scopes

Scopes are how an application specifies what kind of data it wants from a User. They are specified on the initial access token request. A user will be able to see a list of the permissions you are requesting with explanations of what each of the permissions means. They will be able to authorize any permissions they choose. Your app should not assume that an access token has all the requested scopes.

When using an OAuth token, App.net will include an extra HTTP headers so the app knows what scopes that token has authorized. For example:

> X-OAuth-Scopes: email,follow

means that the current token has permission to see the user's email and to follow new users.

Here is the current list of scopes on App.net:

* **stream**: read a user's stream
* **email**: access a user's email address
* **write_post**: create a new post as a user
* **follow**: add or remove follows for this user
* **messages**: send and receive private messages as this user
* **export**: bulk export all of your App.net data. This is intended only for backup services, not day-to-day App.net client use. Users will be shown an extra warning when this scope is requested due to the sensitivity of this data.

If scope is omitted, only basic profile information will be available.

## Authenticated API Requests

All requests to the API—authenticated or not—must be made over HTTPS.

When making a call to one of our API resources, there are three ways to include authentication information.

> In all of these examples, `[access token]` is the user's access token, free of any JSON framing or query string parameters.

* Adding an Authorization header (**preferred**)
    Add the following header to your request:
    `Authorization: Bearer [access token]`
    where `[access token]` is the value of the user's access token.

    Here's an example:
    ```bash
    curl -H 'Authorization: Bearer [access token]' \
         -F 'text=Test post' \
         https://api.app.net/stream/0/posts

    ```

* Add `access_token` to query string
    ```bash
    curl https://api.app.net/stream/0/posts/1?access_token=[access token]
    ```

* Add `access_token` to HTTP body

    ```bash
    curl -F 'access_token=[access token]' \
         -F 'text=Test post' \
         https://api.app.net/stream/0/posts
    ```
