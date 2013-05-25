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

<table class='table table-striped'>
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
            <td>Metadata about the File. See the <a href="/docs/meta/annotations/">Annotations</a> documentation.</td>
        </tr>
        <tr>
            <td><code>complete</code></td>
            <td>boolean</td>
            <td>Is this File considered complete? A File is complete once its contents are set.</td>
        </tr>
        <tr>
            <td><code>created_at</code></td>
            <td>string</td>
            <td>Date/time at which this file was created. Counts when the initial call to create was made, not when the file was marked complete.</td>
        </tr>
        <tr>
            <td><code>derived_files</code></td>
            <td>object</td>
            <td>An object containing any other Files that were created using this File as input. Please see the section on <a href="#derived-files">Derived Files</a> for more information.</td>
        </tr>
        <tr>
            <td><code>file_token</code></td>
            <td>string</td>
            <td>[Optional] A token that can be used to modify a File. Only present upon creation time, if a write file token was specified when fetching this file or if you have the files scope. Please see the section on <a href="#file-authorization">File Authorization</a> for more information.</td>
        </tr>
        <tr>
            <td><code>file_token_read</code></td>
            <td>string</td>
            <td>[Optional] A token that can be used to access a File. Only present when <code>public</code> is <code>true</code> or if a read token was specified when fetching this File. Please see the section on <a href="#file-authorization">File Authorization</a> for more information.</td>
        </tr>
        <tr>
            <td><code>id</code></td>
            <td>string</td>
            <td>Primary identifier for a File. This will be an integer, but it is always expressed as a string to avoid limitations with the way JavaScript integers are expressed.</td>
        </tr>
        <tr>
            <td><code>image_info</code></td>
            <td>object</td>
            <td>
                If this File is an image that App.net can process, then the following information will be included:
                <br>
                <table class='table table-striped'>
                    <tr>
                        <th>Field</th>
                        <th>Type</th>
                        <th>Description</th>
                    </tr>
                    <tr>
                        <td><code>height</code></td>
                        <td>integer</td>
                        <td>The height of the image.</td>
                    </tr>
                    <tr>
                        <td><code>width</code></td>
                        <td>integer</td>
                        <td>The width of the image.</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td><code>kind</code></td>
            <td>string</td>
            <td>In broad terms, what kind of File is this? It can be user specified or it will be automatically guessed based on the File's <code>mime_type</code>. Must be one of: <code>image</code>, or <code>other</code>.</td>
        </tr>
        <tr>
            <td><code>mime_type</code></td>
            <td>string</td>
            <td>The user provided <a href="http://en.wikipedia.org/wiki/MIME">MIME type</a> of the file.</td>
        </tr>
        <tr>
            <td><code>name</code></td>
            <td>string</td>
            <td>The user provided name of the File. All Unicode characters allowed. Maximum length 255 characters.</td>
        </tr>
        <tr>
            <td><code>public</code></td>
            <td>boolean</td>
            <td>Whether or not the file has been explicitly marked public. Files can also be made public by attaching them to other public objects; this flag is not meant to indicate whether there is some public reference to a file.</td>
        </tr>
        <tr>
            <td><code>sha1</code></td>
            <td>string</td>
            <td>A <a href="http://en.wikipedia.org/wiki/SHA-1">SHA1</a> hash of the File contents.</td>
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
                <table class='table table-striped'>
                    <tr>
                        <th>Field</th>
                        <th>Type</th>
                        <th>Description</th>
                    </tr>
                    <tr>
                        <td><code>name</code></td>
                        <td>string</td>
                        <td>Description of the API consumer that created this File.</td>
                    </tr>
                    <tr>
                        <td><code>link</code></td>
                        <td>string</td>
                        <td> Link provided by the API consumer that created this File.</td>
                    </tr>
                    <tr>
                        <td><code>client_id</code></td>
                        <td>string</td>
                        <td>The public client_id of the API consumer that created this File.</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td><code>total_size</code></td>
            <td>int</td>
            <td>The total number of bytes of the File's contents including all derived Files.</td>
        </tr>
        <tr>
            <td><code>type</code></td>
            <td>string</td>
            <td>A string that looks like a reversed domain name to identify the intended purpose of this File. <em>There is no authentication or authorization performed on this field. Just because you create Files with the type <code>com.example.awesome</code> does not imply you are the only one that is using that namespace or that the File contents will match the format you expect</em>. <code>net.app.core</code> is a reserved namespace.</td>
        </tr>
        <tr>
            <td><code>url</code></td>
            <td>string</td>
            <td>The full URL to this File. It may return a 404 if the File has been deleted or if the URL has expired.</td>
        </tr>
        <tr>
            <td><code>url_expires</code></td>
            <td>string</td>
            <td>A <a href="/docs/basics/data-formats/#dates">date and time</a> indicating when the provided <code>url</code> will no longer be valid. If the expiration has passed, please refetch the File or underlying object to get a new URL to use.</td>
        </tr>
        <tr>
            <td><code>url_permanent</code></td>
            <td>string</td>
            <td>[Optional] Permanent URL for a file. Only present when <code>public</code> is <code>true</code>. This will be an HTTP redirect to the file's content. This URL will not need any authentication to retrieve.</td>
        </tr>
        <tr>
            <td><code>url_short</code></td>
            <td>string</td>
            <td>[Optional] Shortened version of <code>url_permanent</code>. Only present when <code>public</code> is <code>true</code>. This will be an HTTP redirect to the file's content. This URL will be of the form <code>https://files.app.net/&lt;smallblob&gt;</code> and will not need any authentication to retrieve. <b>Note:</b> Like the <code>public</code> flag, for optimal user experience, apps should ONLY use this field when they are unable to use another mechanism (e.g., an attachment or oembed annotation) to attach a file to an App.net object.</td>
        </tr>
        <tr>
            <td><code>user</code></td>
            <td>object</td>
            <td>The <a href="/docs/resources/user/">User</a> who created this file.</td>
        </tr>
    </tbody>
