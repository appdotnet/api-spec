# Annotations

Annotations are metadata that are attached to Post when they are created. This allows developers and users to add extra information to the post without interfering with the text content of the Post. Annotations will enable developers to build complex posts and new systems on top of the current App.net infrastructure.

We're really excited to be launching this feature and appreciate any feedback on the following document. Please [open a github issue](https://github.com/appdotnet/api-spec/issues) to contribute to this document.

## Concretely, what are annotations

Let's say I'm at a restaurant eating a great dinner, but instead of just telling my followers about this restaurant I want them to be able to see a map of where it is. My Post could include geographic information about the address for the restaurant and then clients that support this geographic annotation could show the restaurant on a map (in addition to showing my post). If the restaurant is on [OpenTable](http://www.opentable.com), I could include an annotation indicating that and my followers could see the menu and make a reservation in their own App.net client. Annotations are what power complex posts with maps, pictures, videos, etc.

## As a developer, why should I use annotations

To build amazing things. This feature enables new ideas to be built without having to create a brand new API or ecosystem to support the idea. This is the plumbing that will enable new kinds of clients that aren't just about microblogging.

Annotations are how App.net will do reposting, geographic information, attaching media to posts, and lots of other things that our 3rd party developers will create.

## How do I use annotations

### As a non-developer

Right now, we're still working with developers to build out this system. As App.net clients and apps are developed that support annotations, we'll be updating everyone on App.net.

### As a developer

**We're still working on updating all the sample Posts in the spec to show this annotations format.**

First here are some of the more technical details of annotations:

- Each annotation can be thought of as a dictionary or JSON object.
- Each Post is allowed at most 8192 bytes worth of annotations (in total, when serialized as JSON).
- Annotations are immutable and can only be added to a Post at creation time.

#### Annotation format

Here's a sample post with annotations:

```js
{
    "annotations": [
        {
            "type": "com.example.awesome",
            "value": {
                "annotations work": "beautifully"
            }
        }
    ],
    "created_at": "2012-08-30T23:30:14Z",
    "entities": {
        "hashtags": [],
        "links": [],
        "mentions": []
    },
    "html": "<span itemscope=\"https://app.net/schemas/Post\">first annotation post</span>",
    "id": "1",
    "num_replies": 0,
    "num_reposts": 0,
    "num_stars": 0,
    "source": {
        "link": "https://join.app.net/",
        "name": "App.net"
    },
    "text": "first annotation post",
    "thread_id": "1255",
    "user": {...},
    "you_reposted": false,
    "you_starred": false
}
```

The ```post.annotations``` field will be a list of individual annotation objects.

<table>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>type</code></td>
        <td>string</td>
        <td>A string that looks like a reversed domain name to identify the data format for this annotation. <em>There is no authentication or authorization performed on this field. Just because you create annotations with the type <code>com.example.awesome</code> does not imply you are the only one that is using that namespace or that the <code>value</code> will match the format you expect.</em></td>
    </tr>
    <tr>
        <td><code>value</code></td>
        <td>object</td>
        <td>A complex object containing the metadata for this annotation. <em>Be extremely careful with this data, except for well known annotations, no validation is performed on this field.</em></td>
    </tr>
</table>


#### Creating annotations

Annotations are currently live on in the API. To create them you must give App.net a well-formed JSON encoded post that matches the [Post schema](https://github.com/appdotnet/api-spec/blob/master/objects.md#post). Please see the [Create Post](https://github.com/appdotnet/api-spec/blob/master/resources/posts.md#create-a-post) documentations for more information.

#### Displaying annotations

Every client can choose if/how it chooses to display annotations. As stated above be very careful when consuming this data and **do not assume that it follows a specific schema.** Treat data in annotations as untrusted data. Program defensively: your app should not crash or otherwise throw an error if it receives a string where there is usually a dictionary, etc. App.net will coordinate with the community to define schemas for common annotation formats. They will live under the ```net.app.core.*``` namespace. This is the only restricted annotation namespace. Any annotation in this namespace must be validated by the API against a [published schema](#core-annotations). Outside of this namespace, developers may create annotations in either the ```net.app.[username]``` namespace or a reversed-domain namespace of their choosing.

Since annotations can be up to 8192 bytes, they are not included with posts by default. When you make a request for posts, you can include the parameter ```include_annotations=1``` to receive the annotations object. See [general Post parameters](https://github.com/appdotnet/api-spec/blob/master/resources/posts.md#general-parameters) for more information.

# Annotations formats

Since annotations are just launching, we invite the community to propose schemas and collaborate on them. App.net is currently working with the community to define common schemas for things like photos, other media, and geographic data. To propose these formats, please [open an issue](https://github.com/appdotnet/api-spec/issues) and tag it with the ```annotations``` label.

Some annotations are core to the platform and their schemas will be [published below](#core-annotations). Other schemas may be useful across multiple App.net apps, but not be "core" to the platform. The community has started a page on the [App.net API wiki](https://github.com/appdotnet/api-spec/wiki/Annotations) to catalog these common non-core annotations.

We will be defining core annotations soon for the following types of data:

* Media enclosures, e.g., photos, video, etc.
* Long-form content
* Attribution and source
* Additional content license grants, where users can opt in to Creative Commons licensing, etc., if desired.

Developers are invited to create ad-hoc annotations for data not well represented here; if possible, care should be taken not to overlap with existing annotations. If possible, Posts with ad-hoc annotations designed to address edge-cases in well-known annotations should include both the well-known annotation and only the augmented parts in the ad-hoc annotation.

## Core Annotations

* [Crosspost](#crosspost): net.app.core.crosspost
* [Embedded Media](#embedded-media): net.app.core.oembed
* [Language](#language): net.app.core.language
* [Geolocation](#geolocation): net.app.core.geolocation

### Crosspost

> net.app.core.crosspost

The crosspost annotation is meant to specify the original or canonical source of a Post on App.net from somewhere else on the web.

#### Example

```js
{
    "type": "net.app.core.crosspost",
    "value": {
        "canonical_url": "https://twitter.com/AppDotNet/status/234705338849443840",
    }
}
```
#### Fields

<table>
    <tr>
        <th>Field</th>
        <th>Required?</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>canonical_url</code></td>
        <td>Required</td>
        <td>string</td>
        <td>A valid URL pointing to the source of the original content.</td>
    </tr>
</table>

### Embedded Media

> net.app.core.oembed

The embedded media annotation specifies an image, video, or other rich content that should be displayed with this post. It uses the [JSON oEmbed specification](http://oembed.com). We only support the ```photo```, ```video```, and ```rich``` oEmbed types.

We highly recommend providing the ```embeddable_url``` attribute so other clients can request different oEmbed details for this object from the original oEmbed provider (if there is one).

#### Examples

##### Photo

```js
{
    "type": "net.app.core.oembed",
    "value": {
        "version": "1.0",
        "type": "photo",
        "width": 240,
        "height": 160,
        "title": "ZB8T0193",
        "url": "http://farm4.static.flickr.com/3123/2341623661_7c99f48bbf_m.jpg",
        "author_name": "Bees",
        "author_url": "http://www.flickr.com/photos/bees/",
        "provider_name": "Flickr",
        "provider_url": "http://www.flickr.com/",
        "embeddable_url": "http://www.flickr.com/photos/bees/2341623661/"
    }
}
```

##### Video

```js
{
    "type": "net.app.core.oembed",
    "value": {
        "version": "1.0",
        "type": "video",
        "provider_name": "YouTube",
        "provider_url": "http://youtube.com/",
        "width": 425,
        "height": 344,
        "title": "Amazing Nintendo Facts",
        "author_name": "ZackScott",
        "author_url": "http://www.youtube.com/user/ZackScott",
        "html":
            "<object width=\"425\" height=\"344\">
                <param name=\"movie\" value=\"http://www.youtube.com/v/M3r2XDceM6A&fs=1\"></param>
                <param name=\"allowFullScreen\" value=\"true\"></param>
                <param name=\"allowscriptaccess\" value=\"always\"></param>
                <embed src=\"http://www.youtube.com/v/M3r2XDceM6A&fs=1\"
                    type=\"application/x-shockwave-flash\" width=\"425\" height=\"344\"
                    allowscriptaccess=\"always\" allowfullscreen=\"true\"></embed>
            </object>",
        "embeddable_url": "http://youtube.com/watch?v=M3r2XDceM6A"
    }
}

```

##### Rich

```js
{
    "type": "net.app.core.oembed",
    "value": {
        "provider_url": "http://soundcloud.com",
        "description": "Listen to Merenti - La Karambaa by M\u00e9renti | Create, record and share the sounds you create anywhere to friends, family and the world with SoundCloud, the world's largest community of sound creators.",
        "title": "Merenti - La Karambaa by M\u00e9renti",
        "html": "<iframe width=\"500\" height=\"166\" scrolling=\"no\" frameborder=\"no\" src=\"http://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F6733249&show_artwork=true&maxwidth=900\"></iframe>",
        "author_name": "M\u00e9renti",
        "height": 166,
        "width": 500,
        "thumbnail_url": "http://i1.sndcdn.com/artworks-000003051440-mm2z46-t500x500.jpg?d95e793",
        "thumbnail_width": 500,
        "version": "1.0",
        "provider_name": "SoundCloud",
        "type": "rich",
        "thumbnail_height": 500,
        "author_url": "http://soundcloud.com/mrenti"
        "embeddable_url": "http://soundcloud.com/mrenti/merenti-la-karambaa"
    }
}

```
#### Fields

**To correspond with the oEmbed spec, this annotation accepts keys that are not specified below.**

<table>
    <tr>
        <th>Field</th>
        <th>Required?</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>type</code></td>
        <td>Required</td>
        <td>string</td>
        <td><code>photo</code>, <code>video</code>, or <code>rich</code> corresponding to the oEmbed type.</td>
    </tr>
    <tr>
        <td><code>version</code></td>
        <td>Required</td>
        <td>string</td>
        <td>Must be <code>1.0</code>.</td>
    </tr>
    <tr>
        <td><code>width</code></td>
        <td>Required</td>
        <td>integer</td>
        <td>The width in pixels needed to display the embeddable content.</td>
    </tr>
    <tr>
        <td><code>height</code></td>
        <td>Required</td>
        <td>integer</td>
        <td>The height in pixels needed to display the embeddable content.</td>
    </tr>
    <tr>
        <td><code>url</code></td>
        <td>Required if <code>type="photo"</code></td>
        <td>string</td>
        <td>The source URL for the image.</td>
    </tr>
    <tr>
        <td><code>html</code></td>
        <td>Required if <code>type="video"</code> or <code>type="rich"</code></td>
        <td>string</td>
        <td>The HTML to display the rich or video content. It should have no margins or padding. App.net does <strong>no validation</strong> of of this field. Please program defensively. You may wish to load this in an off-domain iframe to avoid XSS vulnerabilities.</td>
    </tr>
    <tr>
        <td><code>embeddable_url</code></td>
        <td>Optional (but recommended)</td>
        <td>string</td>
        <td>A URL that can be given to an oEmbed provider to recreate the oEmbed data contained in this annotation. This is useful so other clients can get updated information or retrieve a different sized embedding through an oEmbed endpoint.</td>
    </tr>
    <tr>
        <td><code>title</code></td>
        <td>Optional</td>
        <td>string</td>
        <td>A title for this embedded content.</td>
    </tr>
    <tr>
        <td><code>author_name</code></td>
        <td>Optional</td>
        <td>string</td>
        <td>The author of this embedded content.</td>
    </tr>
    <tr>
        <td><code>author_url</code></td>
        <td>Optional</td>
        <td>string</td>
        <td>The URL for the author of this embedded content.</td>
    </tr>
    <tr>
        <td><code>provider_name</code></td>
        <td>Optional</td>
        <td>string</td>
        <td>The service that provides this embedded content.</td>
    </tr>
    <tr>
        <td><code>provider_url</code></td>
        <td>Optional</td>
        <td>string</td>
        <td>The URL for the service that provides this embedded content.</td>
    </tr>
    <tr>
        <td><code>cache_age</code></td>
        <td>Optional</td>
        <td>integer</td>
        <td>How long (in seconds) should clients cache the embedded content.</td>
    </tr>
    <tr>
        <td><code>thumbnail_url</code></td>
        <td>Optional</td>
        <td>string</td>
        <td>A URL to an image that represents this resource. If this parameter is specified, <code>thumbnail_height</code> and <code>thumbnail_width</code> must also be present.</td>
    </tr>
    <tr>
        <td><code>thumbnail_height</code></td>
        <td>Optional</td>
        <td>string</td>
        <td>The height of the thumbnail image. If this parameter is specified, <code>thumbnail_url</code> and <code>thumbnail_width</code> must also be present.</td>
    </tr>
    <tr>
        <td><code>thumbnail_width</code></td>
        <td>Optional</td>
        <td>string</td>
        <td>The height of the thumbnail image. If this parameter is specified, <code>thumbnail_height</code> and <code>thumbnail_url</code> must also be present.</td>
    </tr>
</table>

### Language

> net.app.core.language

The language annotation allows a User to indicate what language this post was written in.

#### Example

```js
{
    "type": "net.app.core.language",
    "value": {
        "language": "en",
    }
}
```
#### Fields

<table>
    <tr>
        <th>Field</th>
        <th>Required?</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>language</code></td>
        <td>Required</td>
        <td>string</td>
        <td>A valid ISO 639-1 language code. Note that we only accept a subset of language codes right now. Please see <a href="https://github.com/appdotnet/api-spec/wiki/Language-codes">our current list</a> of accepted language codes. If we're missing your language, please <a href="https://github.com/appdotnet/api-spec/issues">open an issue</a>.</td>
    </tr>
</table>

### Geolocation

> net.app.core.geolocation

The geolocation annotation is meant to specify a geographic point on the Earth. It is not meant to specify:

* a human place (city, building, park, "San Francisco", "The Mission", "The Moscone Center"). We're investigating how to efficiently provide this data in the core api.
* paths, regions, or complex geographic shapes. We recommend using a common schema (like [GeoJSON](http://www.geojson.org/)) in your own annotation if you need this kind of solution.

#### Examples

Just the required parameters:
```js
{
    "type": "net.app.core.geolocation",
    "value": {
        "latitude": 74.0064,
        "longitude": 40.7142
    }
}
```

With all optional parameters:
```js
{
    "type": "net.app.core.geolocation",
    "value": {
        "latitude": 74.0064,
        "longitude": 40.7142,
        "altitude": 4400,
        "horizontal_accuracy": 100,
        "vertical_accuracy": 100,
    }
}
```
#### Fields

<table>
    <tr>
        <th>Field</th>
        <th>Required?</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>latitude</code></td>
        <td>Required</td>
        <td>decimal</td>
        <td>The latitude of the geographic location in decimal degrees. Must range from -90 (the South Pole) to 90 (the North Pole).</td>
    </tr>
    <tr>
        <td><code>longitude</code></td>
        <td>Required</td>
        <td>decimal</td>
        <td>The longitude of the geographic location in decimal degrees. Must range from -180 to 180.</td>
    </tr>
    <tr>
        <td><code>altitude</code></td>
        <td>Optional</td>
        <td>decimal</td>
        <td>The altitude (in meters) of the geographic location. Can be negative.</td>
    </tr>
    <tr>
        <td><code>horizontal_accuracy</code></td>
        <td>Optional</td>
        <td>decimal</td>
        <td>The horizontal accuracy (in meters) of the instrument providing this geolocation point. Must be >= 0.</td>
    </tr>
    <tr>
        <td><code>vertical_accuracy</code></td>
        <td>Optional</td>
        <td>decimal</td>
        <td>The vertical accuracy (in meters) of the instrument providing this geolocation point. Must be >= 0.</td>
    </tr>
</table>
