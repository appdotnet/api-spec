---
title: "Filter Lifecycle"
---

# Filter Lifecycle

* TOC
{:toc}

## Create a Filter

Create a [Filter](/reference/resources/filter/) for the current user.

Send a JSON document that matches the [Filter schema](/reference/resources/filter/) with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```name```, ```match_policy``` and ```clauses```.

<%= endpoint "POST", "filters", "User" %>

#### Data

A JSON object representing the [Filter](/reference/resources/filter/) to create.

#### Example

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

Returns a specific [Filter](/reference/resources/filter/) object.

<%= endpoint "GET", "filters/[filter_id]", "User" %>

<%= url_params [
    ["filter_id", "The id of the Filter to retrieve."]
]%>

#### Example

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

Return the [Filter](/reference/resources/filter/) for the current user.

<%= endpoint "GET", "filters", "User" %>

#### Example

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
        "code": 200
    }
}
~~~

## Update a Filter

Updates a specific [Filter](/reference/resources/filter/) object. When a filter is updated, all the streams using the filter will start using the new filter criteria. You can update a filter by PUTing an object that matches the [Filter schema](/reference/resources/filter/) with an HTTP header of ```Content-Type: application/json```. The entire filter will be replaced with new value but it's ```id``` will remain the same. Please refer to the documentation on [how to create a Filter](#create-a-filter) for more information.

<%= endpoint "PUT", "filters/[filter_id]", "User" %>

<%= url_params [
    ["filter_id", "The id of the Filter to update."]
]%>

#### Example

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

Delete a [Filter](/reference/resources/filter/). The Filter must belong to the current User. It returns the deleted Filter on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/reference/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "filters/[filter_id]", "User" %>

<%= url_params [
    ["filter_id", "The id of the Filter to delete."]
]%>

#### Example

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

Delete all [Filters](/reference/resources/filter/) for the current user. It returns the deleted Filters on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/reference/authentication/#making-authenticated-api-requests).*

<%= endpoint "DELETE", "filters", "User" %>

#### Example

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
        "code": 200
    }
}
~~~
