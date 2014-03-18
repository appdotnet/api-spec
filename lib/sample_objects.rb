require 'yajl/json_gem'

module Resources
  module Helpers
    def get_hash(key)
      case key
        when Hash
          h = {}
          key.each { |k, v| h[k.to_s] = v }
          h
        when Array
          key
        when Integer
          key
        # deep copy so we can make any overrides we need for our specific use of this hash
        else deep_copy(Resources.const_get(key.to_s.upcase))
      end
    end

    def json_output(hash)
      "~~~js\n" + JSON.pretty_generate(hash) + "\n~~~"
    end

    def process_json(key, &block)
      hash = get_hash(key)
      yield hash if block_given?
      hash
    end

    def json(key, &block)
      json_output(process_json(key, &block))
    end

    def deep_copy(o)
      Marshal.load(Marshal.dump(o))
    end

    def diff_hash(a, b)
      (a.keys | b.keys).inject({}) do |diff, k|
        if a[k] != b[k]
          if a[k].is_a?(Hash) && b[k].is_a?(Hash)
            diff[k] = diff_hash(a[k], b[k])
          elsif a[k].is_a?(Array) && b[k].is_a?(Array)
            diff[k] = a[k].zip(b[k]).map do |el|
              if el[0].is_a?(Hash) && el[1].is_a?(Hash)
                diff_hash(el[0], el[1])
              else
                el
              end
            end
          else
            diff[k] = [a[k], b[k]]
          end
        end
        diff
      end
    end

    def parse_hash(data)
      # strip out ~~~js and ~~~ at the beginning and end of the string
      data.gsub!(/^~~~\s*js$|^~~~$/, '')
      JSON.parse(data)
    end

    # make it easier to migrate to this new sample objects syntax by figuring out the difference between the current
    # json representation and a sample object one. Wrap the old json blob in something like this:
    # <%= json_diff(%q{
    # ~~~ js
    # ...the entire old json blob including the begining { and ending }
    # ~~~
    # }, response(:user) do |h|
    #   ...any modifications to h you need...
    # end) %>
    def json_diff(old_data, new_data)
      # give us an easy anchor on the page to jump to #diff
      "# DIFF:\n" + json_output(diff_hash(parse_hash(old_data), parse_hash(new_data)))
    end

    def base_response(data, meta, &block)
      process_json({
        "data" => data,
        "meta" => meta
      }, &block)
    end

    # when using these responses, make sure you always set the defining attributes in a block instead of relying on
    # whatever is defined as the default. For instance, for "follow a user", make sure you set h["data"]["you_follow"] = true
    # in case the default changes in the future
    def response(key, &block)
      json_output(base_response(get_hash(key), {"code"=> 200}, &block))
    end

    def collection_response(key, &block)
      json_output(base_response([get_hash(key)], {"code"=> 200}, &block))
    end

    def paginated_response(key, &block)
      base_data = get_hash(key)
      base_data["pagination_id"] = base_data["id"]

      response = base_response([base_data], {"code" => 200, "more" => false}, &block)
      # then if someone overrides pagination_id, we create an appropriate meta env
      response["meta"]["min_id"] = response["data"][-1]["pagination_id"] unless response["meta"].has_key? "min_id"
      response["meta"]["max_id"] = response["data"][0]["pagination_id"] unless response["meta"].has_key? "max_id"

      json_output(response)
    end
  end

  FILE = {
      "complete" => true,
      "created_at" => "2013-01-28T18:31:18Z",
      "derived_files" => {
          "image_thumb_200s" => {
              "image_info" => {
                  "width" => 200,
                  "height" => 200,
              },
              "name" => "filename_image_thumb_200s.png",
              "mime_type" => "image/png",
              "sha1" => "be91cb06d69df13bb103a359ce70cf9fba31234a",
              "size" => 33803,
              "url" => "https://example.com/thumbnail_200s.png",
              "url_expires" => "2013-01-25T03:00:00Z",
          },
          "image_thumb_960r" => {
              "image_info" => {
                  "width" => 600,
                  "height" => 800,
              },
              "name" => "filename_image_thumb_960r.png",
              "mime_type" => "image/png",
              "size" => 140173,
              "sha1" => "57004b55119002f551be5b9f2d5439dd4ad1234a",
              "url" => "https://example.com/thumbnail_960r.png",
              "url_expires" => "2013-01-25T03:00:00Z",
          },
      },
      "file_token" => "auCj3h64JZrhQ9aJdmwre3KP-QL9UtWHYvt5tj_64rUJWemoIV2W8eTJv9NMaGpBFk-BbU_aWA26Q40w4jFhiPBpnIQ_lciLwfh6o8YIAQGEQziksUMxZo7gOHJ_-niw3l3MZCh7QRWzqNGpiVaUEptfKO0fETrZ8bJjDa61234a",
      "id" => "1",
      "image_info" => {
          "width" => 600,
          "height" => 800,
      },
      "kind" => "image",
      "mime_type" => "image/png",
      "name" => "filename.png",
      "sha1" => "ef0ccae4d36d4083b53e121a6cf9cc9d7ac1234a",
      "size" => 172393,
      "source" => {
          "name" => "Clientastic for iOS",
          "link" => "http://app.net",
          "client_id" => "98765zyxw"
      },
      "total_size" => 346369,
      "type" => "com.example.test",
      "url" => "https://...",
      "url_expires" => "2013-01-25T03:00:00Z",
      "user" => "...user object...",  # TODO render this as a user placholder somehow
  }

  USER = {
      "id" => "1",
      "username" => "mthurman",
      "name" => "Mark Thurman",
      "description" => {
         "text" => "Hi, I'm Mark Thurman and I'm teaching you about the @appdotnet Stream #API.",
         "html" => "Hi, I'm Mark Thurman and I'm <a href=\"https://github.com/appdotnet/api_spec\" rel=\"nofollow\">teaching you</a> about the <span itemprop=\"mention\" data-mention-name=\"appdotnet\" data-mention-id=\"3\">@appdotnet</span> Stream #<span itemprop=\"hashtag\" data-hashtag-name=\"api\">API</span>.",
         "entities" => {
             "mentions" => [{
                 "name" => "appdotnet",
                 "id" => "3",
                 "pos" => 52,
                 "len" => 10
             }],
             "hashtags" => [{
                 "name" => "api",
                 "pos" => 70,
                 "len" => 4
             }],
             "links" => [{
                 "text" => "teaching you",
                 "url" => "https://github.com/appdotnet/api-spec",
                 "pos" => 29,
                 "len" => 12
             }]
          }
      },
      "timezone" => "US/Pacific",
      "locale" => "en_US",
      "avatar_image" => {
          "height" => 200,
          "width" => 200,
          "url" => "https://example.com/avatar_image.jpg",
          "is_default" => false
      },
      "cover_image" => {
          "width" => 960,
          "height" => 264,
          "url" => "https://example.com/cover_image.jpg",
          "is_default" => false
      },
      "type" => "human",
      "created_at" => "2012-07-16T17:23:34Z",
      "counts" => {
          "following" => 100,
          "followers" => 200,
          "posts" => 24,
          "stars" => 76
      },
      "follows_you" => false,
      "you_blocked" => false,
      "you_follow" => false,
      "you_muted" => false,
      "you_can_subscribe" => true,
      "you_can_follow" => true,
      "verified_domain" => "example.com",
      "canonical_url" => "https://alpha.app.net/mthurman"
  }

  USER_SELF_BLACKLIST = ['follows_you', 'you_follow', 'you_muted', 'you_blocked', 'you_can_subscribe', 'you_can_follow']
  USER_SELF = USER.reject {|key, value| USER_SELF_BLACKLIST.include?(key) }

  CONFIG = {
    "text" => {
      "uri_template_length" => {
        "post_id" => 9,
        "message_id" => 12
      }
    },
    "user" => {
      "annotation_max_bytes" => 8192,
      "text_max_length" => 256
    },
    "file" => {
      "annotation_max_bytes" => 8192
    },
    "post" => {
      "annotation_max_bytes" => 8192,
      "text_max_length" => 256
    },
    "message" => {
      "annotation_max_bytes" => 8192,
      "text_max_length" => 256
    },
    "channel" => {
      "annotation_max_bytes" => 8192
    }
  }

  CHANNEL_WITH_MARKER = {
    "counts" => {
        "messages" => 42,
        "subscribers" => 43
    },
    "has_unread" => false,
    "id" => "1",
    "owner" => "...user object...",  # TODO render this as a user placholder somehow
    "is_inactive" => false,
    "readers" => {
        "any_user" => false,
        "immutable" => false,
        "public" => true,
        "user_ids" => [],
        "you" => true
    },
    "editors" => {
        "any_user" => false,
        "immutable" => false,
        "public" => false,
        "user_ids" => [],
        "you" => true
    },
    "recent_message_id" => "231",
    "recent_message" => "...message object...",
    "type" => "com.example.channel",
    "writers" => {
        "any_user" => false,
        "immutable" => false,
        "public" => false,
        "user_ids" => [],
        "you" => true
    },
    "you_can_edit" => true,
    "you_subscribed" => true,
    "you_muted" => false,
    "marker" => "...marker object..."
  }

  CHANNEL = CHANNEL_WITH_MARKER.reject {|key, value| key == "marker" }
  end

include Resources::Helpers
