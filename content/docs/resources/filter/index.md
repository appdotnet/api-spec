## Filter

A Filter restricts a stream of messages on the server side so your client only sees what it's interested in. [Streams](stream.md) are currently the only way to use filters right now.

~~~ js
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
}
~~~

### Filter fields

<table>
    <thead>
        <tr>
            <th>Field</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>id</code></td>
            <td>string</td>
            <td>Primary identifier for a filter. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
        </tr>
        <tr>
            <td><code>name</code></td>
            <td>string</td>
            <td>An optional User assigned name for this filter.</td>
        </tr>
        <tr>
            <td><code>clauses</code></td>
            <td>list</td>
            <td>A list of <a href="#filter-clauses">filter clauses</a> to match against. Must be non-empty.</td>
        </tr>
        <tr>
            <td><code>match_policy</code></td>
            <td>string</td>
            <td>How should the clauses be joined together? One of <code>include_any</code>, <code>include_all</code>, <code>exclude_any</code>, or <code>exclude_all</code>. For example, <code>include_any</code> will include a message if it matches any of the clauses and <code>exclude_all</code> will exclude a message if it matches all of the clauses. This allows either white- or blacklist filtering.</td>
        </tr>
    </tbody>
</table>

### Filter Clauses

<table>
    <thead>
        <tr>
            <th>Field</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>object_type</code></td>
            <td>string</td>
            <td>What type of object does this filter operate on? Must be one of <code>post</code>, <code>star</code>, <code>user_follow</code>. </td>
        </tr>
        <tr>
            <td><code>operator</code></td>
            <td>string</td>
            <td>How should <code>field</code> be matched against <code>value</code>.
                <br>
                <table>
                    <tr>
                        <th>Operator</th>
                        <th>Description</th>
                    </tr>
                    <tr>
                        <td><code>equals</code></td>
                        <td>Does <code>field</code> equal <code>value</code>.</td>
                    </tr>
                    <tr>
                        <td><code>matches</code></td>
                        <td>Is the string <code>value</code> a substring of <code>field</code>.</td>
                    </tr>
                    <tr>
                        <td><code>lt</code></td>
                        <td>Is the integer in <code>field</code> &lt; <code>value</code>.</td>
                    </tr>
                    <tr>
                        <td><code>le</code></td>
                        <td>Is the integer in <code>field</code> &le; <code>value</code>.</td>
                    </tr>
                    <tr>
                        <td><code>gt</code></td>
                        <td>Is the integer in <code>field</code> &gt; <code>value</code>.</td>
                    </tr>
                    <tr>
                        <td><code>ge</code></td>
                        <td>Is the integer in <code>field</code> &ge; <code>value</code>.</td>
                    </tr>
                    <tr>
                        <td><code>one_of</code></td>
                        <td>Is the <code>field</code> an element in the list <code>value</code>.</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td><code>field</code></td>
            <td>string</td>
            <td>A <a href="#json-pointer">JSON Pointer</a> string that specifies what part of the message we should match against.</td>
        </tr>
        <tr>
            <td><code>value</code></td>
            <td>string, int, or list</td>
            <td>A string, integer, or list that the message's data is compared against. Some <a href="#filter-variables">variables</a> are also accepted.</td>
        </tr>
    </tbody>
</table>

### Filter variables

<table>
    <thead>
        <tr>
            <th>Value</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>$authorized_userids</code></td>
            <td>list</td>
            <td>A list of the current user ids who have authorized the App that is using this filter in a stream. Since this is a list, make sure you use the <code>one_of</code> operator with this variable.</td>
        </tr>
    </tbody>
</table>

### JSON Pointer

