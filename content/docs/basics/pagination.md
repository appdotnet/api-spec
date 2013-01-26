---
title: "Data Formats"
---

# Pagination

* TOC
{:toc}

Most App.net API endpoints that return lists of objects are paginated. Understanding how paginated data is requested and returned is key to retrieving data efficiently from the API. 

## Parameters

Requests for paginated streams can be filtered by passing the following query string parameters along with the request:

<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Required?</th>
            <th width="50">Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>since_id</code></td>
            <td>Optional</td>
            <td>string</td>
            <td>Return objects following the <code>max_id</code> provided in the <a href="#response-metadata">response metadata</a> of a previous query or one of the <a href="#special-pagination-ids">special pagination ids</a> for streams with <a href="/docs/resources/stream-marker">Stream Markers</a>.</td>
        </tr>
        <tr>
            <td><code>before_id</code></td>
            <td>Optional</td>
            <td>string</td>
            <td>Return objects preceding the <code>min_id</code> provided in the <a href="#response-metadata">response metadata</a> of a previous query or one of the <a href="#special-pagination-ids">special pagination ids</a> for streams with <a href="/docs/resources/stream-marker">Stream Markers</a>.</td>
        </tr>
        <tr>
            <td><code>count</code></td>
            <td>Optional</td>
            <td>integer</td>
            <td>The number of objects to return, up to a maximum of 200.</td>
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