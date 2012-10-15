# Filters

## Get current user's Filters

Return the <a href="/appdotnet/api-spec/blob/master/objects.md#filter">Filters</a> for the current user.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/filters

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/filters
```js
{
    "data": [
        {
            "clauses": [
                {
                    "field": "/data/entities/hashtags/*/name",
                    "object_type": "post",
                    "operator": "contains",
                    "value": "rollout"
                }
            ],
            "id": "1",
            "match_policy": "include_any",
            "name": "Posts about rollouts"
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": "2",
        "min_id": "1",
        "more": false
    }
}
```

## Create a Filter

Create a <a href="/appdotnet/api-spec/blob/master/objects.md#filter">Filter</a> for the current user.

Send a JSON document that matches the  <a href="/appdotnet/api-spec/blob/master/objects.md#filter">filter schema</a> with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```name```, ```match_policy``` and ```clauses```.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/filters

### Data

A JSON object representing the filter to create. See <a href="/appdotnet/api-spec/blob/master/objects.md#filter">the filter object</a> for more information. (Omit the <code>id</code> parameter).</td>

### Example

> POST https://alpha-api.app.net/stream/0/filters
> Content-Type: application/json
> DATA {"match_policy": "include_any", "clauses": [{"operator": "contains", "field": "/data/entities/hashtags/*/name", "object_type": "post", "value": "rollout"}], "name": "Posts about rollouts"}
```js
{
    "data": {
        "clauses": [
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "contains",
                "value": "rollout"
            }
        ],
        "id": "1",
        "match_policy": "include_any",
        "name": "Posts about rollouts"
    },
    "meta": {
        "code": 200
    }
}
```

## Delete all of the current user's Filters

Delete all <a href="/appdotnet/api-spec/blob/master/objects.md#filter">Filters</a> for the current user. It returns the deleted Filters on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/appdotnet/api-spec/blob/master/auth.md#authenticated-api-requests).*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/filters

### Data

None.

### Example

> DELETE https://alpha-api.app.net/stream/0/filters
```js
{
    "data": [
        {
            "clauses": [
                {
                    "field": "/data/entities/hashtags/*/name",
                    "object_type": "post",
                    "operator": "contains",
                    "value": "rollout"
                }
            ],
            "id": "1",
            "match_policy": "include_any",
            "name": "Posts about rollouts"
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": "2",
        "min_id": "1",
        "more": false
    }
}
```

## Retrieve a Filter

Returns a specific <a href="/appdotnet/api-spec/blob/master/objects.md#filter">Filter</a> object.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/filters/[filter_id]

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
            <td><code>filter_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The filter id</td>
        </tr>
    </tbody>
</table>

### Example

> GET https://alpha-api.app.net/stream/0/filters/1
```js
{
    "data": {
        "clauses": [
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "contains",
                "value": "rollout"
            }
        ],
        "id": "1",
        "match_policy": "include_any",
        "name": "Posts about rollouts"
    },
    "meta": {
        "code": 200
    }
}
```

## Update a Filter

Updates a specific <a href="/appdotnet/api-spec/blob/master/objects.md#filter">Filter</a> object. When a filter is updated, all the streams using the filter will start using the new filter criteria. You can update a filter by PUTing an object that matches the [filter schema](/appdotnet/api-spec/blob/master/objects.md#filter) with an HTTP header of ```Content-Type: application/json```. The entire filter will be replaced with new value but id's ```id``` will remain the same. Please refer to the documentation on [how to create a filter](#create-a-filter) for more information.

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/filters/[filter_id]

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
            <td><code>filter_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The filter id</td>
        </tr>
    </tbody>
</table>

### Example

> PUT https://alpha-api.app.net/stream/0/filters/1
> Content-Type: application/json
> DATA {"match_policy": "include_any", "clauses": [{"operator": "contains", "field": "/data/entities/hashtags/*/name", "object_type": "post", "value": "rollout"}, {"operator": "contains", "field": "/data/entities/hashtags/*/name", "object_type": "post", "value": "bug"}], "name": "Posts about rollouts or bugs"}
```js
{
    "data": {
        "clauses": [
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "contains",
                "value": "rollout"
            },
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "contains",
                "value": "bug"
            }
        ],
        "id": "1",
        "match_policy": "include_any",
        "name": "Posts about rollouts or bugs"
    },
    "meta": {
        "code": 200
    }
}
```

## Delete a Filter

Delete a <a href="/appdotnet/api-spec/blob/master/objects.md#filter">Filter</a>. The Filter must belong to the current User. It returns the deleted Filter on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/appdotnet/api-spec/blob/master/auth.md#authenticated-api-requests).*

> This endpoint is currently migrated by the ```response_envelope``` migration. Please refer to the [Migrations documentation](/appdotnet/api-spec/blob/master/migrations.md#current-migrations) for more info.

### URL
> https://alpha-api.app.net/stream/0/filters/[filter_id]

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
            <td><code>filter_id</code></td>
            <td>Required</td>
            <td>string</td>
            <td>The filter id</td>
        </tr>
    </tbody>
</table>

### Example

> DELETE https://alpha-api.app.net/stream/0/filters/1
```js
{
    "data": {
        "clauses": [
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "contains",
                "value": "rollout"
            }
        ],
        "id": "1",
        "match_policy": "include_any",
        "name": "Posts about rollouts"
    },
    "meta": {
        "code": 200
    }
}
```
