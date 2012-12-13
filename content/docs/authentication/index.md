---
title: "Authentication"
---

# Authentication

* TOC
{:toc}

As a developer working with App.net, you are required to follow some simple rules to ensure that the privacy and security of user data is protected. To help you achieve that, we've put together this document on how to authenticate with App.net.

All requests to the API—authenticated or not—must be made over HTTPS. We use the [OAuth 2.0 protocol](http://tools.ietf.org/html/draft-ietf-oauth-v2-31) for API authentication, but only certain portions of the specification. For instance, we only support the use of bearer tokens as access tokens. The specification is a little dense on the standards-speak, but we encourage you to take a look. We'll explain our specific use of OAuth 2 in this document.

**Note** We changed the base domain that we use for the authentication flow from **alpha.app.net** to **account.app.net**. The old URLs will continue to work forever.

## Initial Developer Setup

Once you have signed up as a developer, you will be able to create an app from the [App.net developer dashboard](https://account.app.net/developer/apps/). You will need to pre-register a **redirection URI**. This is where we will redirect users after they have successfully authorized your application.

Once you have created an application, you will be assigned a **client ID** and **client secret**. You will use these in the authentication flow. The client ID may be publicly shared (e.g., included in a compiled binary or in the source code of a web page), but the client secret **must** be kept confidential.

You authenticate to our API by use of an **access token**. There are two types of access tokens: client tokens and user tokens. **Client tokens** represent access to API resources on behalf of the application and **user tokens** represent access to API resources on behalf of a specific user. Some resources are only accessible to client or user tokens.

It should go without saying, but for the sake of user privacy and security, please ensure that your App.net account has a **strong password**.

## How do I get an access token?

If you want a **user token**, you must use one of these flows:

* **[Web flow (server-side)](/docs/authentication/flows/web/#server-side-flow)** - use this if you're building a web application backed by a server. (The OAuth 2.0 internet-draft calls this the [Authorization Code Flow](http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-4.1).)
* **[Web flow (client-side)](/docs/authentication/flows/web/#client-side-flow)** - use this if you're building an application without a central server, like a mobile app or a client-side Javascript app. (The OAuth 2.0 internet-draft calls this the [Implicit Grant Flow](http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-4.2).)
* **[Password flow](/docs/authentication/flows/password/)** - use this if you're building a native application (or an application where it is difficult to use a web browser) and want to avoid implementing a web-based authentication flow. This flow requires special permission to use and comes with a bunch of extra rules and requirements to protect user security.

If you're only interested in obtaining a **client token** (sometimes called an "App token"), you can use the **[app access token flow](/docs/authentication/flows/app_access_token)**. (The OAuth 2.0 internet-draft calls this this [Client Credentials Grant](http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-4.4).)

We also intend to provide a SDK you can embed into your mobile applications to provide seamless authentication with App.net to your application's users.

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

* **basic**: see basic information about this user
* **stream**: read this user's stream
* **email**: access this user's email address
* **write_post**: create a new post as this user
* **follow**: add or remove follows (or mutes) for this user
* **messages**: send and receive private messages as this user
* **update_profile**: update a user's name, images, and other profile information
* **export**: bulk export all of this user's App.net data. This is intended only for backup services, not day-to-day App.net client use. Users will be shown an extra warning when this scope is requested due to the sensitivity of this data.

The **basic** scope will always be granted on creation of access token, even if the token request omits it.

## Making Authenticated API Requests

All requests to the API—authenticated or not—must be made over HTTPS.

When making a call to one of our API resources, there are three ways to include authentication information.

> In all of these examples, `[access token]` is the user's access token, free of any JSON framing or query string parameters.

* Adding an Authorization header (**preferred**)

    Add the following header to your request:
    `Authorization: Bearer [access token]`
    where `[access token]` is the value of the user's access token.

    Here's an example:
    
        curl -H 'Authorization: Bearer [access token]' \
             -F 'text=Test post' \
             https://alpha-api.app.net/stream/0/posts

* Add `access_token` to query string
    
        curl https://alpha-api.app.net/stream/0/posts/1?access_token=[access token]

* Add `access_token` to HTTP body. 

    > Note: this method will only work with the `PUT`, `POST`, and `PATCH` methods. `GET` and `DELETE` do not accept an HTTP body.

        curl -F 'access_token=[access token]' \
             -F 'text=Test post' \
             https://alpha-api.app.net/stream/0/posts

## How can I authenticate between App.net apps?

We call this Identity Delegation. The detailed [Identity Delegation
specification](identity_delegation/) has its own page.

