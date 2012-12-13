# Responses

>All information in this document assumes the ```response_envelope``` migration is active. Please refer to [Migrations](/appdotnet/api-spec/blob/master/migrations.md) for more information.

All responses to requests to the App.net API endpoints described in [Resources](/appdotnet/api-spec/blob/master/resources/README.md#resources), whether successful or not, will be returned in the same type of envelope structure. This document will describe how that envelope works as well as how it can be used for convenient purposes, such as pagination.

## Response Envelopes

The top-level response is an object containing two keys. The first key, ```data```, corresponds to the actual response item requested. This may either be an object itself or a list of objects. The particular data returned is described in each endpoint's documentation. If the request is unsuccessful (results in an error), no ```data``` key will be present.

The second key present, ```meta```, corresponds to an object containing additional information about the request. This object will always contain ```code```, a copy of the HTTP status code that has been returned. It will also contain [pagination data](#pagination-metadata) or [stream marker data](objects/stream_marker.md), when relevant.

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
        "max_id": 65039,
        "min_id": 65039,
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

## Error Conditions

If the request was unsuccessful for some reason, no ```data``` key will be returned -- the response object will only contain a ```meta``` object. Additional information pertaining to the type of error generated will be returned inside the ```meta``` object. In particular, the ```code``` and ```error_message``` keys will point out what sort of error occurred. There may also be a uniquely-identifying ```error_slug``` and ```error_id``` present that can be used to get more information about the error and which may be helpful in support requests with App.net staff.

#### Error Slugs

<table>
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
            <td><a href="/appdotnet/api-spec/blob/master/auth.md#server-side-flow-ruby-python-php-java-etc">access_token</a></td>
            <td>The passed OAuth <code>code</code> was already used to generate a token.</td>
        </tr>
        <tr>
            <td><code>redirect-uri-required</code></td>
            <td><a href="/appdotnet/api-spec/blob/master/auth.md#server-side-flow-ruby-python-php-java-etc">access_token</a></td>
            <td>The call to access_token must include <code>redirect_uri</code>.</td>
        </tr>
    </tbody>
</table>

## Pagination Metadata

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
            <td>The least ID returned in the data set. Inclusive. This should be considered an opaque identifier that may be passed as <code>before_id</code.</td>
        </tr>
        <tr>
            <td><code>more</code></td>
            <td>boolean</td>
            <td>If <code>more</code> is <code>true</code>, there are more matches available for the given query than would fit within <code>count</code> objects. If <code>more</code> is <code>false</code>, there are no more matches available.</td>
        </tr>
    </tbody>
</table>
