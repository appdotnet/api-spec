# User

A User is the central object of the App.net APIs. User objects have usernames, follow other users, and post content for their followers.

## Example User object

~~~ js
{
    "id": "1", // note this is a string
    "username": "mthurman",
    "name": "Mark Thurman",
    "description": {
       "text": "Hi, I'm Mark Thurman and I'm teaching you about the @appdotnet Stream #API.",
       "html": "Hi, I'm Mark Thurman and I'm <a href=\"https://github.com/appdotnet/api_spec\" rel=\"nofollow\">teaching you</a> about the <span itemprop=\"mention\" data-mention-name=\"appdotnet\" data-mention-id=\"3\">@appdotnet</span> Stream #<span itemprop=\"hashtag\" data-hashtag-name=\"api\">API</span>.",
       "entities": {
           "mentions": [{
               "name": "appdotnet",
               "id": "3",
               "pos": 52,
               "len": 10
           }],
           "hashtags": [{
               "name": "api",
               "pos": 70,
               "len": 4
           }],
           "links": [{
               "text": "teaching you",
               "url": "https://github.com/appdotnet/api-spec",
               "pos": 29,
               "len": 12
           }]
        }
    },
    "timezone": "US/Pacific",
    "locale": "en_US",
    "avatar_image": {
        "height": 512,
        "width": 512,
        "url": "https://example.com/avatar_image.jpg"
    },
    "cover_image": {
        "height": 118,
        "width": 320,
        "url": "https://example.com/cover_image.jpg"
    },
    "type": "human",
    "created_at": "2012-07-16T17:23:34Z",
    "counts": {
        "following": 100,
        "followers": 200,
        "posts": 24,
        "stars": 76
    },
    "follows_you": false,
    "you_follow": true,
    "you_muted": false,
    "annotations": [
        {
            "type": "net.app.core.directory.blog",
            "value": {
                "url": "http://myawesomeblog.com"
            }
        }
    ]
}
~~~

## User fields

<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>id</code></td>
        <td>string</td>
        <td>Primary identifier for a user. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed. This idspace is unique to User objects. There can be a Post and User with the same ID; no relation is implied.</td>
    </tr>
    <tr>
        <td><code>username</code></td>
        <td>string</td>
        <td>Case insensitive. 20 characters, may only contain a-z, 0-9 and underscore.</td>
    </tr>
    <tr>
        <td><code>name</code></td>
        <td>string</td>
        <td>User supplied descriptive name. May be a pseudonym. All Unicode characters allowed. Maximum length 50 characters.</td>
    </tr>
    <tr>
        <td><code>description</code></td>
        <td>object</td>
        <td>
            <br>
            <table>
                <tr>
                    <th>Field</th>
                    <th>Type</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td><code>text</code></td>
                    <td>string</td>
                    <td>User supplied biographical information. All Unicode characters allowed. Maximum length 256 characters.</td>
                </tr>
                <tr>
                    <td><code>html</code></td>
                    <td>string</td>
                    <td>Server-generated annotated HTML version of biographical information.</td>
                </tr>
                <tr>
                    <td><code>entities</code></td>
                    <td>object</td>
                    <td>Entities included in biographical information. See information on <a href="entities.md">entities</a> for reference.</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td><code>timezone</code></td>
        <td>string</td>
        <td>User timezone in tzinfo format.</td>
    </tr>
    <tr>
        <td><code>locale</code></td>
        <td>string</td>
        <td>User locale in ISO format.</td>
    </tr>
    <tr>
        <td><code>avatar_image</code></td>
        <td><a href="#images">image object</a></td>
        <td>Object representing the URL and original size of the user's avatar.</td>
    </tr>
    <tr>
        <td><code>cover_image</code></td>
        <td><a href="#images">image object</a></td>
        <td>Object representing the URL and original size of the user's over image.</td>
    </tr>
    <tr>
        <td><code>type</code></td>
        <td>string</td>
        <td>An account can be one of the following types: <code>human</code>, <code>bot</code>, <code>corporate</code>, or <code>feed</code>.</td>
    </tr>
    <tr>
        <td><code>created_at</code></td>
        <td>string</td>
        <td>The time at which the User was created in <a href='http://en.wikipedia.org/wiki/ISO_8601'>ISO 8601</a> format.</td>
    </tr>
    <tr>
        <td><code>counts</code></td>
        <td>object</td>
        <td>
            <br>
            <table>
                <tr>
                    <th>Field</th>
                    <th>Type</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td><code>following</code></td>
                    <td>integer</td>
                    <td>The number of users this user is following.</td>
                </tr>
                <tr>
                    <td><code>followers</code></td>
                    <td>integer</td>
                    <td>The number of users following this user.</td>
                </tr>
                <tr>
                    <td><code>posts</code></td>
                    <td>integer</td>
                    <td>The number of posts created by this user.</td>
                </tr>
                <tr>
                    <td><code>stars</code></td>
                    <td>integer</td>
                    <td>The number of posts starred by this user.</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td><code>follows_you</code></td>
        <td>boolean</td>
        <td>Does this user follow the user making the request? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>you_follow</code></td>
        <td>boolean</td>
        <td>Does the user making the request follow this user? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>you_muted</code></td>
        <td>boolean</td>
        <td>Has the user making the request blocked this user? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>annotations</code></td>
        <td>list</td>
        <td>Metadata about the user. See the <a href="annotations.md">annotations documentation</a>.</td>
    </tr>