</table>

## Derived files

App.net derived files enable you to upload multiple files that are all derivatives of a single primary file. For instance, if you upload an image, you can upload different sized thumbnails of the image. Or you could upload the same video encoded with a different format/at a different resolution to give client different display options. Each derived file is identified by an alphanumeric string called the key. App.net reserves any derived file key starting with `core_`. For legacy reasons, we also reserve the keys `image_thumb_200s` and `image_thumb_960r`.

Derived files will include the keys shown in the example below. Please see [the File Fields documentation](#file-fields) for an explanation of each key.

~~~js
"image_thumb_200s": {
    "mime_type": "image/png",
    "sha1": "be91cb06d69df13bb103a359ce70cf9fba31234a",
    "size": 33803,
    "url": "https://example.com/thumbnail_200s",
    "url_expires": "2013-01-25T03:00:00Z",
}
~~~

### Auto-generated derived files

For some files, App.net will auto generate derived files. *Note: any new auto-generated derived file keys will be prefixed with `core_`.*

* `image_thumb_200s`: When the root file is an image, App.net will generate a 200x200 square thumbnail of the image that shrinks and crops the center square of the image.
* `image_thumb_960r`: When the root file is an image, App.net will scale down the entire image so it fits within a 640x960 pixel bounding box. This thumbnail will not be cropped.

### Custom derived files

Users may include their own derived files when uploading a file with the following rules:

* You may specify up to 32 user defined files.
* Like files, custom derived files are immutable. They may not be updated or deleted from a file.
* If you specify one of the [auto-generated derived file keys](#auto-generated-derived-files), App.net will validate your file matches the defined file schema. Example: `image_thumb_200s` must be an image with a width and height of 200 pixels.
* Custom derived files can only be added to an incomplete file.
* Custom derived files can only be retrieved from a complete file.

#### How to upload custom derived files

##### Custom derived files with a complete file

If you're [creating a complete file](/docs/resources/file/lifecycle/#create-a-file), you can specify custom derived files by including a multipart segment for each custom derived file with the key specified in the name field. For example:


    curl -k -H 'Authorization: BEARER ...' https://alpha-api.app.net/stream/0/files -X POST -F 'type=com.example.test' -F "content=@filename.png;type=image/png" -F "derived_key1=@derived_file1.png;type=image/png" -F "derived_key2=@derived_file2.png;type=image/png"

##### Custom derived files with an incomplete file

If you've [created a file](/docs/resources/file/lifecycle/#create-a-file) without any content, you can upload custom derived files in subsequent requests until you complete the file. For example:

1. Create an incomplete file:

        curl -k -H 'Authorization: BEARER ...' https://alpha-api.app.net/stream/0/files -F 'type=com.example.test'

2. Add custom derived files:

        curl -k -H 'Authorization: BEARER ...' https://alpha-api.app.net/stream/0/files/{FILE_ID}/content/{DERIVED_KEY1} -H 'Content-Type: image/png' -X PUT --data-binary @derived_file1.png
        curl -k -H 'Authorization: BEARER ...' https://alpha-api.app.net/stream/0/files/{FILE_ID}/content/{DERIVED_KEY2} -H 'Content-Type: image/png' -X PUT --data-binary @derived_file2.png

3. Complete the file:

        curl -k -H 'Authorization: BEARER ...' https://alpha-api.app.net/stream/0/files/{FILE_ID}/content -H 'Content-Type: image/png' -X PUT --data-binary @filename.png

## File Authorization

The `files` scope is the primary scope associated with the management of the File API. However, the API is designed such that file uploads are allowed by any scope which potentially allows for the creation or manipulation of annotations. So if your application is designed to create posts on App.net and you wish to add the ability to attach photos to those posts, you do not need to add any new permissions to do so.

An application with the `files` scope can perform all available actions on a user's files. In addition, limited use of the File API is granted to applications with the `post`, `messages`, `public_messages` and `update_profile` scopes.

File tokens are included with file objects as `file_token` and are specified in conjunction with /stream/0/files endpoints by passing a `file_token` query string parameter (regardless of the HTTP method used).

Limited use of the File API is permitted through file tokens. Two types of file tokens exist: **write** tokens and **read-only** tokens. Write file tokens are included in File objects:

* upon creation
* if a file the user owns is retrieved from a file endpoint AND one of the following is true:
    * the requesting application has the `files` scope and no query string parameters have been passed in
    * a writeable file_token query string parameter is passed in

Read file tokens are returned:

* with annotations referencing files
* in File objects if a read token was used to grant access to the file

Write tokens are NEVER returned in annotations. The streaming API does not include file tokens of any kind. File tokens are never a substitute for access tokens. Write file tokens are portable across applications, but not portable between users (nor portable between authenticated and unauthenticated calls.) Read tokens refer internally to a specific permission-granting object, e.g., a post with an oEmbed annotation, and are only valid as long as that object still exists, the current request would have permission to see that object, and that references the requested file. Read tokens are portable between applications, users and authenticated/unauthenticated calls.

In general, file content is made available to other users by referencing it in annotations on other App.net objects, e.g., posts and messages. However, it is also possible to explicitly mark a file as public, which will allow to to be referenced publicly without being attached to another object. You can do this by setting the `public` value to `true` on a file at creation time (or after the fact). Upon doing this, the file will be populated with a `url_permanent` field which will contain a link to the file's content. This link will remain active until the file is no longer set to public.

## Limits

Paid tier accounts receive 10GB total storage, with a 100MB maximum individual file size. Free tier accounts receive 500MB total storage, with a 10MB maximum individual file size. Individual accounts may have earned additional file storage through the invitation system (see this [blog post](http://blog.app.net/2013/02/25/introducing-a-free-tier/)). To determine the used and available space for an individual user, inspect the `storage` field of their [user token](/docs/resources/token/#retrieve-current-token).

## General Parameters

Where noted, File endpoints respond to the following query string parameters:

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
        <tr>
            <td><code>include_private</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should private files be included in the result? (Default: <code>True</code>)</td>
        </tr>
        <tr>
            <td><code>include_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/docs/meta/annotations/">annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_file_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/docs/meta/annotations/">File annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
        <tr>
            <td><code>include_user_annotations</code></td>
            <td>Optional</td>
            <td>integer (0 or 1)</td>
            <td>Should <a href="/docs/meta/annotations/">User annotations</a> be included in the response objects? Defaults to false.</td>
        </tr>
    </tbody>
</table>

Where noted, endpoints that return a stream of Files additionally respond to [pagination parameters](/docs/basics/pagination).

## Attaching Files to other resources

An App.net file can be attached to any resource that allows annotations. You can attach a file to a resource with any annotation by using the [annotation replacement values](/docs/meta/annotations/#annotation-replacement-values). For instance, to attach a photo that you've uploaded as a file to a new post, you would send the following annotations when making your post:

~~~js
[
    {
        "type": "net.app.core.oembed",
        "value": {
            "+net.app.core.file": {
                "file_id": "...the file id you received when you uploaded your file to App.net...",
                "file_token": "...the write file_token you received when you uploaded your file to App.net...",
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
            "file_token_read": "...a new read file_token that represents the file when attached to this post...",
            "file_id": "...the file id...",
            "url_immediate": "<a short-lived URL to the file content>",
            "url_immediate_expires": "2018-01-01T00:00:00Z",
            "type": "photo",
            "version": "1.0",
            ...remaining OEmbed data...
        }
    }
]
~~~

In addition to these replacement annotation values that allow you to embed a file in any (core or 3rd party) annotation, we've also defined an [attachments core annotation](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.attachments.md) as a generic way to attach multiple arbitrary files to a resource.

**Please ensure that you only include your write `file_token` with a replacement annotation. If they are not processed by App.net, they will leak out and no longer be secret.**

When either the `+net.app.core.file` or `+net.app.core.file_list` values are used, each file must be specified as an object with a `file token` and a `format`. Each object is transformed into another object containing `file_id`, a `file_token_read`, and any additional data as specified by the `format` key. If a file is not found or you don't have permission to access it, the `file_id` value returned may not exist (or may not be an integer).

The current valid formats:

* `metadata`: This includes the entire File resource except for the `annotations`, `source`, and `user` fields.
* `oembed`: This includes any oembed data we can generate for this file. This could be empty. This format can only be used with the `net.app.core.oembed` annotation.
* `url`: This includes just a url pointing to this file's contents.

Please see the [File replacement annotation value](https://github.com/appdotnet/object-metadata/blob/master/annotation-replacement-values/+net.app.core.file.md) for more details and examples.

<%= render 'partials/endpoints-tab', :for => "file" %>
