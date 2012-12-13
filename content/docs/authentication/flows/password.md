---
title: "Password Flow"
---

# Password Flow

This is referred to as the Resource Owner Password Credential flow in the OAuth 2.0 spec. However, in order to protect the integrity of `client_secret`s, we require the use of a separate token to be included with flows.

This flow is useful for obtaining an access token authorized for specific scopes when pushing the user into a browser-based flow is impractical for technical or user-experience reasons.

## Important notes

**Security of user accounts is the most important thing.** When in doubt, err on the side of securing user password information, rather than optimizing for user experience.

**Your application must be specifically approved to use this flow.** To obtain authorization, please email password-auth@app.net from your user account's email address and include your application's `client_id`, your username, and an explanation of your situation.

## Additional rules

> Some of these rules might limit what you can do with your app. Please do not attempt to circumvent them, or we will disable your application token. That may sound harsh, but it is of utmost importance that we protect the integrity of the service and the security of user accounts.

1. **NEVER** store user password information, no matter how securely. Users should be able to disable access to your application at any time by revoking authorization. Access tokens are designed not to expire unless users take explicit action, so there is no need to build in a mechanism to reauthenticate that would require storing passwords.
1. Do not send user password information over the network, except to the prescribed App.net OAuth endpoint.
1. **NEVER** log user password information, even debug logging to your app or device's console. It is too easy to accidentally leak password information this way.
1. These flows should only be used in cases where browser-based authentication is impractical. For one-off applications, shell scripts, please use the pre-generated access token available in the "Apps" section of App.net.
1. Users must have a way to see which scopes are being requested by an application. This can be behind a "more info" button, but must at least be exposed on the login screen, before users are required to enter their password information to coninue.
1. By default, **users will receive an email each time they authorize an application with this flow**, listing the name of the application, the scopes requested and the time that authorization was performed.
1. If an error is returned from the OAuth endpoint, it MUST be displayed to users verbatim.
1. If these rules are updated, application developers must make reasonable attempts to comply with new regulations wherever possible.

## Procedure

Once approved, it's pretty straightforward:

1. From your client, make a request to the token endpoint:

        POST https://alpha.app.net/oauth/access_token

    with URL-encoded POST body:

         client_id=[your client ID]
        &password_grant_secret=[your password grant secret, not your client secret]
        &grant_type=password
        &username=[user's email or username]
        &password=[user's password]
        &scope=[scopes separated by spaces]

    > Note: The use of `password_grant_secret` diverges from the OAuth 2.0 specificaion. `password_grant_secret` is a special token that we'll send you when your use of the password flow is approved.

1. If the authorization was successful, App.net will respond with a JSON-encoded token:

        {"access_token": "[user access token]"}

    You can use this access_token to make authenticated calls to the App.net API on behalf of a user.

1. If authentication failed or there was another error, App.net will respond with an error:

        {"error": "Authentication failed"}

    If the `error_text` key is present in this dictionary, you **MUST** show a modal dialog or equivalent containing this text. If possible, you should include value of the `error_title` key as a title in your dialog.
