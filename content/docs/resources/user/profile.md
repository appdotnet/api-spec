---
title: "User Profile"
---

# Profile

* TOC
{:toc}

## Update a User

Updates a specific user's profile details. You can update a user by PUTing an object that matches the [User schema](/docs/resources/user/) with an HTTP header of ```Content-Type: application/json```. You must provide values for each of the following keys: ```name```, ```locale```, ```timezone```, and ```description```. For the description, you must specify ```description.text``` as a child key. You can also specify [custom links](/docs/meta/entities/#user-specified-entities) for a user description. If you want to test how your text will be processed you can use the [text processor](/docs/resources/text-processor).

If you want to add or update a User's annotations, you may include the optional ```annotations``` key and pass in the annotations that are changing.

<%= general_params_note_for "user" %>

<%= migration_warning ['response_envelope'] %>

<%= endpoint "PUT", "users/me", "User", "update_profile" %>

#### Example

> PUT https://alpha-api.app.net/stream/0/users/me?include_user_annotations=1
>
> Content-Type: application/json
>
> DATA {"name": "Mark Thurman 2", "locale":"en", "timezone":"US/Central", "description":{"text": "new description"}, "annotations":[{"type": "net.app.core.directory.blog", "value": {"url": "http://mynewblog.com"}}]

~~~js
{
    "data": {
        "id": "1", // note this is a string
        "username": "mthurman",
        "name": "Mark Thurman 2",
        "description": {
           "text": "new description",
           "html": "new description",
           "entities": {}
        },
        "timezone": "US/Central",
        "locale": "en",
        "avatar_image": {
            "height": 512,
            "width": 512,
            "url": "https://example.com/avatar_image.jpg",
            "is_default": false
        },
        "cover_image": {
            "height": 118,
            "width": 320,
            "url": "https://example.com/cover_image.jpg",
            "is_default": false
        },
        "type": "human",
        "created_at": "2012-07-16T17:23:34Z",
        "counts": {
            "following": 100,
            "followers": 200,
            "posts": 24,
            "stars": 76
        },
        "annotations": [
            {
                "type": "net.app.core.directory.blog",
                "value": "http://mynewblog.com"
            }
        ]
    },
    "meta": {
        "code": 200
    }
}
~~~

## Retrieve a User's avatar image

Retrieve a User's avatar image. This endpoint does not require authentication, is not rate limited, and will return an HTTP 302 redirect to the user's current avatar image. It will include any [query string parameters](/docs/resources/user/#images) you pass to the endpoint.

<%= endpoint "GET", "users/[user_id]/avatar", "None" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/me/avatar
>
> 302 Location: https://example.com/avatar.jpg

## Update a User's avatar image

Replace a User's avatar image with the uploaded file. The uploaded image Will be cropped to square and must be smaller than 1 MB. The optimal size for this image is 200×200 pixels. The content type for this request must be ```multipart/form-data```.


<%= migration_warning ['response_envelope'] %>

<%= endpoint "POST", "users/me/avatar", "User", "update_profile" %>

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
            <td><code>avatar</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The MIME encoded image to replace the current user's image.</td>
        </tr>
    </tbody>
</table>

### Example

> POST https://alpha-api.app.net/stream/0/users/me/avatar
>
> Content-Type: multipart/form-data; boundary=----------------------------82481319dca6
>
> DATA [MIME encoded image]

~~~ js
{
    "data": {
        "id": "1", // note this is a string
        "username": "mthurman",
        "name": "Mark Thurman",
        "description": {
           "text": "Hi, I'm Mark Thurman and I'm teaching you about the @appdotnet Stream #API.",
           "html": "Hi, I'm Mark Thurman and I'm <a href=\"https://github.com/appdotnet/api_spec\" rel=\"nofollow\">teaching you</a> about the <span itemprop=\"mention\" data-mention-name=\"appdotnet\" data-mention-id=\"3\">@appdotnet</span> Stream #<span itemprop=\"hashtag\" data-hashtag-name=\"api\">API</span>.",
           "entities": {
               "mentions": [{
                   "name": "appdotnet",
                   "id": "3",
                   "pos": 52,
                   "len": 10
               }],
               "hashtags": [{
                   "name": "api",
                   "pos": 70,
                   "len": 4
               }],
               "links": [{
                   "text": "teaching you",
                   "url": "https://github.com/appdotnet/api-spec",
                   "pos": 29,
                   "len": 12
               }]
            }
        },
        "timezone": "US/Pacific",
        "locale": "en_US",
        "avatar_image": {
            "height": 512,
            "width": 512,
            "url": "https://example.com/new_avatar_image.jpg",
            "is_default": false
        },
        "cover_image": {
            "height": 118,
            "width": 320,
            "url": "https://example.com/cover_image.jpg",
            "is_default": false
        },
        "type": "human",
        "created_at": "2012-07-16T17:23:34Z",
        "counts": {
            "following": 100,
            "followers": 200,
            "posts": 24,
            "stars": 76
        },
    },
    "meta": {
        "code": 200
    }
}
~~~

## Retrieve a User's cover image

Retrieve a User's cover image. This endpoint does not require authentication, is not rate limited, and will return an HTTP 302 redirect to the user's current cover image. It will include any [query string parameters](/docs/resources/user/#images) you pass to the endpoint.

<%= endpoint "GET", "users/[user_id]/cover", "None" %>

<%= url_params [
  ["user_id","The user id. If the user id is <code>me</code> the current authenticated user will be used. You can also specify <code>@username</code> as a <code>user_id</code>."]
]%>

#### Example

> GET https://alpha-api.app.net/stream/0/users/me/cover
>
> 302 Location: https://example.com/cover.jpg

## Update a User's cover image

Replace a User's cover image with the uploaded file. The uploaded image must be at least 960px wide and less than 4 MB in size. The content type for this request must be ```multipart/form-data```.

<%= general_params_note_for "user" %>

<%= migration_warning ['response_envelope'] %>

<%= endpoint "POST", "users/me/cover", "User", "update_profile" %>

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
            <td><code>cover</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The MIME encoded image to replace the current user's image.</td>
        </tr>
    </tbody>
</table>

### Example

> POST https://alpha-api.app.net/stream/0/users/me/cover
>
> Content-Type: multipart/form-data; boundary=----------------------------82481319dca6
>
> DATA [MIME encoded image]

~~~ js
{
    "data": {
        "id": "1", // note this is a string
        "username": "mthurman",
        "name": "Mark Thurman",
        "description": {
           "text": "Hi, I'm Mark Thurman and I'm teaching you about the @appdotnet Stream #API.",
           "html": "Hi, I'm Mark Thurman and I'm <a href=\"https://github.com/appdotnet/api_spec\" rel=\"nofollow\">teaching you</a> about the <span itemprop=\"mention\" data-mention-name=\"appdotnet\" data-mention-id=\"3\">@appdotnet</span> Stream #<span itemprop=\"hashtag\" data-hashtag-name=\"api\">API</span>.",
           "entities": {
               "mentions": [{
                   "name": "appdotnet",
                   "id": "3",
                   "pos": 52,
                   "len": 10
               }],
               "hashtags": [{
                   "name": "api",
                   "pos": 70,
                   "len": 4
               }],
               "links": [{
                   "text": "teaching you",
                   "url": "https://github.com/appdotnet/api-spec",
                   "pos": 29,
                   "len": 12
               }]
            }
        },
        "timezone": "US/Pacific",
        "locale": "en_US",
        "avatar_image": {
            "height": 512,
            "width": 512,
            "url": "https://example.com/avatar_image.jpg",
            "is_default": false
        },
        "cover_image": {
            "height": 118,
            "width": 320,
            "url": "https://example.com/new_cover_image.jpg",
            "is_default": false
        },
        "type": "human",
        "created_at": "2012-07-16T17:23:34Z",
        "counts": {
            "following": 100,
            "followers": 200,
            "posts": 24,
            "stars": 76
        },
    },
    "meta": {
        "code": 200
    }
}
~~~
