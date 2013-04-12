---
title: "Social Buttons"
---

# Social Buttons

* TOC
{:toc}

Social buttons are meant to be an easy way to include a [web intent](/docs/other/web-intents/) on any web page.

## The Share on App.net Button

The share buttons hooks up to our [Post Intent](/docs/other/web-intents/#the-post-intent). It's an easy way for publishers to pre-compose a message for user. The user will still have an option to edit any pre-composed message.

### Including the button on your site.

There are two parts to including this on button your site. The first part is a small bit of CSS that can be included in any pre-exsisting styles you have, or it ca be including inline with the button. Here is a template you can use to build a share on App.net button.

You will need to replace {{ URL Encoded Message }} with a pre-composed URL Encoded Message of your choosing.

#### The CSS Portion

~~~css
a.adn-button {
    background-color: #C75244;
    color: #FFFFFF;
    text-decoration: none;
    display: inline-block;
    font-size: 22px;
    line-height: 22px;
    padding: 10px 20px;
    border-radius: 22px;
    -webkit-border-radius: 22px;
    -moz-border-radius: 22px;
}
a.adn-button:visited {
    color: #FFFFFF;
}

a.adn-button:hover {
    background-color: #CA5D4E;
}
~~~

#### The HTML Portion

~~~html
<a class="adn-button" href="https://alpha.app.net/intent/post?text={{ URL Encoded Message}}" onclick="window.open('https://alpha.app.net/intent/post?text={{ URL Encoded Message }}', 'adn_post', 'width=750,height=350,left=100,top=100'); return false;">Share on App.net</a>
~~~

### An Example

Here is an example of a button that fills in a message like "Check out the App.net docs http://developers.app.net"

<style>
    a.adn-button {
        background-color: #C75244;
        color: #FFFFFF;
        text-decoration: none;
        display: inline-block;
        font-size: 22px;
        line-height: 22px;
        padding: 10px 20px;
        border-radius: 22px;
        -webkit-border-radius: 22px;
        -moz-border-radius: 22px;
    }
    a.adn-button:visited {
        color: #FFFFFF;
    }
    a.adn-button:hover {
        background-color: #CA5D4E;
        text-decoration: none;
    }
</style>
<a class='adn-button' href="https://alpha.app.net/intent/post?text=Check%20out%20the%20App.net%20docs%20http%3A%2F%2Fdevelopers.app.net" onclick="window.open('https://alpha.app.net/intent/post?text=Check%20out%20the%20App.net%20docs%20http%3A%2F%2Fdevelopers.app.net', 'adn_post', 'width=750,height=350,left=100,top=100'); return false;">Share on App.net</a>

## The Follow Me on App.net Button

the follow button hooks up with our Follow Intent ()