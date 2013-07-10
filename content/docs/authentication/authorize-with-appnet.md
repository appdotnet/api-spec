---
title: "Web Flow Integration Guide"
---

# Web Flow Integration Guide

Now that you've identified which [web flow](/docs/authentication/flows/web/) to use with your app, it's time to expose this to end users.

* TOC
{:toc}

## Authorize With App.net Button

The easiest way to integrate a web flow into your app is through an "Authorize with App.net" Button, which allows current App.net users to enjoy the ease of authorizing your app in two clicks. Less means more, as they'll be able to start using your app even faster.

As an added benefit, this button will also allow new users to sign up for a free account and then authorize your app.

Why you should implement this button:

1. It's easy: Add this button to your site in seconds.
1. It's beautiful: it looks good and potential users will recognize the App.net branding.
1. It's useful: One button helps your app get new and existing App.net users.

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