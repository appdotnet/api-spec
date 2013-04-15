---
title: "Social Buttons"
---

# Social Buttons

* TOC
{:toc}

Use social buttons to let visitors to your website [share content](#share-on-appnet-button) and [follow you](#follow-me-on-appnet-button) on App.net.

Social buttons are meant to be an easy way to include a [social interaction](/docs/other/web-intents/) on any web page.

## How To Include A Button On Your Website

1. Copy an example of the button you want use to your website.
2. Modify the example until it works for your needs.
3. Include the Common CSS in your existing stylesheet, or inline before an App.net button.

## Buttons

### Share on App.net Button

The share on App.net button is an easy way to let visitors to your website share content directly to App.net.

#### HTML

You will need to replace ```{{ URL Encoded Message }}``` with a pre-composed URL Encoded Message of your choosing.

~~~html
<a class="adn-button" href="https://alpha.app.net/intent/post/?text={{ URL Encoded Message}}" onclick="window.open('https://alpha.app.net/intent/post/?text={{ URL Encoded Message }}', 'adn_post', 'width=750,height=350,left=100,top=100'); return false;">Share on App.net</a>
~~~

#### Example

Here is an example of a post button that fills in a message like "Check out the App.net Developer docs http://developers.app.net"

~~~html
<a class='adn-button' href="https://alpha.app.net/intent/post?text=Check%20out%20the%20App.net%20Developer%20docs%20http%3A%2F%2Fdevelopers.app.net" onclick="window.open('https://alpha.app.net/intent/post?text=Check%20out%20the%20App.net%20Developer%20docs%20http%3A%2F%2Fdevelopers.app.net', 'adn_post', 'width=750,height=350,left=100,top=100'); return false;">Share on App.net</a>
~~~

this is what that would look like:

<style>
    <%= render 'partials/buttons/button' %>
</style>

<a class='adn-button' href="https://alpha.app.net/intent/post?text=Check%20out%20the%20App.net%20docs%20http%3A%2F%2Fdevelopers.app.net" onclick="window.open('https://alpha.app.net/intent/post?text=Check%20out%20the%20App.net%20docs%20http%3A%2F%2Fdevelopers.app.net', 'adn_post', 'width=750,height=350,left=100,top=100'); return false;">Share on App.net</a>


### Follow Me on App.net Button

The follow me on App.net button let's visitors to your website easily follow you on App.net.

#### HTML

You will need to replace ```{{ USER_ID }}``` with either a number user id like, 136, or a username prepended with an @ like, @adn.

~~~html
<a class="adn-button" href="https://alpha.app.net/intent/follow/?user_id={{ USER_ID }}" onclick="window.open('https://alpha.app.net/intent/follow/?user_id={{ USER_ID }}', 'adn_follow', 'width=750,height=350,left=100,top=100'); return false;">Follow Me on App.net</a>
~~~

#### Example

Here is an example of a follow button that asks the user to follow the @adn account.

~~~html
<a class="adn-button" href="https://alpha.app.net/intent/follow/?user_id=@adn" onclick="window.open('https://alpha.app.net/intent/follow/?user_id=@adn', 'adn_follow', 'width=750,height=350,left=100,top=100'); return false;">Follow Me on App.net</a>
~~~

this is what that would look like:

<a class="adn-button" href="https://alpha.app.net/intent/follow/?user_id=@adn" onclick="window.open('https://alpha.app.net/intent/follow/?user_id=@adn', 'adn_follow', 'width=750,height=350,left=100,top=100'); return false;">Follow Me on App.net</a>


## Common CSS

In order to integrate an App.net social button into your website, you'll have to complete two steps. Step one, for all buttons, is to add a little bit of CSS into any pre-existing style sheets you have You also have the option of including the CSS inline with the button.

~~~css
<%= render 'partials/buttons/button' %>
~~~

