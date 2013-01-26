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

        "<div class=\"alert alert-info\"><b>Note:</b> This endpoint is currently migrated by the <code>#{ join_all migrations }</code> migration#{ plur  }. Please refer to the <a href=\"/docs/basics/migrations/#current-migrations\">Migrations documentation</a> for more info.</div>"
    end
end

def endpoint(method, path, token, scope = "")
    render '/partials/endpoint', :method => method, :path => '/stream/0/'+path, :token => token, :scope => scope
end

def file_token_reminder()
  "<div class=\"alert alert-info\">Please see the <a href=\"/docs/resources/file/#file-authorization\">File Authorization</a> documentation for more information on User and File tokens.</div>"
end
