require 'cgi'
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
        else Helpers.deep_copy(Resources.const_get(key.to_s.upcase))
      end
    end

    def json_output(hash)
      "\n<pre><code class='language-js'>\n" + CGI.escapeHTML(JSON.pretty_generate(hash)) + "\n</code></pre>\n"
    end

    def process_json(key, &block)
      hash = get_hash(key)
      yield hash if block_given?
      hash
    end

    def json(key, &block)
      json_output(process_json(key, &block))
    end

    def self.deep_copy(o)
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

  FULL_POST = {
      "id" => "1",
      "user" => "...user object...",
      "created_at" => "2012-07-16T17:25:47Z",
      "text" => "@berg FIRST post on this new site #newsocialnetwork",
      "html" => "<span itemscope=\"https://app.net/schemas/Post\"><span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on <a href=\"https://join.app.net\" rel=\"nofollow\">this new site</a> <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.</span",
      "source" => {
          "name" => "Clientastic for iOS",
          "link" => "http://app.net",
          "client_id" => "udxGzAVBdXwGtkHmvswR5MbMEeVnq6n4"
      },
      "machine_only" => false,
      "reply_to" => nil,
      "thread_id" => "1",
      "canonical_url" => "https://alpha.app.net/mthurman/post/1",
      "num_replies" => 0,
      "num_reposts" => 0,
      "num_stars" => 0,
      "annotations" => [{
          "type" => "net.app.core.geolocation",
          "value" => {
              "latitude" => 74.0064,
              "longitude" => 40.7142
          }
      }],
      "entities" => {
          "mentions" => [{
              "name" => "berg",
              "id" => "2",
              "pos" => 0,
              "len" => 5
          }],
          "hashtags" => [{
              "name" => "newsocialnetwork",
              "pos" => 34,
              "len" => 17
          }],
          "links" => [{
              "text" => "this new site",
              "url" => "https://join.app.net",
              "pos" => 20,
              "len" => 13
          }]
      },
      "you_reposted" => false,
      "you_starred" => false,
      "reposters" => [
          "...user objects..."
      ],
      "starred_by" => [
          "...user objects..."
      ]
  }

  post_fields_omitted = ["annotations", "reposters", "starred_by"]
  POST = FULL_POST.reject {|key, value| post_fields_omitted.include? key }
  # since posts have text, html, entities, instead of always having to override in the block, provide more options here if we care
  # about what the text is
  FIRST_POST = Helpers.deep_copy(POST)
  # get rid of the user defined link through here
  FIRST_POST["html"] = "<span itemscope=\"https://app.net/schemas/Post\"><span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span> FIRST post on this new site <span itemprop=\"hashtag\" data-hashtag-name=\"newsocialnetwork\">#newsocialnetwork</span>.</span>"
  FIRST_POST["entities"]["links"] = []

  POST_REPLY = Helpers.deep_copy(POST)
  POST_REPLY["id"] = "2"
  POST_REPLY["canonical_url"] = "https://alpha.app.net/berg/post/2"
  POST_REPLY["reply_to"] = "1"
  POST_REPLY["thread_id"] = "1"
  POST_REPLY["text"] = "@mthurman stop trolling"
  POST_REPLY["html"] = "<span itemscope=\"https://app.net/schemas/Post\"><span itemprop=\"mention\" data-mention-name=\"mthurman\" data-mention-id=\"1\">@mthurman</span> stop trolling</span>"
  POST_REPLY["entities"] = {
      "mentions" => [{
          "name" => "mthurman",
          "id" => "2",
          "pos" => 0,
          "len" => 9
      }],
      "hashtags" => [],
      "links" => []
  }

  # simplify POST before we "repost" it so there are fewer entities etc
  REPOST_OF = Helpers.deep_copy(POST)
  REPOST_OF["text"] = "a really insightful post that must be shared with the world"
  REPOST_OF["html"] = "<span itemscope=\"https://app.net/schemas/Post\">" + REPOST_OF["text"] + "</span>"
  REPOST_OF["entities"] = {
      "hashtags" => [],
      "links" => [],
      "mentions" => []
  }
  REPOST_OF["id"] = "3"
  REPOST_OF["thread_id"] = "3"
  REPOST_OF["canonical_url"] = "https://alpha.app.net/berg/post/3"

  REPOST = Helpers.deep_copy(REPOST_OF)
  REPOST["repost_of"] = REPOST_OF
  REPOST["repost_of"]["you_reposted"] = true
  REPOST["repost_of"]["num_reposts"] += 1
  REPOST["id"] = "4"
  REPOST["created_at"] = "2012-09-13T21:26:19Z"
  REPOST["canonical_url"] = "https://alpha.app.net/mthurman/post/4"
  REPOST["num_replies"] = 0
  REPOST["num_reposts"] = 0
  REPOST["num_stars"] = 0
  REPOST["text"] = ">> @berg: " + REPOST_OF["text"]
  REPOST["html"] = "<span itemscope=\"https://app.net/schemas/Post\">&gt;&gt; <span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span>: a really insightful post that must be shared with the world</span>"
  REPOST["entities"]["mentions"] = [{
      "name" => "berg",
      "id" => "2",
      "pos" => 3,
      "len" => 5
  }]
end

include Resources::Helpers
