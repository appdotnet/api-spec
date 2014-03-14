---
title: "Annotations"
---

# Annotations

* TOC
{:toc}


## Annotation Fields

~~~ js
{
    "type": "com.example.awesome",
    "value": {
        "annotations work": "beautifully"
    }
}
~~~

<table class='table table-striped'>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>type</code></td>
        <td>string</td>
        <td>A string that looks like a reversed domain name to identify the data format for this annotation. <br><br><div class="alert alert-info">There is no authentication or authorization performed on this field. Just because you create annotations with the type <code>com.example.awesome</code> does not imply you are the only one that is using that namespace or that the <code>value</code> will match the format you expect.</div></td>
    </tr>
    <tr>
        <td><code>value</code></td>
        <td>object</td>
        <td>A complex object containing the metadata for this annotation. <br><br><div class="alert alert-error"><strong>Be extremely careful with this data.</strong> Except for core annotations, no validation is performed on this field.</div></td>
    </tr>
</table>

## Limits

- Each object (User, Post, Channel, Message, File) is allowed at most 8192 bytes worth of annotations (in total, when serialized as JSON).
- Post and Message annotations are immutable and can only be added at creation time.
- A Post or Message can have multiple annotations of the same "type". 
- User and Channel annotations are mutable and can be updated at any time.
- Because they are mutable, a User or Channel object can only have one annotation of each "type".
- User annotations are meant to provide more information about the user. **They are not meant to be an arbitrary data store for apps**.
- Some annotations are read-only and will be ignored or rejected if you try to write to them.

## Creating, Updating and Deleting