We use a slightly modified version of the [JSON Pointer](http://tools.ietf.org/html/draft-ietf-appsawg-json-pointer-04) standard to specify which part of a message we should filter against. According to the spec:

> JSON Pointer defines a string syntax for identifying a specific value within a JSON document.

For instance, in the message:

~~~ js
{
    "data": [
        {
            "id": "2", // note this is a string
            "user": {
                ...
            },
            "created_at": "2012-07-16T17:25:47Z",
            "text": "@mthurman stop trolling",
            "html": "<span itemprop=\"mention\" data-mention-name=\"mthurman\" data-mention-id=\"1\">@mthurman</span> stop trolling",
            "source": {
                "client_id": "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4",
                "name": "Clientastic for iOS",
                "link": "http://app.net"
            },
            "machine_only": false,
            "reply_to": "1",
            "thread_id": "1",
            "num_replies": 0,
            "num_reposts": 0,
            "num_stars": 0,
            "entities": {
                "mentions": [{
                    "name": "mthurman",
                    "id": "2",
                    "pos": 0,
                    "len": 9
                }],
                "hashtags": [{],
                "links": []
            },
            "you_reposted": false,
            "you_starred": false
        },
        ...
    ],
    "meta": {
        "code": 200,
        "max_id": "2",
        "min_id": "1",
        "more": false
    }
~~~

* ```/data/source/client_id``` = "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4"
* ```/data/entities/mentions/0/name``` = "mthurman"
* ```/data/num_replies``` = 0

We extend JSON pointer slightly to allow all the elements of a list to match. For example, to answer the question "Does this post contain the hashtag 'rollout'", you'd use a field selector like ```/data/entities/hashtags/*/name```. Following the JSON Pointer spec, if you'd like to encode a literal ```*``` you can use ```~2``` instead.

# Filters

## Interacting with individual Filters

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#create-a-filter">Create a Filter</a></td>
            <td>/stream/0/filters</td>
            <td>POST</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#retrieve-a-filter">Retrieve a Filter</a></td>
            <td>/stream/0/filters/[filter_id]</td>
            <td>GET</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#update-a-filter">Update a Filter</a></td>
            <td>/stream/0/filters/[filter_id]</td>
            <td>PUT</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#delete-a-filter">Delete a Filter</a></td>
            <td>/stream/0/filters/[filter_id]</td>
            <td>DELETE</td>
        </tr>
    </tbody>
</table>

## Interacting with multiple Filters

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#get-current-users-filters">Get the current User's Filters</a></td>
            <td>/stream/0/filters</td>
            <td>GET</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/filters.md#delete-all-of-the-current-users-filters">Delete the current User's Filters</a></td>
            <td>/stream/0/filters</td>
            <td>DELETE</td>
        </tr>
    </tbody>
</table>

## Create a Filter

Create a <a href="../objects/filter.md">Filter</a> for the current user.

Send a JSON document that matches the  <a href="../objects/filter.md">filter schema</a> with an HTTP header of ```Content-Type: application/json```. Currently, the only keys we use from your JSON will be ```name```, ```match_policy``` and ```clauses```.

<%= render 'partials/migration' %>

### URL
> https://alpha-api.app.net/stream/0/filters

### Data

A JSON object representing the filter to create. See <a href="../objects/filter.md">the filter object</a> for more information. (Omit the <code>id</code> parameter).</td>

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

Returns a specific <a href="../objects/filter.md">Filter</a> object.

<%= render 'partials/migration' %>

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

Return the <a href="../objects/filter.md">Filters</a> for the current user.

<%= render 'partials/migration' %>

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

Updates a specific <a href="../objects/filter.md">Filter</a> object. When a filter is updated, all the streams using the filter will start using the new filter criteria. You can update a filter by PUTing an object that matches the [filter schema](../objects/filter.md) with an HTTP header of ```Content-Type: application/json```. The entire filter will be replaced with new value but id's ```id``` will remain the same. Please refer to the documentation on [how to create a filter](#create-a-filter) for more information.

<%= render 'partials/migration' %>

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

Delete a <a href="../objects/filter.md">Filter</a>. The Filter must belong to the current User. It returns the deleted Filter on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/appdotnet/api-spec/blob/master/auth.md#authenticated-api-requests).*

<%= render 'partials/migration' %>

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

Delete all <a href="../objects/filter.md">Filters</a> for the current user. It returns the deleted Filters on success.

*Remember, access tokens can not be passed in a HTTP body for ```DELETE``` requests. Please refer to the [authentication documentation](/appdotnet/api-spec/blob/master/auth.md#authenticated-api-requests).*

<%= render 'partials/migration' %>

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