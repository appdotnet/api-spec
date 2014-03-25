---
title: "oEmbed"
---

# oEmbed

oEmbed is an open standard for turning a URL into an embeddable piece of content for your site. To find out more about oEmbed [read the spec](http://www.oembed.com/). The App.net oEmbed endpoint will return HTML snippets that you can include on your site. Right now it works for individual posts, and photos.


## oEmbed Endpoint

Returns an oEmbed response for a given URL.

<%= endpoint "GET", "oembed", "None", '', '' %>

<%= url_params [
  ["url", "A URL for a post or photo on App.net."]
]%>

#### Example

<% response = {
    "provider_url" => "https://app.net",
    "version" => "1.0",
    "author_url" => "https://alpha.app.net/mthurman",
    "title" => "join.app.net getting ready for the world w/ @dalton @berg @voidfiles @jhubball @aaronblyth @andrew @vinitlee @mark @mintz @barmstrong @laughingman @mikegreenspan @ben #joinus",
    "url" => "https://alpha.app.net/mthurman/post/1",
    "provider_name" => "App.net",
    "type" => "link",
    "html" => "...",
    "author_name" => "mthurman"
} %>

<%= curl_example(:get, "oembed?url=https://posts.app.net/1", response, {:path_prefix => "/"}) %>
