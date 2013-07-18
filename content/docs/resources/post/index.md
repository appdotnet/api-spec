---
title: "Post"
---

# Post

<%= render 'partials/object-tab' %>

* TOC
{:toc}

A Post is the other central object utilized by the App.net Stream API. It has rich text and annotations which comprise all of the content a users sees in their feed. Posts are closely tied to the follow graph. If you want to create data that isn't tied to the follow graph, you should look at [Messages](/docs/resources/message/).

~~~ js
{
    "id": "1", // note this is a string
    "user": {
        ...
    },
    "created_at": "2012-07-16T17:25:47Z",
    "text": "@berg FIRST post on this new site #newsocialnetwork",
    "html": "<span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.",
    "source": {
        "name": "Clientastic for iOS",
        "link": "http://app.net"
    },
    "machine_only": false,
    "reply_to": null,
    "thread_id": "1",
    "canonical_url": "https://alpha.app.net/mthurman/post/1",
    "num_replies": 3,
    "num_reposts": 1,
    "num_stars": 1,
    "annotations": [
        {
            "type": "net.app.core.geolocation",
            "value": {
                "latitude": 74.0064,
                "longitude": 40.7142,
            }
        }
    ],
    "entities": {
        "mentions": [{
            "name": "berg",
            "id": "2",
            "pos": 0,
            "len": 5
        }],
        "hashtags": [{
            "name": "newsocialnetwork",
            "pos": 34,
            "len": 17
        }],
        "links": [{
            "text": "this new site",
            "url": "https://join.app.net"
            "pos": 20,
            "len": 13
        }]
    },
    "you_reposted": true,
    "you_starred": false,
    "reposters": [
        ...user...
    ],
    "starred_by": [
        ...users...
    ]
}
~~~

## Post Fields

<table class='table table-striped'>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>id</code></td>
        <td>string</td>
        <td>Primary identifier for a post. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
    </tr>
    <tr>
        <td><code>user</code></td>
        <td>object</td>
        <td>This is an embedded version of the <a href="/docs/resources/user/">User</a> object. <b>Note:</b> In certain cases (e.g., when a user
                account has been deleted), this key may be omitted.</td>
    </tr>
    <tr>
        <td><code>created_at</code></td>
        <td>string</td>
        <td>The time at which the post was create in <a href='http://en.wikipedia.org/wiki/ISO_8601'>ISO 8601</a> format.</td>
    </tr>
    <tr>
        <td><code>text</code></td>
        <td>string</td>
        <td>User supplied text of the post. All Unicode characters allowed. Maximum length 256 characters.</td>
    </tr>
    <tr>
        <td><code>html</code></td>
        <td>string</td>
        <td>Server-generated annotated HTML rendering of post text.</td>
    </tr>
    <tr>
        <td><code>source</code></td>
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
                    <td><code>name</code></td>
                    <td>string</td>
                    <td>Description of the API consumer that created this post.</td>
                </tr>
                <tr>
                    <td><code>link</code></td>
                    <td>string</td>
                    <td>Link provided by the API consumer that created this post.</td>
                </tr>
                <tr>
                    <td><code>client_id</code></td>
                    <td>string</td>
                    <td>The public client_id of the API consumer that created this post.</td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td><code>reply_to</code></td>
        <td>string</td>
        <td>The id of the post this post is replying to (or <code>null</code> if not a reply).</td>
    </tr>
    <tr>
        <td><code>canonical_url</code></td>
        <td>string</td>
        <td>The URL of the post's detail page on Alpha.</td>
    </tr>
    <tr>
        <td><code>thread_id</code></td>
        <td>string</td>
        <td>The id of the post at the root of the thread that this post is a part of. If <code>thread_id==id</code> than this property does not guarantee that the thread has > 1 post. Please see <code>num_replies</code>.</td>
    </tr>
    <tr>
        <td><code>num_replies</code></td>
        <td>integer</td>
        <td>The number of posts created in reply to this post.</td>
    </tr>
    <tr>
        <td><code>num_stars</code></td>
        <td>integer</td>
        <td>The number of users who have starred this post.</td>
    </tr>
    <tr>
        <td><code>num_reposts</code></td>
        <td>integer</td>
        <td>The number of users who have reposted this post.</td>
    </tr>
    <tr>
        <td><code>annotations</code></td>
        <td>list</td>
        <td>Metadata about the entire post. See the <a href="/docs/meta/annotations/">Annotations</a> documentation.</td>
    </tr>
    <tr>
        <td><code>entities</code></td>
        <td>object</td>
        <td>Rich text information for this post. See the <a href="/docs/meta/entities/">Entities</a> documentation.</td>
    </tr>
    <tr>
        <td><code>is_deleted</code></td>
        <td>boolean</td>
        <td>Has this post been deleted? For non-deleted posts, this key may be omitted instead of being <code>false</code>. If a post has been deleted, the <code>text</code>, <code>html</code>, and <code>entities</code> properties will be empty and may be omitted.</td>
    </tr>
    <tr>
        <td><code>machine_only</code></td>
        <td>boolean</td>
        <td>Is this Post meant for humans or other apps? See <a href="#machine-only-posts">Machine only Posts</a> for more information.</td>
    </tr>
    <tr>
        <td><code>you_starred</code></td>
        <td>boolean</td>
        <td>Have you starred this Post? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>starred_by</code></td>
        <td>list</td>
        <td>A partial list of users who have starred this post. This is not comprehensive and is meant to be a sample of users who have starred this post giving preference to users the current user follows. This is only included if <code>include_starred_by=1</code> is passed to App.net. May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>you_reposted</code></td>
        <td>boolean</td>
        <td>Have you reposted this Post? May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>reposters</code></td>
        <td>list</td>
        <td>A partial list of users who have reposted this post. This is not comprehensive and is meant to be a sample of users who have starred this post giving preference to users the current user follows. This is only included if <code>include_reposters=1</code> is passed to App.net. May be omitted if this is not an authenticated request.</td>
    </tr>
    <tr>
        <td><code>repost_of</code></td>
        <td>Post object</td>
        <td>If this post is a repost, this key will contain the complete original Post.</td>
    </tr>
