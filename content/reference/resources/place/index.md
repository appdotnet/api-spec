---
title: "Place"
---

# Place

* TOC
{:toc}

Place objects represent physical locations which can be given a name and associated with a latitude and longitude somewhere on Earth. For example, the Caltrain station in San Francisco, CA at 700 4th St., which has a location of latitude 37.776905, longitude -122.395012, can be considered a Place. In order to provide accurate and thorough Place data, we use a database from [factual.com](http://factual.com/). As such, all of our Places use the same UUIDs as those retrieved from factual.com.

<%= json(:place) %>

## Place Fields

<table class='table table-striped'>
    <tr>
        <th>Field</th>
        <th>Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><code>factual_id</code></td>
        <td>string</td>
        <td>Primary identifier for a place. Uses factual.com's Place UUID.</td>
    </tr>
    <tr>
        <td><code>name</code></td>
        <td>string</td>
        <td>Human-friendly name.</td>
    </tr>
    <tr>
        <td><code>address</code></td>
        <td>string</td>
        <td>Street address.</td>
    </tr>
    <tr>
        <td><code>address_extended</code></td>
        <td>string</td>
        <td>Apartment or Suite number in street address.</td>
    </tr>
    <tr>
        <td><code>locality</code></td>
        <td>string</td>
        <td>City or town.</td>
    </tr>
    <tr>
        <td><code>region</code></td>
        <td>string</td>
        <td>State, region, province etc.</td>
    </tr>
    <tr>
        <td><code>admin_region</code></td>
        <td>string</td>
        <td>Additional sub-division (e.g. Wales).</td>
    </tr>
    <tr>
        <td><code>post_town</code></td>
        <td>string</td>
        <td>Town used in postal addressing.</td>
    </tr>
    <tr>
        <td><code>po_box</code></td>
        <td>string</td>
        <td>PO Box.</td>
    </tr>
    <tr>
        <td><code>postcode</code></td>
        <td>string</td>
        <td>Postcode / zipcode.</td>
    </tr>
    <tr>
        <td><code>country_code</code></td>
        <td>string</td>
        <td>A two-letter country code in <a href="http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2">ISO 3166-1 alpha-2</a> format.</td>
    </tr>
    <tr>
        <td><code>latitude</code></td>
        <td>decimal</td>
        <td>Latitude in decimal degrees.</td>
    </tr>
    <tr>
        <td><code>longitude</code></td>
        <td>decimal</td>
        <td>Longitude in decimal degrees.</td>
    </tr>
    <tr>
        <td><code>is_open</code></td>
        <td>boolean</td>
        <td>Whether the establishment is still "in business" and/or open to the public and does not refer to business hours or whether it may be serving customers at any particular moment in time.</td>
    </tr>
    <tr>
        <td><code>telephone</code></td>
        <td>string</td>
        <td>Telephone number in local formatting.</td>
    </tr>
    <tr>
        <td><code>fax</code></td>
        <td>string</td>
        <td>Fax number in local formatting.</td>
    </tr>
    <tr>
        <td><code>website</code></td>
        <td>string</td>
        <td>Official URL of the establishment.</td>
    </tr>
    <tr>
        <td><code>categories</code></td>
        <td>list of objects</td>
        <td>
            <br>
            <table>
                <tr>
                    <th>Field</th>
                    <th>Type</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td><code>labels</code></td>
                    <td>list</td>
                    <td>Human-friendly descriptive labels for this category. Ordered from general to specific.</td>
                </tr>
                <tr>
                    <td><code>id</code></td>
                    <td>string</td>
                    <td>Category ID. Corresponds to most specific category label.</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

In the future, Places may eventually sit at multiple categorical "leaf nodes" and as a result, we provide lists of category objects (though for now, no Place will be associated with more than one category ID).

## Attaching Places to other resources

Places can be attached to any resource that allows annotations. You can insert Place data into any annotation using the [`+net.app.core.place` replacement value](https://github.com/appdotnet/object-metadata/blob/master/annotation-replacement-values/+net.app.core.place.md) and providing a `factual_id`. For more information, see the [annotation replacement values](/reference/meta/annotations/#annotation-replacement-values) documentation.

We provide a [Checkin annotation](https://github.com/appdotnet/object-metadata/blob/master/annotations/net.app.core.checkin.md) as a [core annotation](/reference/meta/annotations/#core-annotations) for the common use case of using Place data to give users a way to say "I was here when I posted this", though developers are free to use Place data in other contexts.

## Retrieve a Place

Returns info about a Place object with a given `factual_id`.

### Deduplication effects

Because it is possible for duplicate entries to exist for the same Place, Factual provides a method to deduplicate one Place object by "replacing" it with another. As a result, you may notice sometimes that when requesting a Place with one `factual_id` you will get back an entry with a different `factual_id`. When we return a different Place than the one you requested we are claiming, to the best of our knowledge, that it is equivalent to the one requested.

<%= endpoint "GET", "places/[factual_id]", "Any" %>

<%= url_params [
    ["factual_id", "The Factual id of the Place to retrieve."]
]%>

#### Example

<%= curl_example(:get, "places/19931850-dc2f-012e-561d-003048cad9da", :place) %>

## Search for a Place

Performs a search for nearest places from given latitude and longitude. Optionally takes a `q` string to restrict matches on name (like autocomplete for Place names).

Returns a list of Places sorted by distance or distance/string match if `q` is provided. These are the same Place objects as returned by the previous endpoint but will also include a `distance` property which gives, in meters, the distance from the search centroid to the Place.

{::options parse_block_html="true" /}
<div class="alert alert-error alert-block">
**When using this endpoint, it is a requirement that _all_ requests originate from user actions.** As an example, acceptable use cases include when a user presses a button to search for local Places or when a user types a character to specify part of a Place name. Unacceptable use cases include automated access (e.g. "bots", "scrapers"), periodic scans and attempts to create comprehensive local caches or copies of the Place data. **We will be monitoring search usage and will take necessary actions to terminate unacceptable use.**
</div>

<%= endpoint "GET", "places/search", "User" %>

<%= query_params_typed 'Query String Parameters', [

    ["latitude", :required, "decimal", "Latitude of search location. Combined with longitude to create central point of search results."],

    ["longitude", :required, "decimal", "Longitude of search location. Combined with latitude to create central point of search results."],

    ["q", :optional, "string", "The name-based search query. Can be a partial string — for example, 'cre' will find any local 'creameries' and 'ice cream' locations."],

    ["radius", :optional, "decimal", "Approximate radius (in meters) of bounding circle on results. For example, supplying <code>radius=100</code> will limit all locations to be within 100 meters. Defaults to 100, ranges between 0.001 and 50,000."],

    ["count", :optional, "integer", "Number of results to return. Defaults to 20, ranges between 1 and 100."],

    ["remove_closed", :optional, "int (0 or 1)", "Set to 0 if you would like the result to include entities which are closed (is_closed=1) or 1 if you would only prefer to see results for entities that are open. Defaults to 1."],

    ["altitude", :optional, "decimal", "Altitude of search location (in meters). <em>Not presently used to generate search results but may be later.</em>"],

    ["horizontal_accuracy", :optional, "decimal", "Accuracy of <code>latitude</code>/<code>longitude</code> parameters (in meters). <em>Not presently used to generate search results but may be later.</em>"],

    ["vertical_accuracy", :optional, "decimal", "Accuracy of <code>altitude</code> parameter (in meters). <em>Not presently used to generate search results but may be later.</em>"]

]%>

#### Example (no search string)


<%= curl_example(:get, "places/search?latitude=37.776905&longitude=-122.395012", :place, {:response => :collection}) do |h|
    h["data"][0]["distance"] = 15.895655654
end %>

#### Example (search string, radius and count)

<%= curl_example(:get, "places/search?latitude=37.776905&longitude=-122.395012&q=caltrain&count=1&radius=5000", :place, {:response => :collection}) do |h|
    h["data"][0]["distance"] = 15.895655654
end %>
