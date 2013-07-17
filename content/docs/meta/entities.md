---
title: "Entities"
---

# Entities

* TOC
{:toc}

Entities allow users and applications to provide rich text formatting for posts. They provide common formatting for mentions and hashtags but they also allow links to be embedded with anchor text which gives more context. Each entity type is a list with 0 or more entities of the same type.

Usually entities are extracted from the Post text by App.net's servers. We allow users to specify some entities at Post creation time. Please refer to the [user specified entities](#user-specified-entities) documentation for more information.

Ranges specified by entities may be adjacent, but may not overlap.

<div class="alert alert-info"><b>Note:</b> <code>pos</code> and <code>len</code> fields are given as UTF-32 code points. Many string implementations (in particular, Cocoa's NSString class and Javascript's strings) use UTF-16 or UCS-2 encoding internally, and thus the indices given will not map directly to UTF-16 code points if encoded with surrogate pairs, e.g., emoji characters.</div>

All of the following examples are about the following post:

> @berg FIRST post on this new site #newsocialnetwork

## Mentions
Bring another user's attention to your post. A mention starts with <code>@</code>.

~~~ js
"mentions": [{
    "name": "berg",
    "id": "2",
    "pos": 0,
    "len": 5,
}]
~~~

<table class='table table-striped'>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>name</code></td>
        <td>string</td>
        <td>The username being mentioned (doesn't include '@').</td>
    </tr>
    <tr>
        <td><code>id</code></td>
        <td>string</td>
        <td>The user id of the mentioned user.</td>
    </tr>
    <tr>
        <td><code>pos</code></td>
        <td>integer</td>
        <td>The 0 based index where this entity begins <code>text</code> (include @).</td>
    </tr>
    <tr>
        <td><code>len</code></td>
        <td>integer</td>
        <td>The length of the substring in <code>text</code> that represents this mention. Since <code>@</code> is included, <code>len</code> will be the length of the <code>name</code> + 1.</td>
    </tr>
</table>

## Hashtags
Tag a post about a specific subject. A hashtag starts with <code>#</code>.

~~~ js
"hashtags": [{
    "name": "newsocialnetwork",
    "pos": 34,
    "len": 17
}]
~~~

<table class='table table-striped'>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>name</code></td>
        <td>string</td>
        <td>The text of the hashtag (not including #).</td>
    </tr>
    <tr>
        <td><code>pos</code></td>
        <td>integer</td>
        <td>The 0 based index where this entity begins <code>text</code> (include #).</td>
    </tr>
    <tr>
        <td><code>len</code></td>
        <td>integer</td>
        <td>The length of the substring in <code>text</code> that represents this hashtag. Since <code>#</code> is included, <code>len</code> will be the length of the <code>name</code> + 1.</td>
    </tr>
</table>

## Links
Link to another website.

~~~ js
"links": [{
    "text": "this new site",
    "url": "https://join.app.net",
    "pos": 20,
    "len": 13,
    "amended_len": 28
}]
~~~

<table class='table table-striped'>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>text</code></td>
        <td>string</td>
        <td>The anchor text to be linked (could be a url).</td>
    </tr>
    <tr>
        <td><code>url</code></td>
        <td>string</td>
        <td>The destination url (only http or https accepted).</td>
    </tr>
    <tr>
        <td><code>pos</code></td>
        <td>integer</td>
        <td>The 0 based index where this entity begins <code>text</code>.</td>
    </tr>
    <tr>
        <td><code>len</code></td>
        <td>integer</td>
        <td>The length of the substring in <code>text</code> that represents this link.</td>
    </tr>
    <tr>
        <td><code>amended_len</code></td>
        <td>integer</td>
        <td>The length of the substring in <code>text</code> that represents this link including any <a href="#links-with-custom-anchor-text">phishing protection</a> that was inserted by App.net. This can be used to customize the display of the anti-phishing information we provide. If this link has no anti-phishing protection (because the domain of the <code>url</code> matches the <code>text</code>), then this field will be omitted.</td>
    </tr>
</table>

### URI Templates

Links can contain [URI templates](http://tools.ietf.org/html/rfc6570) that the server will process. This allows you to create a link to the object you are creating. For instance, Alpha uses this feature when you attach a photo to a post. Alpha adds a url to the end of the text that contains:

> photos.app.net/{post_id}/1

and the server replaces `{post_id}` with the id of the Post once it has been saved. By default, this processing happens on all links (both custom links and links extracted by the API). If you would like a link to not be processed, you can create the link as a [custom link](#links-with-custom-anchor-text) and include `"process_template": false` in the JSON for the link. The [Embedded Media Annotation](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.oembed.md) also supports URI templating for some of its attributes.

#### Replacement variables

Currently, the only variables for URI templates that we define are ones that could not be known when the link is being constructed. Additionally, if you specify a variable that is not listed below, we will pass that through instead of replacing it with nothing.

<table class='table table-striped'>
    <thead>
        <tr>
            <th>Value</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>message_id</td>
            <td>The id of the Message that this link is a part of.</td>
        </tr>
        <tr>
            <td>post_id</td>
            <td>The id of the Post that this link is a part of.</td>
        </tr>
    </tbody>
</table>

## User Specified Entities

Entities are automatically extracted from the post text but there are 2 cases where users and apps can set the entities on a post.

### Mentions in machine only posts

[Machine only Posts](/docs/resources/post/#machine-only-posts) don't have any text so entities cannot be extracted. We allow you to specify up to 10 users (by username or id) who can be mentioned in a machine only post. A machine only post with mentions is treated as a directed post to those users. You should not pass the ```pos``` or ```len``` keys in these mentions. Please see the example:

~~~ js
{
    "annotations": ...,
    "machine_only": true,
    "entities": {
        "mentions": [
            {
                "name": "mthurman"
            },
            {
                "id": "1"
            },
            ...
        ]
    }
}
~~~

### Links with custom anchor text

If you'd like to provide a link without including the entire URL in your post text or user description, you can specify a custom link at Post creation time or User update time. **If you include a list of links in your Post — even an empty list — App.net by default will not extract any links on the server.** Mentions and hashtags will still be extracted. If you want App.net to still extract links, you can pass the `parse_links: true` option to App.net. User provided links will take precedence over any links, mentions, or hashtags that App.net detects. However, a user provided link can not partially overlap with a mention or hashtag.

As an example, the following JSON will create a post to 2 links 1) the parsed link to App.net and 2) the user provided link to the App.net blog:

~~~js
{
    "text": "The official App.net blog is here",
    "entities": {
        "links": [
            {
                "pos": 29,
                "len": 4,
                "url": "http://blog.app.net"
            }
        ],
        "parse_links": true
    }
}
~~~

To prevent phishing, any link where the anchor text differs from the destination domain will be followed by the domain of the link target. These extra characters added by App.net to the `text` field will not count against the 256 character Post limit. In this case, App.net will also add the [`amended_len`](#links) field that includes the length of the complete entity and added anti-phishing text. This will make it easier for apps to customize how the anti-phishing protection looks in their apps. **When rendering links in your app, you must show users an indication of where they will end up.**

The ```text``` attribute of a link should be omitted as it will always be filled in from the post text.

The `url` value can contain [URI templates](#uri-templates) which the server will process.

#### Example

If you created the following post:

~~~ js
{
    "text": "I love this website!",
    "entities": {
        "links": [
            {
                "pos": 7,
                "len": 12,
                "url": "https://alpha.app.net"
            }
        ]
    }
}
~~~

App.net will store and return:

~~~ js
{
    "text": "I love this website [alpha.app.net]!",
    "entities": {
        "links": [
            {
                "pos": 7,
                "len": 12,
                "url": "https://alpha.app.net",
                "amended_len": 28
            }
        ]
    },
    ...
}
~~~
