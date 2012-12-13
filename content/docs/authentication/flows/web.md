# Web Flows 

## Server-side Flow

This is the easiest way to get an access token—we recommend it to most users of the API. If you're writing an app on a server using a language like  Ruby, Python, PHP, Java, etc. you should use this flow.

**You must keep your client_secret confidential**. That means that you may not include it in the source code or binary of an application that you ship to end-users, even in obscured form. 

1. Direct the user that you want to authenticate to this URL:
    
        https://account.app.net/oauth/authenticate
            ?client_id=[your client ID]
            &response_type=code
            &redirect_uri=[your redirect URI]
            &scope=[scopes separated by spaces]
        
    > To avoid cross-site scripting attacks, we also support the **state** parameter. If you include a state parameter, we will append it to the query parameters when redirecting the user to your **Redirection URI**.

    > To comply with Apple's App Store Guidelines, you can add the query string parameter `adnview=appstore` to hide all signup links on the authentication pages.

    We'll request that the user log in to App.net and show them a permissions dialog allowing them to choose whether to authorize your application.

1. If the user decides to authorize your application, they will be redirected to: `https://[your registered redirect URI]/?code=CODE`

    > If you included a query string in your redirect URI, the `code` parameter will be appended. Likewise, the scheme of your redirect URI will be respected, though we strongly recommend sending all traffic over HTTPS.

1. On your server, your application should then make the following request: `POST https://account.app.net/oauth/access_token`

    with URL-encoded POST body:

        client_id=[your client ID]
        &client_secret=[your client secret]
        &grant_type=authorization_code
        &redirect_uri=[your registered redirect URI]
        &code=[code received from redirect URI]

    > Note: we also accept the `client_id` and `client_secret` parameters via the Authorization header, as described in [section 2.3.1 of the spec](http://tools.ietf.org/html/draft-ietf-oauth-v2-31#section-2.3.1).

1. App.net will respond with a JSON-encoded token: `{"access_token": "[user access token]"}`

    You can use this access_token to make authenticated calls to the App.net API on behalf of a user.

## Client-side Flow

If you're building a client-side Javascript app or a mobile app that doesn't have an associated back-end server, you'll find that you need to take some special steps to keep your `client_secret` confidential.

1. Direct the user that you want to authenticate to this URL:
    
        https://account.app.net/oauth/authenticate
            ?client_id=[your client ID]
            &response_type=token
            &redirect_uri=[your redirect URI]
            &scope=[scopes separated by spaces]
    
    > To avoid cross-site scripting attacks, we also support the **state** parameter. If you include a state parameter, we will append it to the query parameters when redirecting the user to your **Redirection URI**.

    > To comply with Apple's App Store Guidelines, you can add the query string parameter `adnview=appstore` to hide all signup links on the authentication pages.

    We'll request that the user log in to App.net and show them a permissions dialog allowing them to choose whether to authorize your application.

1. If the user decides to authorize your application, they will be redirected to: `https://[your registered redirect URI]/#access_token=[user access token]`

    > If you included a query string in your redirect URI, the `code` parameter will be appended. Likewise, the scheme of your redirect URI will be respected, though we strongly recommend sending all traffic over HTTPS.

    The access_token will be appended to the URI in the fragment section, encoded as if it were a query string. Your client-side code should parse this for the access_token.

