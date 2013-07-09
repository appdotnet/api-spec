---
title: "Web Flow Integration Guide"
---

# Web Flow Integration Guide

Once you have decided which [web flow](/docs/authentication/flows/web/) is best for your app this guide will show you how to integrate Authorize with App.net into your web app. For your convince we have created a button that will make it easier for you. Not only will it help you create a consistent branding experience, but it will also help you sign up existing, and new users.

* TOC
{:toc}

## Authorize With App.net Button

The Authorize with App.net Button is the easiest way to let people sign into and authorize your web app with their App.net credentials. If they don't have an App.net account, this button will allow new users to create an account and then authorize your app.

### Implementation

To implement the button on your site, you must:

1. Build [Your authentication URL](/docs/authentication/flows/web/).
1. Replace the variables inside the brackets
1. Copy and paste the snippet below into your HTML where you want the button to show up


~~~html
<a href='[Your authentication URL]' class='adn-button' data-type='authorize_v2' data-width="145" data-height="22" >Authorize with App.net</a><script>(function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src='//d2zh9g63fcvyrq.cloudfront.net/adn.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'adn-button-js'));</script>
~~~

If you do everything correctly you should see a button like this:

![example button](/assets/images/button.png)

### Best Practices

We suggest that you put the following copy directly above or below the button:

    An App.net account is required to use [Your App Name]. You can create an account and sign in by clicking this button.