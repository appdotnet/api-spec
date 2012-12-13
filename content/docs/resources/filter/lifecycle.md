# Filter Lifecycle

* TOC
{:toc}

## Create a Filter

Create a [Filter](/docs/resources/filter/) for the current user.

Send a JSON document that matches the [Filter schema](/docs/resources/filter/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```name```, ```match_policy``` and ```clauses```.

<%= migration_warning ['response_envelope'] %>

### URL
> https://alpha-api.app.net/stream/0/filters

### Data

A JSON object representing the [Filter](/docs/resources/filter/) to create.

### Example

> POST https://alpha-api.app.net/stream/0/filters
> 
> Content-Type: application/json
> 
> DATA {"match_policy": "include_any", "clauses": [{"operator": "matches", "field": "/data/entities/hashtags/*/name", "object_type": "post", "value": "rollout"}], "name": "Posts about rollouts"}

~~~js
{
    "data": {
        "clauses": [
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "matches",
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
~~~

## Retrieve a Filter

Returns a specific [Filter](/docs/resources/filter/) object.

<%= migration_warning ['response_envelope'] %>

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

~~~ js
{
    "data": {
        "clauses": [
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "matches",
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
~~~

## Get current user's Filters

Return the [Filter](/docs/resources/filter/) for the current user.

<%= migration_warning ['response_envelope'] %>

### URL
> https://alpha-api.app.net/stream/0/filters

### Parameters

None.

### Example

> GET https://alpha-api.app.net/stream/0/filters

~~~ js
{
    "data": [
        {
            "clauses": [
                {
                    "field": "/data/entities/hashtags/*/name",
                    "object_type": "post",
                    "operator": "matches",
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
~~~

## Update a Filter

Updates a specific [Filter](/docs/resources/filter/) object. When a filter is updated, all the streams using the filter will start using the new filter criteria. You can update a filter by PUTing an object that matches the [Filter schema](/docs/resources/filter/) with an HTTP header of ```Content-Type: application/json```. The entire filter will be replaced with new value but it's ```id``` will remain the same. Please refer to the documentation on [how to create a Filter](#create-a-filter) for more information.

<%= migration_warning ['response_envelope'] %>

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
> 
> Content-Type: application/json
> 
> DATA {"match_policy": "include_any", "clauses": [{"operator": "matches", "field": "/data/entities/hashtags/*/name", "object_type": "post", "value": "rollout"}, {"operator": "matches", "field": "/data/entities/hashtags/*/name", "object_type": "post", "value": "bug"}], "name": "Posts about rollouts or bugs"}

~~~js
{
    "data": {
        "clauses": [
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "matches",
                "value": "rollout"
            },
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "matches",
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
~~~

## Delete a Filter

Delete a [Filter](/docs/resources/filter/). The Filter must belong to the current User. It returns the deleted Filter on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/docs/authentication/#making-authenticated-api-requests).*

<%= migration_warning ['response_envelope'] %>

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

~~~ js
{
    "data": {
        "clauses": [
            {
                "field": "/data/entities/hashtags/*/name",
                "object_type": "post",
                "operator": "matches",
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
~~~

## Delete all of the current user's Filters

Delete all [Filters](/docs/resources/filter/) for the current user. It returns the deleted Filters on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/docs/authentication/#making-authenticated-api-requests).*

<%= migration_warning ['response_envelope'] %>

### URL
> https://alpha-api.app.net/stream/0/filters

### Data

None.

### Example

> DELETE https://alpha-api.app.net/stream/0/filters

~~~ js
{
    "data": [
        {
            "clauses": [
                {
                    "field": "/data/entities/hashtags/*/name",
                    "object_type": "post",
                    "operator": "matches",
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
~~~
