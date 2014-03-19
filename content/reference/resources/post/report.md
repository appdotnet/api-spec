---
title: "Report"
---

# Report

* TOC
{:toc}

## Report a Post

Report a post as spam. This will mute the author of the post and send a report to App.net.

> If you are testing this endpoint, please send an email to [support@app.net](mailto:support@app.net) letting us know the account you are about to report. 

<%= general_params_note_for "post" %>

<%= endpoint "POST", "posts/[post_id]/report", "User" %>

<%= url_params [
    ["post_id", "The id of the Post to report."]
]%>

#### Example

> POST https://alpha-api.app.net/stream/0/posts/1/report

<%= response(:post) %>