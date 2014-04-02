---
title: "Create an App"
---

# Getting Started With Development

To start accessing parts of the API that require authentication you will need an **access token**. The easiest way to create an access token is to register an app in your [account dashboard](https://account.app.net/settings/).

* TOC
{:toc}

## Creating an App

1. Start by visiting [account.app.net/settings/](https://account.app.net/settings/). Click on "[Your Apps](https://account.app.net/developer/apps/)" in the bottom left hand corner to go to Your Apps Dashboard.

    ![Your Account Dashboard](https://files.app.net/01q1LmOn.png)

2. Click "[Create An App](https://account.app.net/developer/app/create/)."

    ![Your Apps Dashboard](https://files.app.net/2z0jz2E7Z.png)

3. Fill in information about your app.

    All of the form details are required but you can always edit them later if you'd like to change anything. Give your app a unique name and provide a URL for users to find out more information. If it doesn't make sense for you to enter a website feel free to use your Alpha profile URL: `https://app.net/{YOUR USERNAME}`. This will let others know who is responsible for this app.

    The *Redirect URL* is used when your app [authenticates new users](/reference/authentication/). If you're not sure what to fill in, you can use `http://localhost:8000` (which we've already filled in for you).

    Once all the fields are filled in, click "Create."

    ![Create Your App](https://files.app.net/01qdir2Q.png)

4. Your app is now created. From here you can copy your *Client ID* and *Client Secret* into your code and use them. You can also add additional *Redirect URLs* for other development or production environments. To generate an access token, follow the instructions in the next section of this page.

    ![Your New App](https://files.app.net/01qb1llv.png)

## Generating an Access Token

There are a few ways to get an access token, but the easiest way to get an access token for personal use or experimentation is to generate one from your app detail page.

1. Visit [account.app.net/developer/apps/](https://account.app.net/developer/apps/). Find the app you would like to generate an access token for and click on the name.

    ![Your Apps Dashboard](https://files.app.net/01qlWgpd.png)

2. Click "Generate a user token for yourself"

    ![Generate a token](https://files.app.net/0q1t3Zt2.png)

3. Select the scopes for this token.

    To find out more about scopes your can [read the scope docs](/reference/authentication/#scopes). If you have previously generated a token, some of these boxes may already be checked.

    Once you have determined which scopes you will need select them in the form and then click "Generate."

    ![Scope Selection Screen](https://files.app.net/01qv_Geq.png)

4. You now have a user access token for your app. You can copy that into your code and use it with a [client library](/docs/libraries/) or directly from curl.

    <div class="alert alert-error alert-block">
        <b>Remember</b>: An access token is just like a password. It will allow applications to interact with the API on your behalf. So, keep it secret.
    </div>

    ![Your new access token](https://files.app.net/01lz9mQt.png)

## Launching your app

Before you learn more about the API and start building your app, we want to make sure you know about some other opportunities for when you're ready to launch your app.

### Directory

We want to make sure App.net users can find all the great apps that get created so we created the [App.net Directory](https://directory.app.net/). To include your app in the directory, you must [**register your app with us**](https://alpha.app.net/developer/apps/). For more information about how the directory, please see the [Directory Requirements](https://mml.desk.com/customer/portal/articles/779115-what-are-the-criteria-for-being-accepted-into-the-app-net-directory-).


### Developer Incentive Program

To financially reward the development of great apps, [we announced the Developer Incentive Program](http://blog.app.net/2012/09/27/announcing-the-app-net-developer-incentive-program/). If you'd like to include your app you must [**register for the Developer Incentive Program**](https://alpha.app.net/developer/enrollment/).

## What's Next?

Now that you have an access token you can use it to access authenticated parts of the API.

You could:

* [Send a broadcast](/docs/guides/send-a-broadcast/)
* [Create a post](/docs/guides/create-a-post/)

Or, you could build something completely new. We always love to see new apps.
