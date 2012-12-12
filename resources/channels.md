# Channels

To avoid leaking data about the existence of channels you can't access, the following endpoints will return 403 Forbidden instead of 404 Not Found.

## Get current user's subscribed channels

Retrieve an "inbox" of the channels the user is currently subscribed to. This stream is ordered like an inbox with the stream containing the most recent post first.

This endpoint responds to [pagination parameters](/appdotnet/api-spec/blob/master/responses.md#pagination-metadata"). Remember that the ```min_id```/```max_id``` do not have to correspond to the ids in the ```data``` list.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/channels
```js
{
    "data": [
        {
            "has_unread": true,
            "id": "1",
            "owner": {
                ...
            },
            "readers": {
                "any_user": false,
                "immutable": true,
                "public": false,
                "user_ids": [],
                "you": true
            },
            "type": "net.app.core.pm",
            "writers": {
                "any_user": false,
                "immutable": true,
                "public": false,
                "user_ids": [
                    "1",
                ],
                "you": true
            },
            "you_can_edit": false,
            "you_subscribed": true
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": 146,
        "min_id": 123,
        "more": true
    }
}
```

## Create a Channel

Create a new <a href="/appdotnet/api-spec/blob/master/objects.md#channel">Channel</a>.

Send a JSON document that matches the  <a href="/appdotnet/api-spec/blob/master/objects.md#channel">channel schema</a> with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```readers```, ```writers```, ```annotations```, and ```type```. The ```type``` field controls how the ```readers``` and ```writers``` ACLs are validated.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels

### Data

None.

### Example

> POST https://alpha-api.app.net/stream/0/channels
>
> Content-Type: application/json
> 
> DATA {"type": "net.app.core.pm", "writers": {"user_ids": ["@berg", 1]}}
```js
{
    "data": {
        "has_unread": false,
        "id": "36",
        "owner": {
            ...
        },
        "readers": {
            "any_user": false,
            "immutable": true,
            "public": false,
            "user_ids": [],
            "you": true
        },
        "type": "net.app.core.pm",
        "writers": {
            "any_user": false,
            "immutable": true,
            "public": false,
            "user_ids": [
                "1",
                "2"
            ],
            "you": true
        },
        "you_can_edit": true,
        "you_subscribed": true
    },
    "meta": {
        "code": 200
    }
}
```

## Retrieve a Channel

Retrieve a Channel.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]

### Parameters

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
            <td><code>channel_id</code></td>
            <td>Required</td>
            <td>int</td>
            <td>The id of the Channel to retrieve</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/channels/1
```js
{
    "data": {
        "has_unread": false,
        "id": "1",
        "owner": {
            ...
        },
        "readers": {
            "any_user": false,
            "immutable": true,
            "public": false,
            "user_ids": [],
            "you": true
        },
        "type": "com.example",
        "writers": {
            "any_user": false,
            "immutable": false,
            "public": false,
            "user_ids": [
                "1"
            ],
            "you": true
        },
        "you_can_edit": true,
        "you_subscribed": true
    },
    "meta": {
        "code": 200
    }
}
```

## Update a Channel

