---
title: "Web Intents"
---

# Web Intents

* TOC
{:toc}

Web intents are an easy way to integrate with App.net; you don't even need to use Javascript. Intents in their most basic form are just carefully constructed URLs. By clicking on an intent link, a user will be taken to a page on App.net with a prompt to carry out an action, such as creating a post. If the user is not logged in to App.net, she/he will first authenticate before being presented with the action dialog.


<div class="alert alert-info alert-block">
    <p><strong>Note:</strong> If you just want a simple follow or share button you can use <a href='http://app.net/about/buttons/'>button builder</a> instead. We've also open sourced the buttons so that you could host them your self. Checkout the <a href="https://github.com/appdotnet/piha">github repo</a> for more information on how to do that.</p>
</div>

## The Post Intent

The post intent allows you to create a link that will present the user with a post creation box and any pre-filled text that you may have supplied.

The base URL for this intent is ```https://alpha.app.net/intent/post/```.

You may optionally prepopulate the post creation box by supplying a ```text``` query parameter to the URL.

For example, this URL ```https://alpha.app.net/intent/post/?text=%40adn%20When%20is%20the%20next%20meetup%3F``` will create a post that reads:

    @adn When is the next meetup?

At this point the end user will be able to edit and then submit the post.

## The Follow Intent

The follow intent is an easy way to link to a page on App.net that will present the user with an opportunity to follow a selected user.

The base URL for this intent is ```https://alpha.app.net/intent/follow/```.

You must include a user that is the intended target of the follow action. To do this include a ```user_id``` query parameter in the URL. The ```user_id``` can be a username prepended by a @, like @adn, or it can be the numeric user_id, like 136.

For example, this URL ```https://alpha.app.net/intent/follow/?user_id=136``` will show page where the user can choose to follow the user @adn.

## Using intents with buttons

You can