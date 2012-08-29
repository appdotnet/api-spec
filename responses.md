# Responses

>All information in this document assumes the ```response_envelope``` migration is active. Please refer to [Migrations](/appdotnet/api-spec/blob/master/migrations.md) for more information.

All responses to requests to the App.net API endpoints described in [Resources](/appdotnet/api-spec/blob/master/resources/README.md#resources), whether successful or not, will be returned in the same type of envelope structure. This document will describe how that envelope works as well as how it can be used for convenient purposes, such as pagination.

## Response Envelopes

The top-level response is an object containing two keys. The first key, ```data```, corresponds to the actual response item requested. This may either be an object itself or a list of objects. The particular data returned is described in each endpoint's documentation. If the request is unsuccessful (results in an error), no ```data``` key will be present.

The second key present, ```meta```, corresponds to an object containing additional information about the request. This object will always contain ```code```, a copy of the HTTP status code that has been returned. It will also contain pagination data, when relevant.

### Error Conditions

If the request was unsuccessful for some reason, no ```data``` key will be returned -- the reponse object will only contain a ```meta``` object. Additional information pertaining to the type of error generated will be returned inside the ```meta``` object. In particular, the ```code``` and ```error_message``` keys will point out what sort of error occurred. There may also be a uniquely-identifying ```error_slug``` present that can be used to get more information about the error and which may be helpful in support requests with App.net staff.

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
            <td><code>code-used</code></td>
            <td><a href="/appdotnet/api-spec/blob/master/auth.md#server-side-flow-ruby-python-php-java-etc">access_token</a></td>
            <td>The passed OAuth <code>code</code> was already used to generate a token.</td>
        </tr>
        <tr>
            <td><code>redirect-uri-required</code></td>
            <td><a href="/appdotnet/api-spec/blob/master/auth.md#server-side-flow-ruby-python-php-java-etc">access_token</a></td>
            <td>The call to access_token must include <code>redirect_uri</code>.</td>
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
    </tbody>
</table>

### Pagination Metadata

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