For Posts, Messages, Channels, and Files, you can create annotations when you create the object. You must pass JSON objects that include annotations matching the above schema. Please see the documentation for [creating Posts](/reference/resources/post/lifecycle/#create-a-post), [Messages](/reference/resources/message/lifecycle/#create-a-message), [Channels](/reference/resources/channel/lifecycle/#create-a-channel), or [Files](/reference/resources/file/lifecycle/#create-a-file).

To add or update User or Channel annotations, you [update a User's profile](/reference/resources/user/profile/#update-a-user), [update a Channel](/reference/resources/channel/lifecycle/#update-a-channel), or [update a File](/reference/resources/file/lifecycle/#update-a-file) and pass in the annotations you want to add or update. To delete an annotation, omit the `value` key for the annotation type you want to delete. For example, to delete a user's blog url, specify `{"type": "net.app.core.directory.blog"}`.

## Retrieving

Since annotations can be up to 8192 bytes, they are never included by default. When making a request for Users, Posts, Channels, Messages, or Files, you can use the parameter `include_annotations=1` to receive all applicable annotations. When requesting Users or Posts you can use `include_user_annotations=1` or `include_post_annotations=1` to include just those annotations. When requesting Channels or Messages you can use `include_channel_annotations=1` or `include_message_annotations=1` to include just those annotations. When requesting Files you can use `include_file_annotations=1` or `include_user_annotations=1` to include just those annotations.

## Displaying

You are free to choose if and how you render annotations. **Be very careful when consuming this data and do not assume that it follows a specific schema.** Treat data in annotations as untrusted data. Program defensively: your app should not crash or otherwise throw an error if it receives a string where there is usually a dictionary, etc. 

## Namespaces

App.net will coordinate with the community to define schemas for common annotation formats. They will live under the `net.app.core.*` namespace. This is the only restricted annotation namespace for the `type` field. Any annotation in this namespace must be validated by the API against a [published schema](#core-annotations). Outside of this namespace, developers should create annotations in either the `net.app.[username]` namespace or a reversed-domain namespace of their choosing.

In the `value` of any annotation (including non-core annotations), we treat any key that starts with `+net.app.core.*` as a [special replacement value](#annotation-replacement-values). They will be validated against a schema just like the core annotations.

## Documenting annotations

To foster collaboration and adoption, we've set up a [github repository](https://github.com/appdotnet/object-metadata) for documenting annotations. To discuss annotations, please use the associate [issue tracker](https://github.com/appdotnet/object-metadata/issues). For more information on submitting / updating documentation please review the [README](https://github.com/appdotnet/object-metadata).

### Core annotations

Annotations that are considered particularly useful and/or well defined may be promoted to "core". As opposed to general annotations, core annotations are validated server-side to match their documented schemas.

We currently define the following core annotations:

| Name | Type | Description |
| ---- | ---- | ----------- |
| [Attachments](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.attachments.md) | net.app.core.attachments | A pointer to App.net [Files](/reference/resources/file/) that are attached to the object being annotated. |
| [Channel Invite](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.channel.invite.md) | net.app.core.channel.invite | A pointer to a [Channel](/reference/resources/channel/). |
| [Checkin](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.checkin.md) | net.app.core.checkin | Indicates a user has "checked in" to a [Place](/reference/resources/place/). |
| [Phototag](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.phototag.md) | net.app.core.phototag | Indicates a user appears in a photo |
| [Crosspost](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.crosspost.md) | net.app.core.crosspost | Specifies the original or canonical source of a Post on App.net from somewhere else on the web. |
| [Blog URL](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.directory.blog.md) | net.app.core.directory.blog | A pointer to a user's blog. |
| [Facebook ID](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.directory.facebook.md) | net.app.core.directory.facebook | A pointer to a user's Facebook account. |
| [Homepage](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.directory.homepage.md) | net.app.core.directory.homepage | A pointer to a user's homepage. |
| [Twitter Username](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.directory.twitter.md) | net.app.core.directory.twitter | A pointer to a user's Twitter account. |
| [Fallback URL](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.fallback_url.md) | net.app.core.fallback_url | A pointer to a destination that can properly display the associated content. |
| [Geolocation](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.geolocation.md) | net.app.core.geolocation | Specifies a geographic point on the Earth. |
| [Language](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.language.md) | net.app.core.language | Specifies a language. |
| [Embedded Media](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.oembed.md) | net.app.core.oembed | Provides information for displaying an image, video, or other rich content. |
| [oEmbed Metadata](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.oembed.metadata.md) | net.app.core.oembed.metadata | Provides information for generating an oEmbed representation of a file. |
{: .table .table-striped}

If you are interested in proposing another annotation, please [open an issue](https://github.com/appdotnet/object-metadata/issues).

Developers are encouraged to create annotations for data not well represented here. If possible, care should be taken not to overlap with existing annotations. Annotations designed to address edge-cases in well-known annotations should include both the well-known annotation and only the augmented parts in the enhancing annotation.

## Replacement values

When App.net processes annotation values, any value with a key that starts with `+net.app.core.*` will be rewritten based on the core schemas defined below. For example, when attaching a File to a Post, you might send App.net the following annotation:

~~~js
{
    "type": "com.example.my_own_annotation",
    "value": {
        "+net.app.core.file": {
            "file_id": "1",
            "format": "url",
            "file_token": "12345abcdef"
        },
        "foo": "bar"
    }
}
~~~

As explained in the [schema for the `net.app.core.file` value](https://github.com/appdotnet/object-metadata/blob/master/annotation-replacement-values/+net.app.core.file.md), this annotation will be rewritten when the Post is requested from the API:

~~~js
{
    "type": "com.example.my_own_annotation",
    "value": {
        "file_id": "1",
        "file_token": "12345abcdef",
        "foo": "bar",
        "url": "http://example.com/link_to_file",
        "url_expires": "2013-01-25T03:00:00Z"
    }
}
~~~

We currently define the following replacement values in annotations:

| Name | Key | Description |
| ---- | --- | ----------- |
| [File](https://github.com/appdotnet/object-metadata/blob/master/annotation-replacement-values/+net.app.core.file.md) | +net.app.core.file | Add information about an App.net [File](/reference/resources/file/) to an annotation. |
| [File List](https://github.com/appdotnet/object-metadata/blob/master/annotation-replacement-values/+net.app.core.file_list.md) | +net.app.core.file_list | Add information about a list of App.net [Files](/reference/resources/file/) to an annotation. |
| [Place](https://github.com/appdotnet/object-metadata/blob/master/annotation-replacement-values/+net.app.core.place.md) | +net.app.core.place | Add information about a [Place](/reference/resources/place/) to an annotation. |
| [User](https://github.com/appdotnet/object-metadata/blob/master/annotation-replacement-values/+net.app.core.user.md) | +net.app.core.user | Add information about a [User](/reference/resources/user/) to an annotation. |
{: .table .table-striped}
