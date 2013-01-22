---
title: "Text Processor"
---

# Text Processor

* TOC
{:toc}

## Process text

When a request is made to [create a Post](/docs/resources/post/lifecycle/#create-a-post) or [Message](/docs/resources/message/lifecycle/#create-a-message), or [update a User profile](/docs/resources/user/profile/#update-a-user) description, the provided body text is processed for [entities](/docs/meta/entities). You can use this endpoint to test how App.net will parse text for entities as well as render text as html. You can test specifying your own entities by sending a [complete JSON object](/docs/resources/post/lifecycle/#json-example) as documented under [Post creation](/docs/resources/post/lifecycle/#create-a-post). Calls to this endpoint will not create or update any objects in App.net.

<%= migration_warning ['response_envelope'] %>

<%= endpoint "POST", "text/process", "Any" %>

### Data

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>text</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The raw text to process</td>
        </tr>
    </tbody>
</table>

### Example

> POST https://alpha-api.app.net/stream/0/text/process
>
> DATA text=This+is+%23awesome+tell+%40voidfiles+about+http%3A%2F%2Fgoogle.com

~~~ js
{
    "data": {
        "entities": {
            "hashtags": [
                {
                    "len": 8,
                    "name": "awesome",
                    "pos": 8
                }
            ],
            "links": [
                {
                    "len": 17,
                    "pos": 39,
                    "text": "http://google.com",
                    "url": "http://google.com"
                }
            ],
            "mentions": [
                {
                    "id": "3",
                    "len": 10,
                    "name": "voidfiles",
                    "pos": 22
                }
            ]
        },
        "html": "<span itemscope=\"https://app.net/schemas/Post\">This is <span itemprop=\"hashtag\" data-hashtag-name=\"awesome\">#awesome</span> tell <span itemprop=\"mention\" data-mention-id=\"3\" data-mention-name=\"voidfiles\">@voidfiles</span> about <a href=\"http://google.com\">http://google.com</a></span>",
        "text": "This is #awesome tell @voidfiles about http://google.com"
    },
    "meta": {
        "code": 200
    }
}
~~~