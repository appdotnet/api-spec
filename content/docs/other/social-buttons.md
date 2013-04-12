---
title: "Social Buttons"
---

# Social Buttons

* TOC
{:toc}

Social buttons are meant to be an easy way to include a [web intent](/docs/other/web-intents/) on any web page.

## The Share on App.net Button

The share buttons hooks up to our [Post Intent](/docs/other/web-intents/#the-post-intent). It's an easy way for publishers to pre-compose a message for user. The user will still have an option to edit any pre-composed message.

## The Follow Me on App.net Button

the follow button hooks up with our [Follow Intent](/docs/other/web-intents/#the-follow-intent). It's an easy way to link to a page on app.net where a user can then follow you.


### Including a button on your site.

There are two parts to including this on button your site. The first part is a small bit of CSS that can be included in any pre-exsisting styles you have, or it ca be including inline with the button. Here is a template you can use to build a share on App.net button.

#### The CSS Portion

~~~css
<%= render 'partials/buttons/button' %>
~~~

#### The HTML Portion


##### Share on App.net Button

You will need to replace ```{{ URL Encoded Message }}``` with a pre-composed URL Encoded Message of your choosing.

~~~html
<a class="adn-button" href="https://alpha.app.net/intent/post/?text={{ URL Encoded Message}}" onclick="window.open('https://alpha.app.net/intent/post/?text={{ URL Encoded Message }}', 'adn_post', 'width=750,height=350,left=100,top=100'); return false;">Share on App.net</a>
~~~

##### Follow Me on App.net Button

You will need to replace ```{{ USER_ID }}``` with either a number user id like, 136, or a username prepended with an @ like, @adn.

~~~html
<a class="adn-button" href="https://alpha.app.net/intent/follow/?user_id={{ USER_ID }}" onclick="window.open('https://alpha.app.net/intent/follow/?user_id={{ USER_ID }}', 'adn_follow', 'width=750,height=350,left=100,top=100'); return false;">Follow Me on App.net</a>
~~~

### Examples

#### Post Button Example
Here is an example of a post button that fills in a message like "Check out the App.net docs http://developers.app.net"

<style>
    <%= render 'partials/buttons/button' %>
</style>

<a class='adn-button' href="https://alpha.app.net/intent/post?text=Check%20out%20the%20App.net%20docs%20http%3A%2F%2Fdevelopers.app.net" onclick="window.open('https://alpha.app.net/intent/post?text=Check%20out%20the%20App.net%20docs%20http%3A%2F%2Fdevelopers.app.net', 'adn_post', 'width=750,height=350,left=100,top=100'); return false;">Share on App.net</a>


~~~html
<a class='adn-button' href="https://alpha.app.net/intent/post?text=Check%20out%20the%20App.net%20docs%20http%3A%2F%2Fdevelopers.app.net" onclick="window.open('https://alpha.app.net/intent/post?text=Check%20out%20the%20App.net%20docs%20http%3A%2F%2Fdevelopers.app.net', 'adn_post', 'width=750,height=350,left=100,top=100'); return false;">Share on App.net</a>
~~~

#### Follow Button Example

Here is an example of a follow button that asks the user to follow the @adn account.


<a class="adn-button" href="https://alpha.app.net/intent/follow/?user_id=136" onclick="window.open('https://alpha.app.net/intent/follow/?user_id=136', 'adn_follow', 'width=750,height=350,left=100,top=100'); return false;">Follow Me on App.net</a>


~~~html
<a class="adn-button" href="https://alpha.app.net/intent/follow/?user_id=136" onclick="window.open('https://alpha.app.net/intent/follow/?user_id=136', 'adn_follow', 'width=750,height=350,left=100,top=100'); return false;">Follow Me on App.net</a>
~~~

