---
title: "File"
---

# File

<%= render 'partials/object-tab' %>

* TOC
{:toc}

A file uploaded by a User and hosted by App.net.

<%= json(:file) %>

## File Fields

<table>
    <thead>
        <tr>
            <th>Field</th>
            <th>Type</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code>annotations</code></td>
            <td>list</td>
            <td>Metadata about the file. See the <a href="/docs/meta/annotations/">Annotations</a> documentation.</td>
        </tr>
        <tr>
            <td><code>complete</code></td>
            <td>boolean</td>
            <td>Is this file considered complete? A file is complete once it's file contents are set for the first time.</td>
        </tr>
        <tr>
            <td><code>derived_files</code></td>
            <td>object</td>
            <td>An object containing any other files that were created using this file as input. Please see the section on <a href="#derived_files">derived files</a> for more information.</td>
        </tr>
        <tr>
            <td><code>file_token</code></td>
            <td>string</td>
            <td>A token that can be used to access or modify a file. Please see the section on <a href="#file_authorization">file authorization</a> for more information.</td>
        </tr>
        <tr>
            <td><code>id</code></td>
            <td>string</td>
            <td>Primary identifier for a file. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
        </tr>
        <tr>
            <td><code>kind</code></td>
            <td>string</td>
            <td>In broad terms, what kind of file is this? It can be user specified or it will be automatically guessed based on the file's <code>mime_type</code>. Must be one of: <code>image</code>, or <code>other</code>.</td>
        </tr>
        <tr>
            <td><code>mime_type</code></td>
            <td>string</td>
            <td>The user provided <a href="http://en.wikipedia.org/wiki/MIME">MIME type</a> of the file.</td>
        </tr>
        <tr>
            <td><code>name</code></td>
            <td>string</td>
            <td>The user provided name of the file.</td>
        </tr>
        <tr>
            <td><code>sha1</code></td>
            <td>string</td>
            <td>A <a href="http://en.wikipedia.org/wiki/SHA-1">SHA1</a> hash of the file contents.</td>
        </tr>
        <tr>
            <td><code>size</code></td>
            <td>int</td>
            <td>The number of bytes of the file's contents.</td>
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
                        <td>Description of the API consumer that created this file.</td>
                    </tr>
                    <tr>
                        <td><code>link</code></td>
                        <td>string</td>
                        <td>Link provided by the API consumer that created this file.</td>
                    </tr>
                    <tr>
                        <td><code>client_id</code></td>
                        <td>string</td>
                        <td>The public client_id of the API consumer that created this file.</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td><code>total_size</code></td>
            <td>int</td>
            <td>The total number of bytes of the file's contents including all derived files.</td>
        </tr>
        <tr>
            <td><code>type</code></td>
            <td>string</td>
            <td>A string that looks like a reversed domain name to identify the intended purpose of this file. <em>There is no authentication or authorization performed on this field. Just because you create files with the type <code>com.example.awesome</code> does not imply you are the only one that is using that namespace or that the channel ACLs will match the format you expect</em>. <code>net.app.core</code> is a reserved namespace.</td>
        </tr>
        <tr>
            <td><code>url</code></td>
            <td>string</td>
            <td>The full URL to this file. It may return a 404 if a file has been deleted.</td>
        </tr>
        <tr>
            <td><code>url_expires</code></td>
            <td>string</td>
            <td>A <a href="/docs/basics/data-formats/#dates">date and time</a> indicating when the provided <code>url</code> will no longer be valid. If the expiration has passed, please refetch the file or underlying object to get a new url to use.</td>
        </tr>
        <tr>
            <td><code>user</code></td>
            <td>object</td>
            <td>The User who created this file.</td>
        </tr>
    </tbody>
</table>

## Derived Files

When a file is uploaded, App.net may choose to create other files based on the original. A User cannot upload their own derived files. Derived files will include the keys shown in the example below. Please see [the File Fields documentation](#file-fields) for an explanation of each key.

~~~js
"image_thumb_200s": {
    "mime_type": "image/png",
    "sha1": "be91cb06d69df13bb103a359ce70cf9fba31234a",
    "size": 33803,
    "url": "https://example.com/thumbnail_200s",
    "url_expires": "2018-01-01T00:00:00Z",
}
~~~

The current valid derived files are:

* `image_thumb_200s`: When the root file is an image, App.net will generate a 200x200 square thumbnail of the image that shrinks and crops the center square of the image.
* `image_thumb_960r`: When the root file is an image, App.net will scale down the entire image so it fits within a 640x960 pixel bounding box. This thumbnail will not be cropped.

## File Authorization

TODO

## General Parameters

Requests that return streams of files accept the following query string parameters in addition to the [pagination parameters](/docs/resources/post/#general-parameters):

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
            <td><code>file_types</code></td>
            <td>Optional</td>
            <td>string</td>
            <td>A comma separated list of the File types to include. For instance <code>file_types=net.myapp</code> will only return files with a type of <code>net.myapp</code>.</td>
        </tr>
        <tr>
            <td><code>include_incomplete</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should incomplete files be included in the result? (Default: <code>True</code>)</td>
        </tr>
    </tbody>
</table>

## Attaching Files to other resources

An App.net file can be attached to any resource that allows annotations. You can attach a file to a resource with any annotation by using the [annotation replacement values](/docs/meta/annotations/#annotation-replacement-values). For instance, to attach a photo that you've uploaded as a file to a new post, you would send the following annotations when making your post:

~~~js
[
    {
        "type": "net.app.core.oembed",
        "value": {
            "+net.app.core.file": {
                "file_token": ...the file token you received when you uploaded your file to App.net...,
                "format": "oembed"
            }
        }
    }
]
~~~

Then, when your post is returned through the API, App.net will replace that annotation with an OEmbed annotation that represents the referenced file:

~~~js
[
    {
        "type": "net.app.core.oembed",
        "value": {
            "file_token": ...a new file token that represents the file when attached to this post...,
            "file_id": "1",
            "type": "photo",
            "version": "1.0",
            ...remaining OEmbed data...
        }
    }
]
~~~

In addition to these replacement annotation values that allow you to embed a file in any (core or 3rd party) annotation, we've also defined an [attachments core annotation](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.attachments.md) as a generic way to attach multiple arbitrary files to a resource.

**Please ensure that you only upload your `file_token` to a replacement annotation. If they are not processed by App.net they will leak out and no longer be secret.**

When either the `+net.app.core.file` or `+net.app.core.file_list` values are used, each file must be specified as an object with a `file token` and a `format`. Each object is transformed into another object containing `file_id`, a new `file_token`, and any additional data as specified by the `format` key. If a file is not found or you don't have permission to access it, the `file_id` value returned may not exist (or may not be an integer).

The current valid formats:

* `metadata`: This includes the entire File resource except for the `annotations`, `source`, and `user` fields.
* `oembed`: This includes any oembed data we can generate for this file. This could be empty.
* `url`: The includes just a url pointing to this file's contents.

Please see the [File replacement annotation value](https://github.com/appdotnet/object-metadata/blob/master/annotation-replacement-values/+net.app.core.file.md) for more details and examples.

<%= render 'partials/endpoints-tab', :for => "file" %>

