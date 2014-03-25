require 'cgi'
require 'yajl/json_gem'
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

def login_url(text)
    base_domain = lanai_hostname()
    scopes = ["basic"]
    # testing
    client_id = ENV['CLIENT_ID'] || "gvfM7pVsPBAkVmFWeCDF22uLTyTuMzdd"
    redirect_uri = "<script>document.write(window.location);</script>"
    path = "/oauth/authenticate?response_type=token"

    url = "https://account.#{base_domain}#{path}&scope=#{scopes.join(' ')}&client_id=#{client_id}&redirect_uri="
    link = "\"<a href='#{url}\" + window.location + \"'>#{text}</a>\""

    "<script>document.write(#{link})</script>"
end

def access_token_banner()
    login_url = login_url("Authorize the App.net docs")
    "<div class=\"alert alert-success alert-block authorize-prompt hide\">
    #{login_url} to see more complete examples.
    </div>
    "
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
        :data_binary => nil,
        :files => {},
        :follow_redirects => false,
        :print_headers => false,
        :stdin => nil,
        :headers => {},
        :response_syntax => "sh", # for raw responses, default to shell highlighting
    }

    options = default_curl_options.merge(options)

    curl_parts = ["curl"]

    if response_key == :none
        options[:response] = :none
    end

    response = case options[:response]
        when :response
            response(response_key, &block)
        when :collection
            collection_response(response_key, &block)
        when :paginated
            paginated_response(response_key, &block)
        when :raw
            options[:pretty_json] = false
            %{<pre><code class="language-#{options[:response_syntax]}">#{CGI.escapeHTML(response_key)}</code></pre>
}
        when :none
            ""
    end

    if method != :get
        curl_parts << "-X #{method.to_s.upcase}"
    end

    if options[:token]
        options[:headers]["Authorization"] = "Bearer #{options[:token]}"
    end

    if options[:pretty_json]
        options[:headers]["X-ADN-Pretty-JSON"] = "1"
    end

    if options[:follow_redirects]
        curl_parts << %{-L}
    end

    if options[:print_headers]
        curl_parts << %{-i}
    end


    if [:post, :put, :patch].include? method and options[:content_type] and (options[:data_binary] or not options[:data].empty?)
        options[:headers]["Content-Type"] = options[:content_type]
    end

    options[:headers].each do |k, v|
        curl_parts << %{-H "#{k}: #{v}"}
    end

    if [:post, :put, :patch].include? method
        if not options[:data].empty?
            if options[:content_type] == "application/json"
                options[:data] = JSON.pretty_generate(options[:data])
                # todo: escape any single quotes in json data since we're about to wrap in single quotes for bash
                curl_parts << %{-d '#{options[:data]}'}
            elsif options[:data].instance_of? Hash
                options[:data].each do |k, v|
                    curl_parts << %{-d '#{k}=#{v}'}
                end
            else
                # get rid of this case
                curl_parts << %{-d '#{options[:data]}'}
            end
        elsif options[:data_binary]
            curl_parts << %{--data-binary '#{options[:data_binary]}'}
        end
    end

    options[:files].each do |k, v|
        curl_parts << %{-F "#{k}=#{v}"}
    end

    if options[:stdin]
        curl_parts.unshift %{echo '#{options[:stdin]}' |}
    end

    # don't foget to quote this when we have qs params
    curl_parts << %{"#{options[:base_url] + path}"}

    # do some cleanup and wrapping
    curl_parts = curl_parts.map { |p| CGI.escapeHTML(p) }

    curl_lines = []
    cur_line = ""
    width = 80
    curl_parts.each do |p|
        if cur_line.length > width
            curl_lines << cur_line.strip
            cur_line = ""
        end
        cur_line << p
        cur_line << " "
    end
    curl_lines << cur_line.strip

    # use pre, code instead of a fenced code block so I can use these inside of markdown lists. Fenced code blocks don't work in md lists
    %{#{access_token_banner}
<pre><code class="language-sh">#{curl_lines.join(" \\\n    ")}</code></pre>
#{response}
}
end