</table>

### Deprecations

* ```deleted``` has been deprecated and replaced with ```is_deleted```. This key should not be used and will be removed from the Post object soon.

## Post Annotations
Post annotations are immutable attributes that describe the entire post. Please see the [Annotations](/docs/meta/annotations/) documentation for more information.

## Machine only Posts
Some posts with annotations data may not be meant for direct consumption by a User. For example, a chess app may create Posts with annotations representing chess moves but having human readable text doesn't make sense. Machine only Posts solve this problem by allowing clients to create posts with ```annotations``` and without ```text```. These posts must be specifically asked for by using the ```include_machine=1``` query string parameter. They must contain at least one annotation and cannot contain any text. When deciding if a Post should be machine only, ask yourself "Would this Post make sense to a human?"

## General parameters

Where noted, Post endpoints respond to the following query string parameters:

<table class='table table-striped'>
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
            <td><code>include_muted</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should Posts from muted users be included? Defaults to false except when you specifically request a Post from a muted user or when you specifically request a muted user's stream.</td>
        </tr>
        <tr>
            <td><code>include_deleted</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should deleted Posts be included? Defaults to true.</td>
        </tr>
        <tr>
            <td><code>include_directed_posts</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should Posts directed at people I don't follow be included? A directed Post is a Post that has leading mentions (mentions at the beginning of the text). A machine only Post with mentions is also considered a directed Post. Defaults to false for "My Stream" and true everywhere else.</td>
        </tr>
        <tr>
            <td><code>include_machine</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="#machine-only-posts">machine only Posts</a> be included? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_starred_by</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should a sample of Users who have starred a Post be returned with the Post objects? Please see the <a href="/docs/resources/post/">Post schema</a>. Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_reposters</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should a sample of Users who have reposted a Post be returned with the Post objects? Please see the <a href="/docs/resources/post/">Post schema</a>. Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/docs/meta/annotations/">annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_post_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/docs/meta/annotations/">Post annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_user_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/docs/meta/annotations/">User annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_html</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should the <a href="/docs/resources/post/#post-fields"><code>html</code> field</a> be included alongside the <code>text</code> field in the response objects? Defaults to true.</td>
        </tr>
    </tbody>
</table>

Where noted, endpoints that return a stream of Posts additionally respond to [pagination parameters](/docs/basics/pagination).

## Sorting Posts

Post `id` is the ordering field for multiple posts, not `created_at`. `created_at` is meant to be displayed to users, not to sort Posts. This also makes pagination with `since_id` and `before_id` more straightforward. Posts are presently always returned in reverse chronological order (newest to oldest). As a result, the Posts endpoints will always return the newest posts that meet the requested criteria (e.g. `before_id` and `count`).

<%= render 'partials/endpoints-tab', :for => "post" %>
