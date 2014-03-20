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

def curl_example(method, path, response_key, options = {}, &block)
    # things left to figure out
    # - some quoting/escaping stuff
    # - how to show redirects and no content responses
    default_curl_options = {
        :token => "<YOUR ACCESS TOKEN>",
        :pretty_json => true,
        :base_url => "https://alpha-api.app.net/stream/0/",
        :response => :response,
        :content_type => "application/json", # we only show this on put/post/patch
        :data => {},
        :files => {},
        :follow_redirects => false,
    }

    options = default_curl_options.merge(options)

    curl_parts = ["curl"]

    response = case options[:response]
        when :response
            response(response_key, &block)
        when :collection
            collection_response(response_key, &block)
        when :paginated
            paginated_response(response_key, &block)
        when :raw
            options[:pretty_json] = false
            %{~~~ sh
#{response_key}
~~~
}
    end

    if method != :get
        curl_parts << "-X #{method.to_s.upcase}"
    end

    if options[:token]
        curl_parts << %{-H "Authorization: Bearer #{options[:token]}"}
    end

    if options[:pretty_json]
        curl_parts << %{-H "X-adn-pretty-json: 1"}
    end

    if options[:follow_redirects]
        curl_parts << %{-L}
    end

    if [:post, :put, :patch].include? method and not options[:data].empty?
        if options[:content_type]
            curl_parts << %{-H "Content-Type: #{options[:content_type]}"}
        end

        if options[:content_type] == "application/json"
            options[:data] = JSON.pretty_generate(options[:data])
            # todo: escape any single quotes in json data since we're about to wrap in single quotes for bash
        end
        curl_parts << %{-d '#{options[:data]}'}
    end

    options[:files].each do |k, v|
        curl_parts << %{-F #{k}=@#{v}}
    end

    # don't foget to quote this when we have qs params
    curl_parts << %{"#{options[:base_url] + path}"}

    %{~~~ sh
#{curl_parts.join(' ')}
~~~

#{response}
}
end
