---
title: "Password Flow"
---

# Password Flow

* TOC
{:toc}

This flow is useful for obtaining an access token authorized for specific scopes when pushing the user into a browser-based flow is impractical for technical or user-experience reasons.

This is referred to as the Resource Owner Password Credential flow in the OAuth 2.0 spec. However, in order to protect the integrity of `client_secret`s, we require the use of a separate token to be included with flows.

## Obtaining approval to use the password flow

**Your application must be specifically approved to use this flow.** To obtain authorization, please email [password-auth@app.net](mailto:password-auth@app.net) from the email address associated with your developer account and include your application's `client_id`, your username, and an explanation of your situation (e.g. "I am building a native app for iOS").

## Rules

**Security of user accounts is the most important thing.** When in doubt, err on the side of securing user password information, rather than optimizing for user experience.

> Some of these rules might limit what you can do with your app. Please do not attempt to circumvent them, or we will disable your application token. That may sound harsh, but it is of utmost importance that we protect the integrity of the service and the security of user accounts.

> These flows should only be used in cases where browser-based authentication is impractical. For one-off applications, shell scripts, etc., please generate an access token for your app via [My Apps](https://account.app.net/developer/apps/).

1. **NEVER** store user password information, no matter how securely. Users should be able to disable access to your application at any time by revoking authorization. Access tokens are designed not to expire unless users take explicit action, so there is no need to build in a mechanism to reauthenticate that would require storing passwords.
1. **NEVER** send user password information over the network, except to the prescribed App.net OAuth endpoint.
1. **NEVER** log user password information, even debug logging to your app or device's console. It is too easy to accidentally leak password information this way.
1. Users **MUST** have a way to see which scopes are being requested by an application. This can be behind a "more info" button, but must at least be exposed on the login screen, before users are required to enter their password information to continue.
1. If an error is returned from the OAuth endpoint, it **MUST** be displayed to users verbatim.
1. If these rules are updated, application developers must make reasonable attempts to comply with new regulations wherever possible.

## Procedure

> By default **users will receive an email each time they authorize an application with this flow** listing the name of the application, the scopes requested and the time that authorization was performed.

Once you have been approved, using the password flow is pretty straightforward:

1. From your client, make a request to the token endpoint:

        POST https://account.app.net/oauth/access_token

    with URL-encoded POST body:

         client_id=[your client ID]
        &password_grant_secret=[your password grant secret, not your client secret]
        &grant_type=password
        &username=[user's email or username]
        &password=[user's password]
        &scope=[scopes separated by spaces]

    > The use of `password_grant_secret` diverges from the OAuth 2.0 specificaion. `password_grant_secret` is a special token that we'll send you when your use of the password flow is approved.

    > **You can require app-specific passwords** by providing a `require_app_specific_password=1` URL parameter. **[Two-Factor Auth users](http://blog.app.net/2013/03/13/added-security-for-your-app-net-account/) must use app-specific passwords** irrespective of this parameter. We strongly encourage the use of app-specific passwords by all users as they significantly increase account security.

1. If the authorization was successful, App.net will respond with a JSON-encoded token:

        {"access_token": "[user access token]"}

    You can use this access_token to make authenticated calls to the App.net API on behalf of a user.

1. If authentication failed or there was another error, App.net will respond with an error:

        {"error": "Authentication failed"}

    If the `error_text` key is present in this dictionary, you **MUST** show a modal dialog or equivalent containing this text. If possible, you should include value of the `error_title` key as a title in your dialog.
