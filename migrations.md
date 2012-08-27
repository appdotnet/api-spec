# Migrations

> This document describes a feature that is coming soon. We provide the details below so that developers can become acquainted with this new system.

From time to time, we reserve the right to make incremental changes to the API. In order to make it possible to change the API but still support legacy applications, we will make use of migrations. Migrations are a per-app feature that developers may toggle for their own apps from the time that the old behavior is deprecated until the time that it has reached the end of its life (EOL). Once the EOL date is reached, the migration will be enabled for all apps with no legacy mode available.

## Accessing Migration Data

We offer a single toggle for each migration and app that will globally turn the migration on (current mode) or off (legacy mode) for that app as well as a per-call header mechanism that overrides the global behavior.

### Global Toggle

Global migration data may be accessed in the Edit App Page - https://alpha.app.net/developer/app/edit/[app_id]. From here, developers can toggle the behavior of their apps' migrations.

By default, new apps will come with all existing migrations toggled to "Current" mode. This reflects the fact that support for legacy mode will eventually be removed. However, any migrations that are released after the app is created will be initially toggled to "Legacy" mode, so app developers can expect that the API behavior will not unexpectedly change for existing apps.

### Per-call Toggle
In addition to using the edit app toggles, we offer the X-ADN-Migration-Overrides header as a way for developers to override migration behavior on a per-call basis. This header should contain a **query-string encoded** list of valid [migration keys](#current-migrations) and values (0 or 1). For example, providing
`X-ADN-Migration-Overrides: response_envelope=0`
would disable [response envelopes](#current-migrations) for that particular call. We expect that some apps may be distributed in such a way that some users may be running old versions while others are running newer versions, so this override header may make it easier to adopt new functionality without causing regressions. As with the toggle, though, migration override keys cannot be used past their EOL dates. Also, X-ADN-Migration-Overrides is whitelisted for CORS, so we expect that it should be usable in all contexts.

### Migration Response Header
All calls to our endpoints will return X-ADN-Migrations-Enabled, a query-string encoded list of migration keys that are enabled for that particular API call. This list will take into account globally toggled migrations as well as those enabled by X-ADN-Migration-Overrides.

## Current Migrations

<table>
    <thead>
        <tr>
            <th>Migration (name)</th>
            <th>Key</th>
            <th>Description</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Response Envelope</td>
            <td>response_envelope</td>
            <td>Wraps all responses in a JSON envelope containing two-top level keys -- <code>meta</code> and <code>data</code>. <code>data</code> will contain the requested item or items (<code>{}</code> or <code>[]</code>) while <code>meta</code> contains <code>code</code> (response code number) and extra info such as any errors or pagination data. If you are looking for the legacy portion of this envelope, use the contents of <code>data</code>.</td>
        </tr>
        <tr>
            <td>Disable Min/Max ID</td>
            <td>disable_min_max_id</td>
            <td>Disables the min_id and max_id <a href="resources/posts.md#general-parameters">general parameters</a> on endpoints that return Post objects. The new parameters are since_id and before_id.</td>
    </tbody>
</table>
