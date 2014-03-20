---
title: "Using Annotations"
---

# Using Annotations

* TOC
{:toc}

Annotations are metadata that can be attached to Users, Posts, Channels, Messages, or Files. This allows developers and users to add extra information to App.net objects outside of the fields App.net has already defined.

## What's so great about annotations?

Annotations give developers a tremendous degree of freedom to expand upon the core functionality of App.net. They provide a way for developers to add arbitrary data to App.net objects, enabling richer content and new services.

Let's say I'm at a restaurant eating a great dinner, but instead of just telling my followers about this restaurant I want them to be able to see a map of where it is. My Post could include geographic information about the address for the restaurant in an annotation and then clients that support this geographic annotation could show the restaurant on a map (in addition to showing my post). If the restaurant is on [OpenTable](http://www.opentable.com), I could include an annotation indicating that and my followers could see the menu and make a reservation in their own App.net client.

## Anatomy of an annotation

Annotations are a list of objects that have a `type` and a `value`.

<%= json_output([
    {
        "type" => "com.example.awesome",
        "value" => {
            "annotations work" => "beautifully"
        }
    }
]) %>

The `type` field identifies essentially a schema for the `value` of the annotation. Please see the [annotations reference](/reference/meta/annotations/#documenting-annotations) for more information about different kinds of annotations.

## Example: Attach an image to a post

When you see an image included in an App.net post, you see the results of annotations at work. We'll be using the [`net.app.core.oembed`](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.oembed.md) annotation to embed a photo in an App.net post.

<% data = {
    "text" => "Hello App.net from curl, with a photo!",
    "annotations" => [
      {
        "type" => "net.app.core.oembed",
        "value" => {
          "type" => "photo",
          "version" => "1.0",
          "width" => 870,
          "height" => 106,
          "url" => "https://files.app.net/2jxk2CoP4",
          "thumbnail_width" => 200,
          "thumbnail_height" => 24,
          "thumbnail_url" => "https://files.app.net/2jxk12R7F",
          "embeddable_url" => "https://app.net"
        }
      }
    ]
} %>
<%= curl_example(:post, "posts?include_annotations=1", :none, {:data => data}) %>

Most clients expect `thumbnail_url`, `thumbnail_width`, and `thumbnail_height` to render a preview inline with the post.

## Example: Attach an App.net file to a post as an image

Most apps that include images don't generate a raw oembed annotation to an image hosted somewhere else, they use the [App.net File storage](/reference/resources/files/). To do this, first you have to upload a file to App.net and then you have to create the post with an annotation as we did above.

### Upload a file

<%= curl_example(:post, "files", :none, {
    :files => {
        "type" => "testing.image",
        "content" => "@filename.png;type=image/png",
    }
}) %>


This will return a JSON blob similar with the following fields we care about:

<%= json_output({
    "data" => {
        "file_token" => "1234567NQD4isqELTZlIiEd9fp24e5wC1NACSYFI_Svc7-hkvCKWOTsOPQLrrMiVu-9x2L400MbKlG4T8-WA97HokUdApqXwtQjJt9wOJ12ZZX_hZSFmj_O0xFlvJt8rwqaTAOvK7qECaj1LS131baLjJojErPB5TwZiQQJko0BU",
        "id" => "123",
    },
}) %>

### Attach the file to a post

Once we've uploaded the file, we can attach it to a post and let App.net generate the correct oembed annotation:

<% data = {
    "text" => "Hello App.net from curl, with an App.net hosted photo!",
    "annotations" => [{
        "type" => "net.app.core.oembed",
        "value" => {
            "+net.app.core.file" => {
                "file_id" => "<data.file_id from the last command>",
                "file_token" => "<data.file_token from the last command>",
                "format" => "oembed"
            }
        }
    }]
} %>
<%= curl_example(:post, "posts?include_annotations=1", :none, {:data => data}) %>

Since annotations can contain up to [8192 bytes of data](/reference/meta/annotations/#limit), they are not returned by default. We have to explicitly request that App.net return annotations by passing the `include_annotations=1` query string parameter.
