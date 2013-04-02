---
title: "Pagination"
---

# Pagination

* TOC
{:toc}

Most App.net API endpoints that return lists of objects are paginated. Understanding how paginated data is requested and returned is key to retrieving data efficiently from the API.

## Overview

App.net always returns items from newest to oldest. You paginate through results by passing `before_id` and `since_id` to the API which restricts the range of content App.net will return. By adjusting these parameters, you can consistently fill in the data you're missing from the App.net API.

By default, when you request data App.net will return the most recent items that are older than `before_id`. If instead you'd like the least recent items that are newer than `since_id`, you can specify `count` as a negative value. As an example, if a stream contains:

> 10, 9, 8, 7, 6, 5, 4, 3, 2, 1

requesting it with `before_id=9&since_id=2&count=2` returns

> 8, 7

requesting it with `before_id=9&since_id=2&count=-2` returns

> 4, 3

In summary:

* `before_id` and `since_id` define the range App.net will return results from. If provided, they should be filled in from a previous request's `min_id` or `max_id`.
* `count` tells App.net how many items you want. It defaults to 20 and cannot be more than 200.
* If `count` is negative, App.net returns results starting from the `since_id`. **Remember, items are always returned from newest to oldest even in this case.**


## Parameters

Requests for paginated streams can optionally be filtered by passing the following query string parameters along with the request:

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>since_id</code></td>
            <td>Return objects following the <code>max_id</code> provided in the <a href="#response-metadata">response metadata</a> of a previous query or following one of the <a href="#special-pagination-ids">special pagination ids</a> for streams with <a href="/docs/resources/stream-marker">Stream Markers</a>.</td>
        </tr>
        <tr>
            <td><code>before_id</code></td>
            <td>Return objects preceding the <code>min_id</code> provided in the <a href="#response-metadata">response metadata</a> of a previous query or preceding one of the <a href="#special-pagination-ids">special pagination ids</a> for streams with <a href="/docs/resources/stream-marker">Stream Markers</a>.</td>
        </tr>
        <tr>
            <td><code>count</code></td>
            <td>The number of objects to return, up to a maximum of 200. If this value is negative, items will be returned starting at <code>since_id</code>. Please see the <a href="#overview">pagination overview</a> for more information.</td>
        </tr>
    </tbody>
</table>

### Special pagination ids

When requesting objects from an endpoint that supports [Stream Markers](/docs/resources/stream-marker), you can pass the following special values to the `since_id` and `before_id` pagination parameters:

<table>
    <thead>
        <tr>
            <th>Value</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>last_read</code></td>
            <td>Use the <code>last_read_id</code> of the current <a href="/docs/resources/stream-marker/">Stream Marker</a> (if there is one) as the value.</td>
        </tr>
        <tr>
            <td><code>last_read_inclusive</code></td>
            <td>Use the <code>last_read_id</code> of the current <a href="/docs/resources/stream-marker/">Stream Marker</a> (if there is one) as the value. Also include the "last read" object.</td>
        </tr>
        <tr>
            <td><code>marker</code></td>
            <td>Use the <code>id</code> of the current <a href="/docs/resources/stream-marker/">Stream Marker</a> (if there is one) as the value.</td>
        </tr>
        <tr>
            <td><code>marker_inclusive</code></td>
            <td>Use the <code>id</code> of the current <a href="/docs/resources/stream-marker/">Stream Marker</a> (if there is one) as the value. Also include the "marked" object.</td>
        </tr>
    </tbody>
</table>

## Response Metadata

Responses from paginated streams will include the following fields in the `meta` object of the [response envelope](/docs/basics/responses/#response-envelope).

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>max_id</code></td>
            <td>string</td>
            <td>The greatest ID returned in the data set. Inclusive. This should be considered an opaque identifier that may be passed as <code>since_id</code> in the next call in order to retrieve the next set of objects.</td>
        </tr>
        <tr>
            <td><code>min_id</code></td>
            <td>string</td>
            <td>The least ID returned in the data set. Inclusive. This should be considered an opaque identifier that may be passed as <code>before_id</code> in the next call in order to retrieve the previous set of objects.</td>
        </tr>
        <tr>
            <td><code>more</code></td>
            <td>boolean</td>
            <td>If <code>more</code> is <code>true</code>, there are more matches available for the given query than would fit within <code>count</code> objects. If <code>more</code> is <code>false</code>, there are no more matches available.</td>
        </tr>
    </tbody>
</table>