</table>

### Deprecations

* ```is_following```, ```is_follower```, and ```is_muted``` have all been deprecated and replaced with ```follows_you```, ```you_follow```, and ```you_muted```. These keys should not be used and will be removed from the User object soon.

## Images
Images are objects so that app developers can more easily pick the appropriated sized image for different contexts.

~~~ js
{
    "height": 512,
    "width": 512,
    "url": "https://example.com/image.jpg"
}
~~~

Images may be dynamically resized on the server by adding `w` and/or `h` parameters to the query string of the URL as desired. If
one of the parameters is omitted, the omitted dimension will be scaled according to the aspect ratio of the original image. Images
will be returned with HTTPS URLs, but can be fetched over HTTP if desired.

**Currently, gif images can not be resized with the ```w``` and ```h``` parameters.**

A user's avatar and cover images can be [directly requested](../resources/users.md#retrieve-a-users-avatar-image) without requesting the entire user object.

## Interacting with individual Users

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Authentication Required?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#retrieve-a-user">Retrieve a User</a></td>
            <td>/stream/0/users/[user_id]</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#update-a-user">Update a User</a></td>
            <td>/stream/0/users/me</td>
            <td>PUT</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#retrieve-a-users-avatar-image">Retrieve a User's avatar image</a></td>
            <td>/stream/0/users/[user_id]/avatar</td>
            <td>GET</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#update-a-users-avatar-image">Update a User's avatar image</a></td>
            <td>/stream/0/users/me/avatar</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#retrieve-a-users-cover-image">Retrieve a User's cover image</a></td>
            <td>/stream/0/users/[user_id]/cover</td>
            <td>GET</td>
            <td>No</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#update-a-users-cover-image">Update a User's cover image</a></td>
            <td>/stream/0/users/me/cover</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#follow-a-user">Follow a User</a></td>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#unfollow-a-user">Unfollow a User</a></td>
            <td>/stream/0/users/[user_id]/follow</td>
            <td>DELETE</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#mute-a-user">Mute a User</a></td>
            <td>/stream/0/users/[user_id]/mute</td>
            <td>POST</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#unmute-a-user">Unmute a User</a></td>
            <td>/stream/0/users/[user_id]/mute</td>
            <td>DELETE</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>

## Retrieving lists of Users

<table>
    <thead>
        <tr>
            <th>Description</th>
            <th>Path</th>
            <th>HTTP Method</th>
            <th>Authentication Required?</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#search-for-users">Search for Users</a></td>
            <td>/stream/0/users/search</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#retrieve-multiple-users">Retrieve multiple Users</a></td>
            <td>/stream/0/users</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-a-user-is-following">Retrieve Users a User is following</a></td>
            <td>/stream/0/users/[user_id]/following</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-user-ids-a-user-is-following">Retrieve IDs of Users a User is following</a></td>
            <td>/stream/0/users/[user_id]/following/ids</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-following-a-user">Retrieve Users following a User</a></td>
            <td>/stream/0/users/[user_id]/followers</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-user-ids-following-a-user">Retrieve IDs of Users following a User</a></td>
            <td>/stream/0/users/[user_id]/followers/ids</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-muted-users">Retrieve Users muted by the current User</a></td>
            <td>/stream/0/users/me/muted</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-user-interactions-with-me">Retrieve Interactions with the current User</a></td>
            <td>/stream/0/users/me/interactions</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-who-have-reposted-a-post">Retrieve Users who reposted a Post</a></td>
            <td>/stream/0/posts/[post_id]/reposters</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td><a href="/appdotnet/api-spec/blob/master/resources/users.md#list-users-who-have-starred-a-post">Retrieve Users who starred a Post</a></td>
            <td>/stream/0/posts/[post_id]/stars</td>
            <td>GET</td>
            <td>Yes</td>
        </tr>
    </tbody>
</table>
