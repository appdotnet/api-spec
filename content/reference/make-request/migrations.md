---
title: "Migrations"
---

# Migrations

* TOC
{:toc}

We reserve the right to make incremental changes to the API as we deem necessary. In order to make it possible to change the API but still support legacy applications, we will make use of migrations. Migrations are a per-app feature that developers may toggle for their own apps from the time that the old behavior is deprecated until the time that it has reached the end of its life (EOL). Once the EOL date is reached, the migration will be enabled for all apps with no legacy mode available.

{::options parse_block_html="true" /}

## Accessing Migration Data

We offer a single toggle for each migration and app that will globally turn the migration on (current mode) or off (legacy mode) for that app as well as a per-call header mechanism that overrides the global behavior.

### Global Toggle

You can toggle the global migration behavior of your apps by editing your apps listed at [https://account.app.net/developer/apps/](https://account.app.net/developer/apps/).

By default, new apps will come with all existing migrations toggled to "Current" mode. This reflects the fact that support for legacy mode will eventually be removed. However, any migrations that are released after the app is created will be initially toggled to "Legacy" mode, so app developers can expect that the API behavior will not unexpectedly change for existing apps.

### Per-call Toggle
In addition to using the edit app toggles, we offer the `X-ADN-Migration-Overrides` header as a way for developers to override migration behavior on a per-call basis. This header should contain a **query-string encoded** list of valid [migration keys](#current-migrations) and values (0 or 1). For example, providing `X-ADN-Migration-Overrides: foo=0` would disable the migration named `foo`. We expect that some apps may be distributed in such a way that some users may be running old versions while others are running newer versions, so this override header may make it easier to adopt new functionality without causing regressions. As with the toggle, though, migration override keys cannot be used past their EOL dates. Also, `X-ADN-Migration-Overrides` is whitelisted for CORS, so we expect that it should be usable in all contexts.

### Migration Response Header
All calls to our endpoints will return `X-ADN-Migrations-Enabled`, a query-string encoded list of migration keys that are enabled for that particular API call. This list will take into account globally toggled migrations as well as those enabled by `X-ADN-Migration-Overrides`.

### Using Migrations with JSONP
For JSONP requests we offer the ability to override the default migration behavior on a per-call basis. To do this, add a list of valid [migration keys](#current-migrations) and values (0 or 1) to the query string. For example, `https://alpha-api.app.net/stream/0/posts/stream/global?callback=json_callback&foo=0`

**Toggling migrations with the query string is ONLY available for JSONP requests.** Use the header mechanism for all other requests.

## Current Migrations

<table class='table table-striped'>
    <thead>
        <tr>
            <th>Key</th>
            <th>Migration (name)</th>
            <th>Description</th>
            <th width="120">End-Of-Life Date</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><code></code></td>
            <td></td>
            <td>There are no active migrations.</td>
            <td></td>
        </tr>
    </tbody>
</table>
