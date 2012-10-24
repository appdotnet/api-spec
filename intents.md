# Web Intents

Web intents are an easy way to integrate with App.net you don't even need to use Javascript. Intents in there most basic form are just carefully constructed URL's. When the end user clicks on an intent link they will be taken to a page on App.net where they will be prompted to carryout an action like creating a post. If the user is not logged in App.net will authenticate the user before they are presented with the action dialog.

## The Post Intent

Our only intent right now is the Post Intent. It will allow you to create a link that will present the user with a post creation box, and any pre-filled text you may have passed.

The base URL for this intent is ```https://alpha.app.net/intent/post```.

If you add a ```text``` query parameter to the URL the text will then pre-populate the post create box.

For Example:

```https://alpha.app.net/intent/post?text=@voidfiles+save+some+coffee+for+me```

Will create a post that reads:

    @voidfiles save some coffee for me

At this point the end user will be able to edit the post and then submit the post.


## Javascript & Intents

While you don't need to write any Javascript to utilize intents it does make for a nicer experience. If you wanted to you could use Javascript to open the intents dialog in a popup window.

You can use the following Javascript to open an intent in a popup. The dialog should be at least 700 x 350 pixels.

```window.open('https://alpha.app.net/intent/post?text=@voidfiles+save+some+coffee+for+me', 'adn_post', 'width=750,height=350,left=100,top=100');```