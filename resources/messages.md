# Messages

To avoid leaking data about the existence of channels and messages you can't access, the following endpoints will return 403 Forbidden instead of 404 Not Found.

## Retrieve the Messages in a Channel

Retrieve a stream of the Messages in a channel. This endpoint responds to the [General Post Parameters](https://github.com/appdotnet/api-spec/blob/master/resources/posts.md#general-parameters) also.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://api.app.net/stream/0/channels/[channel_id]/messages

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
            <td>The id of the Channel who's messages you want to see</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://api.app.net/stream/0/channels/1/messages
```js
{
    "data": [
        {
            "channel_id": "1",
            "created_at": "2012-12-11T00:31:49Z",
            "entities": {
                "hashtags": [],
                "links": [],
                "mentions": []
            },
            "html": "<span itemscope=\"https://app.net/schemas/Post\">Hello channel!</span>",
            "id": "103",
            "machine_only": false,
            "num_replies": 0,
            "source": {
                "client_id": "UxUWrSdVLyCaShN62xZR5tknGvAxK93P",
                "link": "https://app.net",
                "name": "Test app"
            },
            "text": "Hello channel!",
            "thread_id": "103",
            "user": {
                ...
            }
        },
        ...
    ],
    "meta": {
        "code": 200,
        "marker": {
            "name": "channel:1"
        },
        "max_id": 103,
        "min_id": 95,
        "more": true
    }
}
```

## Create a Message

Create a <a href="/appdotnet/api-spec/blob/master/objects.md#message">Message</a> in the specified Channel.

Send a JSON document that matches the  <a href="/appdotnet/api-spec/blob/master/objects.md#message">message schema</a> with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```text```, ```reply_to```, ```annotations```, ```entities```, and ```machine_only```.

If you would like to specify your own entities, please refer to the [user specified entites](/appdotnet/api-spec/blob/master/objects.md#user-specified-entities) documentation, otherwise we will parse out links, hashtags, and mentions from the ```text``` field.

To create private group messages corresponding to the ```net.app.core.pm``` type, you can specify the special ```channel_id``` of ```auto```. With this parameter, the server will look for an extra field in the provided Message object called ```destinations``` which is a list of user_ids to send this message to. If a private message channel already exists between this group of users, that channel_id will be reused. Otherwise, a new channel will be created and the users specified in the ```destinations``` list will be able to write to that channel. Note that the ```destinations``` value may include user_ids in the form of @username or the integer id.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/messages

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
            <td>The id of the Channel who's messages you want to see or <code>auto</code> to find or create a new private message channel.</td>
        </tr>
    </tbody>
</table>

### Example

> POST https://alpha-api.app.net/stream/0/channels/1/messages
>
> Content-Type: application/json
> 
> DATA {"text": "Hello channel!"}
```js
{
    "data": {
        "channel_id": "1",
        "created_at": "2012-12-11T00:31:49Z",
        "entities": {
            "hashtags": [],
            "links": [],
            "mentions": []
        },
        "html": "<span itemscope=\"https://app.net/schemas/Post\">Hello channel!</span>",
        "id": "103",
        "machine_only": false,
        "num_replies": 0,
        "source": {
            "client_id": "UxUWrSdVLyCaShN62xZR5tknGvAxK93P",
            "link": "https://app.net",
            "name": "Test app"
        },
        "text": "Hello channel!",
        "thread_id": "103",
        "user": {
            ...
        }
    },
    "meta": {
        "code": 200,
    }
}
```

### Auto-channel example
> POST https://alpha-api.app.net/stream/0/channels/auto/messages
>
> Content-Type: application/json
> 
> DATA {"text": "Hello brand new channel!", "destinations": ["@berg", 1]}
```js
{
    "data": {
        "channel_id": "2",
        "created_at": "2012-12-11T00:31:49Z",
        "entities": {
            "hashtags": [],
            "links": [],
            "mentions": []
        },
        "html": "<span itemscope=\"https://app.net/schemas/Post\">Hello channel!</span>",
        "id": "105",
        "machine_only": false,
        "num_replies": 0,
        "source": {
            "client_id": "UxUWrSdVLyCaShN62xZR5tknGvAxK93P",
            "link": "https://app.net",
            "name": "Test app"
        },
        "text": "Hello brand new channel!",
        "thread_id": "105",
        "user": {
            ...
        }
    },
    "meta": {
        "code": 200,
    }
}
```

## Retrieve a Message

Retrieve a message.

*Note: you can always retrieve a message you created even if you are no longer able to view the rest of the Channel anymore.*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/messages/[message_id]

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
            <td>The id of the Channel this message belongs to</td>
        </tr>
        <tr>
            <td><code>message_id</code></td>
            <td>Required</td>
            <td>int</td>
            <td>The id of the Message you'd like to retrieve</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/channels/1/messages/103
```js
{
    "data": {
        "channel_id": "1",
        "created_at": "2012-12-11T00:31:49Z",
        "entities": {
            "hashtags": [],
            "links": [],
            "mentions": []
        },
        "html": "<span itemscope=\"https://app.net/schemas/Post\">Hello channel!</span>",
        "id": "103",
        "machine_only": false,
        "num_replies": 0,
        "source": {
            "client_id": "UxUWrSdVLyCaShN62xZR5tknGvAxK93P",
            "link": "https://app.net",
            "name": "Test app"
        },
        "text": "Hello channel!",
        "thread_id": "103",
        "user": {
            ...
        }
    },
    "meta": {
        "code": 200,
    }
}
```

## Delete a Message

Delete a message. The current user must be the same user who created the Message. It returns the deleted Message on success.

*Note: you can always delete a message you created even if you are no longer able to view the rest of the Channel anymore.*

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/appdotnet/api-spec/blob/master/auth.md#authenticated-api-requests).*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/channels/[channel_id]/messages/[message_id]

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
            <td>The id of the Channel this message belongs to</td>
        </tr>
        <tr>
            <td><code>message_id</code></td>
            <td>Required</td>
            <td>int</td>
            <td>The id of the Message you'd like to delete</td>
        </tr>
    </tbody>
</table>

### Example

> DELETE https://alpha-api.app.net/stream/0/channels/1/messages/103
```js
{
    "data": {
        "channel_id": "1",
        "created_at": "2012-12-11T00:31:49Z",
        "entities": {
            "hashtags": [],
            "links": [],
            "mentions": []
        },
        "html": "<span itemscope=\"https://app.net/schemas/Post\">Hello channel!</span>",
        "id": "103",
        "machine_only": false,
        "num_replies": 0,
        "source": {
            "client_id": "UxUWrSdVLyCaShN62xZR5tknGvAxK93P",
            "link": "https://app.net",
            "name": "Test app"
        },
        "text": "Hello channel!",
        "thread_id": "103",
        "user": {
            ...
        }
    },
    "meta": {
        "code": 200,
    }
}
```
