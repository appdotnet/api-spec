# Feeds

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
            <td><a href="">Retrieve a feed for a hashtag</a></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td><a href="">Retrieve a feed for a User</a></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
    </tbody>
</table>

## General Information

### Basic Use

Feeds describe our system for simple syndication of public posts on App.net. We currently support RSS as a syndication format. This means you should be able to use them anywhere you currently use RSS feeds.

There are 2 different kinds of feeds, but they all follow the same pattern:

* Users Post feed: A feed for a single User's public posts on App.net. This is a feed version of the [Retrieve Posts created by a User](/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-posts-created-by-a-user) endpoint.
* Hashtag feed: A feed containing all public Posts that are tagged with a specific hashtag. This is a feed version of the [Retrieve tagged Posts](/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-tagged-posts) endpoint.

We intend to support more feed formats and richer support for filters in the near future.

*Note:* While the URLs are similar to other API URLs feeds, they are under a different root.

### Filters

Feeds do not currently support filters or general parameters like the JSON API.

### Response Format

All responses are returned as RSS. We are following the spec for RSS 2.0 as described in the [RSS 2.0 specification](http://cyber.law.harvard.edu/rss/rss.html).

## Retrieve a feed for a User

Retrieve a [feed](#feeds) for the User [@voidfiles](http://alpha.app.net/voidfiles). This endpoint is similar to the '[Retrieve Posts created by a User](/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-posts-created-by-a-user)' endpoint.

### URL
> https://alpha-api.app.net/feed/rss/users/@username/posts

### Example

> GET https://alpha-api.app.net/feed/rss/users/@voidfiles/posts

~~~ xml
<?xml version='1.0' encoding='utf-8'?>
<rss xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
    <channel>
        <title>Posts from voidfiles on App.net</title>
        <link>https://alpha.app.net/voidfiles</link>
        <description>Hi, I work at App.net</description>
        <atom:link href="https://alpha-api.app.net/feed/rss/users/@voidfiles/posts" type="application/rss+xml"/>
        <image>
            <title>Posts from voidfiles on App.net</title>
            <link>https://alpha.app.net/voidfiles</link>
            <url>https://dqdwyydysypcm.cloudfront.net/image/4/Go50UQd5N9mi_APkpQt9JAp4ZsDfMlOTnoB4P-0N5rmpFGtnro2b52yUcUr_bPbxKlxx_4EHHiujdE-RRpSB6oZd0bHGy4xKlwInNBClbebDS7DoyyPHtIK9LY5x-kQSdnPKyKhtogJxD04SGOQMLPkCasZM42nLVgZIIhcbmbBrzxNJaoRoCNOrzS1ib9fQcAwPEg</url>
        </image>
        <item>
            <title>voidfiles: #hashtag test</title>
            <description>
                <span itemscope="https://join.app.net/schemas/Post"><a href="https://alpha.app.net/hashtags/hashtag" itemprop="hashtag" data-hashtag-name="hashtag">#hashtag</a> test</span>
            </description>
            <pubDate>Fri, 31 Aug 2012 17:15:31 +0000</pubDate>
            <guid>https://alpha.app.net/voidfiles/post/1387</guid>
            <link>https://alpha.app.net/voidfiles/post/1387</link>
            <category>hashtag</category>
        </item>
    </channel>
</rss>
~~~

## Retrieve a feed for a hashtag

Retrieve a [feed](#feed) for the specified hashtag. This endpoint is similar to the '[Retrieve tagged Posts](/appdotnet/api-spec/blob/master/resources/posts.md#retrieve-tagged-posts)' endpoint.

### URL
> https://alpha-api.app.net/feed/rss/posts/tag/hashtag

### Example
> GET https://alpha-api.app.net/feed/rss/posts/tag/hashtag

~~~ xml
<?xml version='1.0' encoding='utf-8'?>
<rss xmlns:atom="http://www.w3.org/2005/Atom" version="2.0">
    <channel>
        <title>#hashtag - App.net</title>
        <link>https://alpha.app.net/hashtags/hashtag</link>
        <description>Posts about #hashtag</description>
        <atom:link href="https://alpha-api.app.net/feed/rss/posts/tag/hashtag" type="application/rss+xml"/>
        <item>
            <title>voidfiles: #hashtag test</title>
            <description>
                <span itemscope="https://join.app.net/schemas/Post"><a href="https://alpha.app.net/hashtags/hashtag" itemprop="hashtag" data-hashtag-name="hashtag">#hashtag</a> test</span>
            </description>
            <pubDate>Fri, 31 Aug 2012 17:15:31 +0000</pubDate>
            <guid>https://alpha.app.net/voidfiles/post/1387</guid>
            <link>https://alpha.app.net/voidfiles/post/1387</link>
            <category>hashtag</category>
        </item>
    </channel>
</rss>
~~~