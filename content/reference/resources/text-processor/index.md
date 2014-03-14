---
title: "Text Processor"
---

# Text Processor

* TOC
{:toc}

## Process text

When a request is made to [create a Post](/reference/resources/post/lifecycle/#create-a-post) or [Message](/reference/resources/message/lifecycle/#create-a-message), or [update a User profile](/reference/resources/user/profile/#update-a-user) description, the provided body text is processed for [entities](/reference/meta/entities). You can use this endpoint to test how App.net will parse text for entities as well as render text as html. You can test specifying your own entities by sending a [complete JSON object](/reference/resources/post/lifecycle/#json-example) as documented under [Post creation](/reference/resources/post/lifecycle/#create-a-post). Calls to this endpoint will not create or update any objects in App.net.

<%= endpoint "POST", "text/process", "Any" %>

<%= post_params [
    ["text", "The raw text to process."]
]%>

#### Example

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