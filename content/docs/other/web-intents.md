---
title: "Web Intents"
---

# Web Intents

* TOC
{:toc}

Web intents are an easy way to integrate with App.net; you don't even need to use Javascript. Intents in their most basic form are just carefully constructed URLs. By clicking on an intent link, a user will be taken to a page on App.net with a prompt to carry out an action, such as creating a post. If the user is not logged in to App.net, she/he will first authenticate before being presented with the action dialog.

## The Post Intent

The post intent allows you to create a link that will present the user with a post creation box and any pre-filled text that you may have supplied.

The base URL for this intent is ```https://alpha.app.net/intent/post/```.

You may optionally prepopulate the post creation box by supplying a ```text``` query parameter to the URL.

For example, this URL ```https://alpha.app.net/intent/post/?text=@voidfiles+save+some+coffee+for+me``` will create a post that reads:

    @voidfiles save some coffee for me

At this point the end user will be able to edit and then submit the post.

## The Follow Intent

The follow intent is an easy way to link to a page on App.net that will present the user with an opportunity to follow a selected user.

The base URL for this intent is ```https://alpha.app.net/intent/follow/```.

You must include a user that is the intended target of the follow action. To do this include a ```user_id``` query parameter in the URL. The ```user_id``` can be a username prepended by a @, like @adn, or it can be the numeric user_id, like 136.

For example, this URL ```https://alpha.app.net/intent/follow/?user_id=136``` will show page where the user can choose to follow the user @adn:

## Javascript & Intents

While you don't need to write any Javascript to use intents, it does make for a nicer experience. If you want to, you can use Javascript to open the intents dialog in a popup window.

For example, the following Javascript will open a Post Intent in a popup. The popup should be at least 700 x 350 pixels.

~~~
window.open(
    'https://alpha.app.net/intent/post?text=@voidfiles+save+some+coffee+for+me',
    'adn_post',
    'width=750,height=350,left=100,top=100'
);
~~~