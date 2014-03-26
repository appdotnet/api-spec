---
title: "Filter"
---

# Filter

<%= render 'partials/object-tab' %>

* TOC
{:toc}

A Filter restricts a stream of messages on the server side so your client only sees what it's interested in. [Streams](/reference/resources/app-stream/) are currently the only way to use filters right now.

<%= json(:filter) %>

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
        <tr>
            <td><code>owner</code></td>
            <td><a href="/reference/resources/user/">User object</a></td>
            <td>This is an embedded version of the <a href='/reference/resources/user/'>User</a> object. <em>In certain cases (e.g., when a user account has been deleted), this key may be omitted.</em></td>
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

<%= response(:post) %>

* `/data/source/client_id` = "<%= get_hash(:post)["source"]["client_id"] %>"
* `/data/entities/hashtags/0/name` = "<%= get_hash(:post)["entities"]["hashtags"][0]["name"] %>"
* `/data/num_replies` = <%= get_hash(:post)["num_replies"] %>

We extend JSON pointer slightly to allow all the elements of a list to match. For example, to answer the question "Does this post contain the hashtag 'rollout'", you'd use a field selector like `/data/entities/hashtags/*/name`. Following the JSON Pointer spec, if you'd like to encode a literal `*` you can use `~2` instead.

<%= render 'partials/endpoints-tab', :for => "filter" %>