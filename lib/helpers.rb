include Nanoc::Helpers::Rendering

def join_all(ary, join_with = ", ", connector = "</code> and <code>")
    return "" if ary.empty?
    return ary[0] if ary.size == 1
    [ary[0...-1].join(join_with), ary.last].join(connector)
end

def migration_warning(migrations = [])
    unless migrations.empty?
        plur = "s"
        if migrations.size == 1
            plur = ""
        end

        "<div class=\"alert alert-info\"><b>Note:</b> This endpoint is currently migrated by the <code>#{ join_all migrations }</code> migration#{ plur  }. Please refer to the <a href=\"/reference/make-request/migrations/#current-migrations\">Migrations documentation</a> for more info.</div>"
    end
end

def endpoint(method, path, token, scope = "", base_path = 'stream/0/')
    path = path.gsub('[','<b>{').gsub(']','}</b>')
    render '/partials/endpoint', :method => method, :path => 'https://alpha-api.app.net/' + base_path + path, :token => token, :scope => scope
end

def url_params(params = [])
    render '/partials/parameters', :header => "URL Parameters", :params => params
end

def query_params(params = [])
    render '/partials/parameters', :header => "Query String Parameters", :params => params
end

def query_params_typed(header = "Query String Parameters", params = [])
    render "/partials/parameters-typed", :header => header, :params => params
end

def post_params(params = [])
    render "/partials/parameters", :header => "POST Body Data", :params =>params
end

def file_token_reminder()
    "<div class=\"alert alert-info\">Please see the <a href=\"/reference/resources/file/#file-authorization\">File Authorization</a> documentation for more information on User and File tokens.</div>"
end

def pagination_note()
    '<em>Responses from this endpoint are <a href="/reference/make-request/pagination">paginated</a>.</em>'
end

def general_params_note_for(type)
    '<em>This endpoint responds to <a href="/reference/resources/'+type+'/#general-parameters">general '+type.capitalize+' parameters</a>.</em>'
end

def stream_facet_note()
    "<em>This endpoint can be <a href='/reference/resources/post/#stream-faceting-parameters'>Faceted</a> to filter it's results.</em>"
end

def access_token_required_note()
  "<div class=\"alert alert-success alert-block\">
  This guide assumes you have an access token. If you don't have one, <a href='/docs/guides/create-an-app/'>check out our guide on creating an app.</a>
  </div>
  "
end

# feel free to override these from your environment
def lanai_hostname()
    ENV['LANAI_HOSTNAME'] || 'app.net'
end

def local_hostname()
    ENV['LOCAL_HOSTNAME'] || 'localhost'
end
