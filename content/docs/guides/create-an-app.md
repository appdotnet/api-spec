---
title: "Create an App"
---

# Getting Started With Development

To start accessing parts of the API that require authentication you will need an **access token**. The easiest way to create an access token is to register an app in your [account dashboard](https://account.app.net/settings/).

* TOC
{:toc}

## Creating an App

Start by visiting [account.app.net/settings/](https://account.app.net/settings/).

![Your Account Dashboard](https://files.app.net/01q1LmOn.png)

Clicking on [Your Apps](https://account.app.net/developer/apps/) in the bottom left hand corner. Will take you to your app dashboard.

![Your Apps Dashboard](https://files.app.net/01qsFuCH.png)

This is what you will see if you haven't created any apps. To start the process of registering your app click on [Create one here](https://account.app.net/developer/app/create/).

Next, you will see the App Create page.

![Create Your App](https://files.app.net/01qdir2Q.png)

You will be able to change all of this later, but start by giving your app a name that is unique to you, or your organization.

Enter a website that is most closely related to this app. If it doesn't make sense for you to enter a website feel free to enter in your Alpha profile URL. (https://app.net/<YOUR USERNAME>). This will let others know who is responsible for this app.

The **Redirect URL** is prefilled with http://localhost:8000 as a convenience for local development. The Redirect URL will be used when you [authenticate your app](/reference/authentication/) later.

When you are satisfied with the information you have entered click create.

You will see something like this once you have created your app.

![Your New App](https://files.app.net/01qb1llv.png)

As you can see the **client secret** is blurred, but this is roughly what your app will look like once it has been created. 

From here you could add additional callback URL's for different environments. As well as update your apps information at any time.

You can also generate your self an access token.

## Generating an Access Token

There are a few ways to get an access token, but the easiest way to get an access token for personal use or experimentation is to generate one from your app detail page.

To see a list of your current apps visit [account.app.net/developer/apps/](https://account.app.net/developer/apps/).

![Your Apps Dashboard](https://files.app.net/01qlWgpd.png)

Find the app you would like to generate an access token for and click on the name. You should now see your app detail page.

![Generate a token](https://files.app.net/0q1t3Zt2.png)

From this screen, if you look at the second block you will see a link: 'Generate a user token for yourself'. Click on that link, and you will see a page like this.

![Scope Selection Screen](https://files.app.net/01qv_Geq.png)

This is the scope authorization screen. If you have previously generated a token, some of these boxes may already be checked.

To find out more about scopes your can [read the scope docs](/reference/authentication/#scopes).

Once you have determined which scopes you will need select them in the form and then click generate.

![Your new access token](https://files.app.net/01lz9mQt.png)

Now you should see an access token in a textbox, then you can copy and use in a client library, or even from curl.

<div class="alert alert-error alert-block">
    <b>Remember</b>: An access token is just like a password. It will allow applications to interact with the API on your behalf. So, keep it secret.
</div>

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