Updates a specific <a href="/appdotnet/api-spec/blob/master/objects.md#filter">Channel</a> object. You can update a channel by PUTing an object that matches the [channel schema](/appdotnet/api-spec/blob/master/objects.md#channel) with an HTTP header of ```Content-Type: application/json```. The only keys that can be updated are ```annotations```, ```readers```, and ```writers``` (and the ACLs can only be updated if ```immutable=false```). The ```you_can_edit``` property tells you if you are allowed to update a channel. Currently, only the Channel owner can edit a channel.

If you want to add or update a Channel's annotations, you may include the optional ```annotations``` key and pass in the annotations that are changing.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]

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
            <td><code>channel_id</code></td>
            <td>Required</td>
            <td>int</td>
            <td>The id of the Channel to update</td>
        </tr>
    </tbody>
</table>

### Example

> PUT https://alpha-api.app.net/stream/0/channels/1
>
> Content-Type: application/json
> 
> DATA {"readers": {"public": true}}
```js
{
    "data": {
        "has_unread": false,
        "id": "1",
        "owner": {
            ...
        },
        "readers": {
            "any_user": false,
            "immutable": false,
            "public": true,
            "user_ids": [],
            "you": true
        },
        "type": "com.example",
        "writers": {
            "any_user": false,
            "immutable": false,
            "public": false,
            "user_ids": [
                "1"
            ],
            "you": true
        },
        "you_can_edit": true,
        "you_subscribed": true
    },
    "meta": {
        "code": 200
    }
}
```

## Subscribe to a Channel

Subscribe to a Channel. This adds it to your [Channel stream](#get-current-users-subscribed-channels).

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribe

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
            <td><code>channel_id</code></td>
            <td>Required</td>
            <td>int</td>
            <td>The id of the Channel to update</td>
        </tr>
    </tbody>
</table>

### Example

> POST https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribe
```js
{
    "data": {
        "has_unread": false,
        "id": "1",
        "owner": {
            ...
        },
        "readers": {
            "any_user": false,
            "immutable": false,
            "public": false,
            "user_ids": [],
            "you": true
        },
        "type": "com.example",
        "writers": {
            "any_user": false,
            "immutable": false,
            "public": false,
            "user_ids": [
                "1"
            ],
            "you": true
        },
        "you_can_edit": true,
        "you_subscribed": true
    },
    "meta": {
        "code": 200
    }
}
```

## Unsubscribe from a Channel

Unsubscribe from a Channel. This removes it from your [Channel stream](#get-current-users-subscribed-channels).

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribe

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
            <td><code>channel_id</code></td>
            <td>Required</td>
            <td>int</td>
            <td>The id of the Channel to update</td>
        </tr>
    </tbody>
</table>

### Example

> DELETE https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribe
```js
{
    "data": {
        "has_unread": false,
        "id": "1",
        "owner": {
            ...
        },
        "readers": {
            "any_user": false,
            "immutable": false,
            "public": false,
            "user_ids": [],
            "you": true
        },
        "type": "com.example",
        "writers": {
            "any_user": false,
            "immutable": false,
            "public": false,
            "user_ids": [
                "1"
            ],
            "you": true
        },
        "you_can_edit": true,
        "you_subscribed": false
    },
    "meta": {
        "code": 200
    }
}
```

## Retrieve users subscribed to a Channel

Retrieve the users who are subscribed to a Channel.

This endpoint responds to [pagination parameters](/appdotnet/api-spec/blob/master/responses.md#pagination-metadata"). Remember that the ```min_id```/```max_id``` do not have to correspond to the ids in the ```data``` list.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribers

### Parameters

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
            <td><code>channel_id</code></td>
            <td>Required</td>
            <td>int</td>
            <td>The id of the Channel to update</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/channels/1/subscribers
```js
{
    "data": [
        {
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
                "url": "https://example.com/avatar_image.jpg"
            },
            "cover_image": {
                "height": 118,
                "width": 320,
                "url": "https://example.com/cover_image.jpg"
            },
            "type": "human",
            "created_at": "2012-07-16T17:23:34Z",
            "counts": {
                "following": 100,
                "followers": 200,
                "posts": 24,
                "stars": 76
            },
            "follows_you": false,
            "you_follow": true,
            "you_muted": false,
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": 82,
        "min_id": 54,
        "more": true
    }
}
```

## Retrieve user ids subscribed to a Channel

Retrieve all the user ids who are subscribed to a Channel.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/subscribers/ids

### Parameters

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
            <td><code>channel_id</code></td>
            <td>Required</td>
            <td>int</td>
            <td>The id of the Channel to update</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/channels/1/subscribers
```js
{
    "data": [
        "1",
        ...
    ],
    "meta": {
        "code": 200,
    }
}
```
