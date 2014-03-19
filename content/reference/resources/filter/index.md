---
title: "Filter"
---

# Filter

<%= render 'partials/object-tab' %>

* TOC
{:toc}

A Filter restricts a stream of messages on the server side so your client only sees what it's interested in. [Streams](/reference/resources/app-stream/) are currently the only way to use filters right now.

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

## Filter fields

<table class='table table-striped'>
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

## Filter Clauses

<table class='table table-striped'>
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
            <td>What type of object does this filter operate on? Must be one of <code>post</code>, <code>star</code>, <code>user_follow</code>, <code>mute</code>, <code>block</code>, <code>stream_marker</code>, <code>message</code>, <code>channel</code>, <code>channel_subscription</code>, <code>token</code>, <code>file</code>. </td>
        </tr>
        <tr>
            <td><code>operator</code></td>
            <td>string</td>
            <td>How should <code>field</code> be matched against <code>value</code>.
                <br>
                <table class='table table-striped'>
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

## Filter variables

<table class='table table-striped'>
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

## JSON Pointer

We use a slightly modified version of the [JSON Pointer standard](http://tools.ietf.org/html/draft-ietf-appsawg-json-pointer-04) to specify which part of a message we should filter against. According to the spec:

> JSON Pointer defines a string syntax for identifying a specific value within a JSON document.

For instance, in the message:

~~~ js
{
    "data": [
        {
            "id": "2", // note this is a string
            "user": "...user object...",
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

<%= render 'partials/endpoints-tab', :for => "filter" %>