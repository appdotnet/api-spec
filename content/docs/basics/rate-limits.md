# Rate Limits

Fundamental limits of server resources and network infrastructure make it necessary for us to limit the rate at which we handle requests. By enforcing request rate limits, we make it feasible to fairly and evenly distribute our capacity amongst our users and prevent apps from monopolizing these resources.

## Enforcement

Any request, authorized or unauthorized, may be subject to multiple rate limits. At present, authorized calls are limited per access token, while unauthorized calls are limited per IP address. When more than one limit applies to a request, the request will apply against each of those limits, but information will be returned on only the most restrictive of those limits.

## Response Headers

The following sample shows a set of three headers which might be returned with a response to a call to the API.

    X-RateLimit-Remaining: 4959
    X-RateLimit-Limit: 5000
    X-RateLimit-Reset: 3600

The first header, ```X-RateLimit-Remaining```, indicates the total number of requests remaining for this cycle (4959). ```X-RateLimit-Limit``` indicates the total capacity (5000). ```X-RateLimit-Reset``` gives the number of seconds until the remaining number of requests will be reset to the capacity; in this case, ```X-RateLimit-Remaining``` will be reset to 5000 requests in 3600 seconds, irrespective of how many additional requests are made between now and then.

## Exceeding Limits

Should your request exceed any applicable rate limits, we will return a status code ```429``` (Too many requests). We ask that any app which is accessing our API respect this response code. The ```Retry-After``` header will contain the number of seconds before another request of this type can be made -- if your request receives a ```429``` code, your application should wait until the ```Retry-After``` period has elapsed before attempting the same kind of request.

## Limits

At present, these are the limit values we use:

### Authenticated Requests (per token)

<table>
    <thead>
        <tr>
            <th>Type</th>
            <th>Limit</th>
            <th>Period</th>
            <th>Notes</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Global</td>
            <td>5000</td>
            <td>1 hour (3600 seconds)</td>
            <td>Affects all authenticated endpoints, even if other limits apply as well.</td>
        </tr>
        <tr>
            <td>Write</td>
            <td>20</td>
            <td>1 minute (60 seconds)</td>
            <td>POST/DELETE requests.</td>
        </tr>
    </tbody>
</table>

### Unauthenticated Requests (per IP address)

<table>
    <thead>
        <tr>
            <th>Type</th>
            <th>Limit</th>
            <th>Period</th>
            <th>Notes</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Global</td>
            <td>50</td>
            <td>1 minute (60 seconds)</td>
            <td>Affects all unauthenticated endpoints.</td>
        </tr>
    </tbody>
</table>
