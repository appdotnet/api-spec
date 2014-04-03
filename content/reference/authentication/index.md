---
title: "Authentication"
---

# Authentication

* TOC
{:toc}

As a developer working with App.net, you are required to follow some simple rules to ensure that the privacy and security of user data is protected. To help you achieve that, we've put together this document on how to authenticate with App.net.

All requests to the API—authenticated or not—must be made over HTTPS. We use the [OAuth 2.0 protocol](http://tools.ietf.org/html/rfc6749) for API authentication, but only certain portions of the specification. For instance, we only support the use of bearer tokens as access tokens. The specification is a little dense on the standards-speak, but we encourage you to take a look. We'll explain our specific use of OAuth 2 in this document.

## Initial Developer Setup

Before you begin, make sure you've [created an app](/docs/guides/create-an-app/) in your [App.net developer dashboard](https://account.app.net/developer/apps/).

Once you have created an application, you will be assigned a **client ID** and **client secret**. You will use these in the authentication flow. The client ID may be publicly shared (e.g., included in a compiled binary or in the source code of a web page), but the client secret **must** be kept confidential.

You will also need to register a **Redirect URI** with App.net. This is where we will redirect users after they have successfully authorized your application.

It should go without saying, but for the sake of user privacy and security, please ensure that your App.net account has a **strong password**.

## Access Tokens

You authenticate to our API by use of an **access token**. There are two types of access tokens: _app_ tokens and _user_ tokens. **App tokens** (referred to as "client tokens" in the [OAuth 2.0 standard](http://tools.ietf.org/html/rfc6749)) represent access to API resources on behalf of the application and **user tokens** represent access to API resources on behalf of a specific user. Some resources are only accessible to app or user tokens.

<div class="alert alert-info alert-block">
<p>Only Apps created by a developer account can request access tokens for other App.net users. If you do not have a developer account, then your app can only be used with your own account. If you ever downgrade your developer account, all current tokens for your app will still work but no new users will be able to authorize it.</p>
</div>

## What kind of token do I need?

Each endpoint specifies the kind of token it needs:

* None: no access token is required
* User: a [user token](/reference/authentication/#how-do-i-get-an-access-token) is required.
* App: an [app token](/reference/authentication/flows/app-access-token/) is required.
* Any: either a user token or an app token may be provided but you must have a token of some kind.
* Varies: Authentication may not be required but if it is not provided, you may not be allowed to see a specific resource. For instance, the [Retrieve a Channel](/reference/resources/channel/lookup/#retrieve-a-channel) endpoint allows unauthenticated calls. But if you try to retrieve a Channel that is not marked public, the call will fail.

### Scopes

Scopes let you specify what data your App wants from a User. They do not apply to app tokens. Scopes are specified on the initial access token request. A user will be able to see a list of the scopes you are requesting with explanations of what each of the scopes means. Your app should not assume that an access token has all the requested scopes.

When using an OAuth token, App.net will include an extra HTTP headers so the app knows what scopes that token has authorized. For example:

> X-OAuth-Scopes: follow,write_post

means that the current token has permission to follow new users and to create posts for this user.

Here is the current list of scopes on App.net:

* **basic**: see basic information about this user
* **stream**: read this user's stream
* **write_post**: create a new post as this user
* **follow**: add or remove follows (or mutes) for this user
* **public_messages**: send and receive public messages as this user
* **messages**: send and receive public and private messages as this user
* **update_profile**: update a user's name, images, and other profile information
* **files**: manage a user's files. This is not needed for uploading files.
* **export**: bulk export all of this user's App.net data. This is intended only for backup services, not day-to-day App.net client use. Users will be shown an extra warning when this scope is requested due to the sensitivity of this data.

The **basic** scope will always be granted on creation of a user access token, even if the token request omits it.

## How do I get an access token?

### User Token

* **[Web flow (server-side)](/reference/authentication/flows/web/#server-side-flow)** - use this if you're building a web application backed by a server. (The OAuth 2.0 standard calls this the [Authorization Code Grant](http://tools.ietf.org/html/rfc6749#section-4.1).)
* **[Web flow (client-side)](/reference/authentication/flows/web/#client-side-flow)** - use this if you're building an application without a central server, like a mobile app or a client-side Javascript app. (The OAuth 2.0 standard calls this the [Implicit Grant](http://tools.ietf.org/html/rfc6749#section-4.2).)
* **[Native App SDK flow](/reference/authentication/flows/sdk/)** - use this if you're building an iOS or Android client. We provide an SDK that you can integrate into your app to streamline authentication.
* **[Password flow](/reference/authentication/flows/password/)** - use this if you're building a native application (or an application where it is difficult to use a web browser) and want to avoid implementing a web-based authentication flow. This flow requires special permission to use and comes with a bunch of extra rules and requirements to protect user security.

<div class="alert alert-error alert-block">
<p>If you're submitting your application to one of Apple's App Stores, we suggest you implement authentication via the <a href="/reference/authentication/flows/sdk/">Native App SDK flow</a> or the <a href="/reference/authentication/flows/password/">Password Flow</a>. Otherwise, it's possible your app will be rejected.</p>
</div>

### App Token

**To obtain an app token**, you must use the **[app access token flow](/reference/authentication/flows/app-access-token)**. (The OAuth 2.0 internet-draft calls this this [Client Credentials Grant](http://tools.ietf.org/html/rfc6749#section-4.4).)

## Errors

All OAuth errors will have the following information provided:

* `error` — a single error code from one of the following lists (depending on which flow you're going through)
    * [Errors when requesting an `authorization_code` from the user in the server-side web flow](http://tools.ietf.org/html/rfc6749#section-4.1.2.1)
    * [Errors when requesting a token from the user in the client-side web flow](http://tools.ietf.org/html/rfc6749#section-4.2.2.1)
    * [Errors when requesting a token from any other flow](http://tools.ietf.org/html/rfc6749#section-5.2)
* `error_description` — a human readable error description.

If you're requesting an `authorization_code` from a user in the [server-side web flow](/reference/authentication/flows/web/#server-side-flow) we'll notify you of the error by appending it to your `redirect_uri` as query string parameters.

If you're requesting a token via the [client-side web flow](/reference/authentication/flows/web/#client-side-flow), we'll append the error to your `redirect_uri` as a URL encoded fragment.

For all other cases, the error will be returned as JSON in the response to your request.

Please ensure your application displays an error message to the user if you receive an error from App.net.

### Common OAuth Errors

#### "Please contact the website that sent you here and let them know that there is a problem with the Redirect URI."

Please make sure that the `redirect_uri` you're passing to App.net is registered for your app in the [Apps dashboard](https://account.app.net/developer/apps/).

#### "Non-developer apps can only be authorized by their owner."

This app is owned by an account that isn't a developer account. Remember, apps not owned by a developer account can only authorized the owner of the app. If you believe you have a developer account, please check to make sure [your credit card is correct](https://account.app.net/settings/payment/) and that your account hasn't been downgraded.

#### "Unknown grant type"

This often indicates a problem with the encoding of the request you're sending us. Please make sure that you haven't URL encoded the request body multiple times. Also please make sure you're sending your request with a Content-type of `application/x-www-form-urlencoded` not `application/json`.

## Making Authenticated API Requests

When making a call to one of our API resources, there are three ways to include authentication information.

> In all of these examples, `<YOUR ACCESS TOKEN>` is the user's access token, free of any JSON framing or query string parameters.

* Adding an Authorization header (**preferred**)

    Add the following header to your request:
    `Authorization: Bearer <YOUR ACCESS TOKEN>`
    where `<YOUR ACCESS TOKEN>` is the value of the user's access token.

    Here's an example:

    <%= curl_example(:post, "posts", :none, {
        :data => {"text" => "Test post"},
        :content_type => nil,
    }) %>

* Add `access_token` to query string

    <%= curl_example(:get, "posts/1?access_token=<YOUR ACCESS TOKEN>", :none, {:data => "text=Test post", :content_type => nil, :token => nil}) %>

* Add `access_token` to HTTP body. 

    > This method will only work with the `PUT`, `POST`, and `PATCH` methods. `GET` and `DELETE` do not accept an HTTP body.

    <%= curl_example(:post, "posts", :none, {
        :data => {"text" => "Test post", "access_token" => "<YOUR ACCESS TOKEN>"},
        :content_type => nil,
        :token => nil
    }) %>

## How can I authenticate between App.net apps?

We call this Identity Delegation. The detailed [Identity Delegation specification](identity-delegation/) has its own page.
