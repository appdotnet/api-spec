---
title: "Responses"
---

# Responses

* TOC
{:toc}

All responses to requests to the App.net API endpoints listed under [Resources](/docs/resources/), whether successful or not, will be returned in the same type of envelope structure. This document describes how that envelope works and what it may contain.

*Please note: the [authentication endpoints](/docs/authentication) return a slightly different format that follows the OAuth2 specification.*

{::options parse_block_html="true" /}

## Response Envelope

The top-level response is an object containing two keys. The first key, ```data```, corresponds to the actual response item requested. This may either be an object itself or a list of objects. The particular data returned is described in each endpoint's documentation. If the request is unsuccessful (results in an error), no ```data``` key will be present.

The second key present, ```meta```, corresponds to an object containing additional information about the request. This object will always contain ```code```, a copy of the HTTP status code that has been returned. It will also contain [pagination metadata](/docs/basics/pagination/#response-metadata) and/or a [stream marker](/docs/resources/stream-marker/) when relevant.

### Sample Response Envelope
~~~ js
{
    "data": {
        ...
    },
    "meta": {
        "code": 200,
        "marker": {
            "id": "1",
            "name": "global",
            "percentage": 0,
            "updated_at": "2012-11-09T23:35:38Z",
            "version": "NWoZK3kTsExUV00Ywo1G5jlUKKs"
        },
        "max_id": "65039",
        "min_id": "65039",
        "more": true
    }
}
~~~

## JSONP

We support JSONP for easy, unauthenticated cross-domain API requests with wide browser support. Normal JSON responses are wrapped in a Javascript function so they may be included in a webpage and fetched directly by the browser via a `script` tag. It is not possible to make requests to API endpoints which require authentication with JSONP.

To use JSONP, add a `callback` parameter to the request's query string. For example:

    https://alpha-api.app.net/stream/0/posts/stream/global?callback=awesome

Will result in a response that looks something like this:

    awesome({...})

When using JSONP, our servers will return a 200 status code in the HTTP response, regardless of the effective status code.

For more information on JSONP, see the Wikipedia page for [JSONP](http://en.wikipedia.org/wiki/JSONP).

## CORS

We support CORS for authenticated cross-domain API requests direct from browsers. Support for CORS may vary by browser. When using CORS, you are still responsible for obtaining, storing and supplying a valid access token with each request, if access to authenticated endpoints is required. For more information on CORS, see the Wikipedia page for [CORS](http://en.wikipedia.org/wiki/Cross-origin_resource_sharing).

## Pretty-printed JSON

We return a minified form of JSON by default, but support pretty-printing of JSON for debugging and enhanced readability. Note that pretty-printed JSON contains a trailing line break, so you may wish to make sure your JSON decoder handles this properly.

To request pretty-printing, send the following HTTP header with your request:

    X-ADN-Pretty-JSON: 1

*Note: Sending any value is sufficient. Omit the header entirely if you wish to receive minified JSON.*

## Error Conditions

If the request was unsuccessful for some reason, no ```data``` key will be returned -- the response object will only contain a ```meta``` object. Additional information pertaining to the type of error generated will be returned inside the ```meta``` object. In particular, the ```code``` and ```error_message``` keys will point out what sort of error occurred. There may also be a uniquely-identifying ```error_slug``` and ```error_id``` present that can be used to get more information about the error and which may be helpful in support requests with App.net staff.

### Error Slugs

<table class='table table-striped'>
    <thead>
        <tr>
            <th>Slug</th>
            <th>Relevant on</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>invalid-token</code></td>
            <td>global</td>
            <td>The passed OAuth token was not valid. It may have been corrupted or missing some of its data</td>
        </tr>
        <tr>
            <td><code>not-authorized</code></td>
            <td>global</td>
            <td>The User for the given token has likely explicitly revoked access to your App. You may wish to reauthenticate that User.</td>
        </tr>
        <tr>
            <td><code>token-expired</code></td>
            <td>global</td>
            <td>The passed token (or code) has reached the end of its lifetime. A new token will have to be generated.</td>
        </tr>
        <tr>
            <td><code>code-used</code></td>
            <td><a href="/docs/authentication/flows/web/">access_token</a></td>
            <td>The passed OAuth <code>code</code> was already used to generate a token.</td>
        </tr>
        <tr>
            <td><code>redirect-uri-required</code></td>
            <td><a href="/docs/authentication/flows/web/">access_token</a></td>
            <td>The call to access_token must include <code>redirect_uri</code>.</td>
        </tr>
    </tbody>
</table>

## Possible HTTP status codes

App.net uses the HTTP status code to indicate if an API request was a success or failure. For environments that can't access the raw HTTP response directly, this value is also duplicated in the `meta.code` value. The following table lists all currently used HTTP status codes. If you get a status code that is not documented below, please [open an issue](https://github.com/appdotnet/api-spec/issues).

<table class='table table-striped'>
    <thead>
        <tr>
            <th>Code</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>200 OK</code></td>
            <td>The request was successful.</td>
        </tr>
        <tr>
            <td><code>204 No Content</code></td>
            <td>Returned when retrieving an incomplete file or when uploading file content to an incomplete file.</td>
        </tr>
        <tr>
            <td><code>302 Found</code></td>
            <td>Redirection to the final destination of a resource. Returned when retrieving <a href="/docs/resources/file/content/#get-file-content">file contents</a>, <a href="/docs/resources/user/profile/#retrieve-a-users-avatar-image">user avatar</a>, or a <a href="/docs/resources/user/profile/#retrieve-a-users-cover-image">cover image</a>.</td>
        </tr>
        <tr>
            <td><code>400 Bad Request</code></td>
            <td>The API request was malformed in some way. A message should be returned that indicates how this request can be fixed.</td>
        </tr>
        <tr>
            <td><code>401 Unauthorized</code></td>
            <td>A <a href="/docs/authentication/#making-authenticated-api-requests">token is required</a>. If you passed a token, a message should indicate why this token is not authorized. The <a href="#error-slugs">error slugs</a> should also provide a reason why this token is invalid.</td>
        </tr>
        <tr>
            <td><code>403 Forbidden</code></td>
            <td>The token you are providing doesn't have the right to perform the request. Please check that your token is of the <a href="/docs/authentication/#what-kind-of-token-do-i-need">correct type</a> and has the <a href="/docs/authentication/#scopes">required scope</a>.</td>
        </tr>
        <tr>
            <td><code>404 Not Found</code></td>
            <td>The requested resource was not found.</td>
        </tr>
        <tr>
            <td><code>405 Method Not Allowed</code></td>
            <td>The HTTP method requested is not allowed. Please see the <code>Allow</code> header for a list of acceptable HTTP methods.</td>
        </tr>
        <tr>
            <td><code>429 Too Many Requests</code></td>
            <td>The request could not be completed due to a <a href="/docs/basics/rate-limits/">rate limit</a>. Please wait at the number of seconds specified in the <code>Retry-After</code> header before you retry this request.</td>
        </tr>
        <tr>
            <td><code>500 Internal Server Error</code></td>
            <td>An unexpected server error has occurred and the App.net team has been notified.</td>
        </tr>
        <tr>
            <td><code>507 Insufficient Storage</code></td>
            <td>The request couldn't be completed because the authorized user has hit a quota limit. This could be returned when trying to <a href="/docs/resources/file/lifecycle/#create-a-file">upload a file</a> or when a user on a free account tried to <a href="/docs/resources/user/following/#follow-a-user">follow more users</a> than their plan allows. The <code>data.limits</code> and <code>data.storage</code> attributes of the <a href="/docs/resources/token/#retrieve-current-token">current token information</a> can help an app avoid this error.</td>
        </tr>
    </tbody>
</table>
