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
      "\n<pre><code class='language-js'>" + CGI.escapeHTML(JSON.pretty_generate(hash)) + "</code></pre>\n"
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
      data.gsub!(/^<pre><code class='language-js'>$|^<\/code><\/pre>$/, '')
      JSON.parse(CGI.unescapeHTML(data))
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
    # You should _rarely_ call this directly. Usually use curl_example unless you want to have markup between the request and response
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

  USER_SELF = {
      "avatar_image" => {
          "height" => 138,
          "is_default" => false,
          "url" => "https://d2rfichhc2fb9n.cloudfront.net/image/5/IE7DNB7N4XE9OjQuP16-9zaPU1x7InMiOiJzMyIsImIiOiJhZG4tdXNlci1hc3NldHMiLCJrIjoiYXNzZXRzL3VzZXIvODgvNjgvNDAvODg2ODQwMDAwMDAwMDAwMC5qcGciLCJvIjoiIn0",
          "width" => 138
      },
      "canonical_url" => "https://alpha.app.net/dalton",
      "counts" => {
          "followers" => 16833,
          "following" => 666,
          "posts" => 13284,
          "stars" => 8301
      },
      "cover_image" => {
          "height" => 456,
          "is_default" => false,
          "url" => "https://d2rfichhc2fb9n.cloudfront.net/image/5/iV3sRFel7xEjDK7hCB9R0xgIFAF7InMiOiJzMyIsImIiOiJhZG4tdXNlci1hc3NldHMiLCJrIjoiYXNzZXRzL3VzZXIvNDIvMDAvMDAvNDIwMDAwMDAwMDAwMDAwMC5wbmciLCJvIjoiIn0",
          "width" => 1103
      },
      "created_at" => "2012-08-03T01:17:14Z",
      "description" => {
          "entities" => {
              "hashtags" => [],
              "links" => [
                  {
                      "len" => 7,
                      "pos" => 12,
                      "text" => "App.net",
                      "url" => "http://App.net"
                  },
                  {
                      "len" => 18,
                      "pos" => 27,
                      "text" => "daltoncaldwell.com",
                      "url" => "http://daltoncaldwell.com"
                  }
              ],
              "mentions" => []
          },
          "html" => "<span itemscope=\"https://app.net/schemas/Post\">Founder/CEO <a href=\"http://App.net\">App.net</a> <br>Blog => <a href=\"http://daltoncaldwell.com\">daltoncaldwell.com</a></span>",
          "text" => "Founder/CEO App.net \nBlog => daltoncaldwell.com"
      },
      "id" => "1",
      "locale" => "en_US",
      "name" => "Dalton Caldwell",
      "timezone" => "America/Los_Angeles",
      "type" => "human",
      "username" => "dalton",
      "verified_domain" => "daltoncaldwell.com",
  }

  USER = USER_SELF.merge({
      "follows_you" => false,
      "you_blocked" => false,
      "you_follow" => false,
      "you_muted" => false,
      "you_can_subscribe" => true,
      "you_can_follow" => true,
  })

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

  CHANNEL = {
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
  }

  POST = {
      "canonical_url" => "https://alpha.app.net/mthurman/post/1",
      "created_at" => "2012-08-03T03:59:06Z",
      "entities" => {
          "hashtags" => [
              {
                  "len" => 7,
                  "name" => "joinus",
                  "pos" => 167
              }
          ],
          "links" => [
              {
                  "len" => 12,
                  "pos" => 0,
                  "text" => "join.app.net",
                  "url" => "http://join.app.net"
              }
          ],
          "mentions" => [
              {
                  "id" => "1",
                  "len" => 7,
                  "name" => "dalton",
                  "pos" => 44
              },
              {
                  "id" => "2",
                  "len" => 5,
                  "name" => "berg",
                  "pos" => 52
              },
              {
                  "id" => "3",
                  "len" => 10,
                  "name" => "voidfiles",
                  "pos" => 58
              },
              {
                  "id" => "4",
                  "len" => 9,
                  "name" => "jhubball",
                  "pos" => 69
              },
              {
                  "id" => "5",
                  "len" => 11,
                  "name" => "aaronblyth",
                  "pos" => 79
              },
              {
                  "id" => "6",
                  "len" => 7,
                  "name" => "andrew",
                  "pos" => 91
              },
              {
                  "id" => "7",
                  "len" => 9,
                  "name" => "vinitlee",
                  "pos" => 99
              },
              {
                  "id" => "9",
                  "len" => 5,
                  "name" => "mark",
                  "pos" => 109
              },
              {
                  "id" => "10",
                  "len" => 6,
                  "name" => "mintz",
                  "pos" => 115
              },
              {
                  "id" => "11",
                  "len" => 11,
                  "name" => "barmstrong",
                  "pos" => 122
              },
              {
                  "id" => "12",
                  "len" => 12,
                  "name" => "laughingman",
                  "pos" => 134
              },
              {
                  "id" => "13",
                  "len" => 14,
                  "name" => "mikegreenspan",
                  "pos" => 147
              },
              {
                  "id" => "14",
                  "len" => 4,
                  "name" => "ben",
                  "pos" => 162
              }
          ]
      },
      "html" => "<span itemscope=\"https://app.net/schemas/Post\"><a href=\"http://join.app.net\">join.app.net</a> getting ready for the world w/ <span data-mention-id=\"1\" data-mention-name=\"dalton\" itemprop=\"mention\">@dalton</span> <span data-mention-id=\"2\" data-mention-name=\"berg\" itemprop=\"mention\">@berg</span> <span data-mention-id=\"3\" data-mention-name=\"voidfiles\" itemprop=\"mention\">@voidfiles</span> <span data-mention-id=\"4\" data-mention-name=\"jhubball\" itemprop=\"mention\">@jhubball</span> <span data-mention-id=\"5\" data-mention-name=\"aaronblyth\" itemprop=\"mention\">@aaronblyth</span> <span data-mention-id=\"6\" data-mention-name=\"andrew\" itemprop=\"mention\">@andrew</span> <span data-mention-id=\"7\" data-mention-name=\"vinitlee\" itemprop=\"mention\">@vinitlee</span> <span data-mention-id=\"9\" data-mention-name=\"mark\" itemprop=\"mention\">@mark</span> <span data-mention-id=\"10\" data-mention-name=\"mintz\" itemprop=\"mention\">@mintz</span> <span data-mention-id=\"11\" data-mention-name=\"barmstrong\" itemprop=\"mention\">@barmstrong</span> <span data-mention-id=\"12\" data-mention-name=\"laughingman\" itemprop=\"mention\">@laughingman</span> <span data-mention-id=\"13\" data-mention-name=\"mikegreenspan\" itemprop=\"mention\">@mikegreenspan</span> <span data-mention-id=\"14\" data-mention-name=\"ben\" itemprop=\"mention\">@ben</span> <span data-hashtag-name=\"joinus\" itemprop=\"hashtag\">#joinus</span></span>",
      "id" => "1",
      "machine_only" => false,
      "num_replies" => 11,
      "num_reposts" => 5,
      "num_stars" => 53,
      "reply_to" => nil,
      "source" => {
          "client_id" => "caYWDBvjwt2e9HWMm6qyKS6KcATHUkzQ",
          "link" => "https://alpha.app.net",
          "name" => "Alpha"
      },
      "text" => "join.app.net getting ready for the world w/ @dalton @berg @voidfiles @jhubball @aaronblyth @andrew @vinitlee @mark @mintz @barmstrong @laughingman @mikegreenspan @ben #joinus",
      "thread_id" => "1",
      "user" => "...user object...",
      "you_reposted" => false,
      "you_starred" => false
  }

  FULL_POST = POST.merge({
      "annotations" => [{
          "type" => "net.app.core.geolocation",
          "value" => {
              "latitude" => 74.0064,
              "longitude" => 40.7142
          }
      }],
      "reposters" => [
          "...user objects..."
      ],
      "starred_by" => [
          "...user objects..."
      ]
  })

  # since posts have text, html, entities, instead of always having to override in the block, provide more options here if we care
  # about what the text is

  # A reply to POST
  POST_REPLY = POST.merge({
      "canonical_url" => "https://alpha.app.net/voidfiles/post/2",
      "created_at" => "2012-08-03T04:00:20Z",
      "entities" => {
          "hashtags" => [],
          "links" => [],
          "mentions" => [
              {
                  "id" => "8",
                  "is_leading" => true,
                  "len" => 9,
                  "name" => "mthurman",
                  "pos" => 0
              }
          ]
      },
      "html" => "<span itemscope=\"https://app.net/schemas/Post\"><span data-mention-id=\"8\" data-mention-name=\"mthurman\" itemprop=\"mention\">@mthurman</span> oh, I'm ready.</span>",
      "id" => "2",
      "machine_only" => false,
      "num_replies" => 0,
      "num_reposts" => 0,
      "num_stars" => 2,
      "reply_to" => "1",
      "source" => {
          "client_id" => "caYWDBvjwt2e9HWMm6qyKS6KcATHUkzQ",
          "link" => "https://alpha.app.net",
          "name" => "Alpha"
      },
      "text" => "@mthurman oh, I'm ready.",
      "thread_id" => "1",
      "user" => "...user object...",
  })

  # These aren't real posts anymore past this point
  # Building up to REPOST which is a repost of a REPOST_OF (which is just POST with fewer entities)
  REPOST_OF = POST.merge({
      "text" => "a really insightful post that must be shared with the world",
      "html" => "<span itemscope=\"https://app.net/schemas/Post\">a really insightful post that must be shared with the world</span>",
      "entities" => {
          "hashtags" => [],
          "links" => [],
          "mentions" => []
      },
      "id" => "3",
      "thread_id" => "3",
      "canonical_url" => "https://alpha.app.net/berg/post/3",
  })

  REPOST = REPOST_OF.merge({
      "id" => "4",
      "created_at" => "2012-09-13T21:26:19Z",
      "canonical_url" => "https://alpha.app.net/mthurman/post/4",
      "num_replies" => 0,
      "num_reposts" => 0,
      "num_stars" => 0,
      "text" => ">> @berg: " + REPOST_OF["text"],
      "html" => "<span itemscope=\"https://app.net/schemas/Post\">&gt;&gt; <span itemprop=\"mention\" data-mention-name=\"berg\" data-mention-id=\"2\">@berg</span>: a really insightful post that must be shared with the world</span>",
      "entities" => REPOST_OF["entities"].merge({
          "mentions" => [{
              "name" => "berg",
              "id" => "2",
              "pos" => 3,
              "len" => 5
          }]
      }),
      "repost_of" => REPOST_OF.merge({
          "you_reposted" => true,
          "num_reposts" => REPOST_OF["num_reposts"] + 1
      })
  })

  MESSAGE = {
      "channel_id" => "1",
      "created_at" => "2012-12-11T00:31:49Z",
      "entities" => {
          "hashtags" => [],
          "links" => [],
          "mentions" => []
      },
      "html" => "<span itemscope=\"https://app.net/schemas/Post\">Hello channel!</span>",
      "id" => "1",
      "machine_only" => false,
      "num_replies" => 0,
      "source" => {
          "client_id" => "UxUWrSdVLyCaShN62xZR5tknGvAxK93P",
          "link" => "https://app.net",
          "name" => "Test app"
      },
      "text" => "Hello channel!",
      "thread_id" => "1",
      "user" => "...user object..."
  }

  APP_TOKEN = {
      "app" => {
          "client_id" => "LHYCvdgDuUXndfCfyqABAtezCJjjsVM2",
          "link" => "http://foo.example.com",
          "name" => "Test app"
      },
      "scopes" => []
  }

  USER_TOKEN = APP_TOKEN.merge({
      "scopes" => [
          "stream",
          "messages",
          "export",
          "write_post",
          "follow"
      ],
      "limits" => {
          "following" => 40,
          "max_file_size" => 10000000
      },
      "storage" => {
          "available" => 8787479688,
          "used" => 1212520312
      },
      "user" => "...user object...",
      "invite_link" => "https://join.app.net/from/notareallink",
  })

  PLACE = {
      "factual_id" => "19931850-dc2f-012e-561d-003048cad9da",
      "name" => "Caltrain",
      "longitude" => -122.395012,
      "latitude" => 37.776905,
      "address" => "700 4th St",
      "address_extended" => "Ste 4",
      "locality" => "San Francisco",
      "region" => "CA",
      "postcode" => "94107",
      "country_code" => "us",
      "is_open" => true,
      "website" => "http://www.caltrain.com",
      "telephone" => "(800) 660-4287",
      "categories" => [
          {
              "id" => "429",
              "labels" => [
                  "Transportation",
                  "Transport Hubs",
                  "Rail Stations"
              ]
          }
      ]
  }

  EXPLORE_STREAM = {
      "description" => "Photos uploaded to App.net",
      "slug" => "photos",
      "title" => "Photos",
      "url" => "https://alpha-api.app.net/stream/0/posts/stream/explore/photos"
  }

  FILTER = {
      "clauses" => [
          {
              "field" => "/data/entities/hashtags/*/name",
              "object_type" => "post",
              "operator" => "matches",
              "value" => "rollout"
          }
      ],
      "id" => "1",
      "match_policy" => "include_any",
      "name" => "Posts about rollouts",
      "owner" => "...user object..."
  }

  APP_STREAM = {
      "endpoint" => "https://stream-channel.app.net...",
      "filter" => "...filter object...",
      "id" => "1",
      "object_types" => [
          "post"
      ],
      "type" => "long_poll",
      "key" => "rollout_stream"
  }

  MARKER = {
      "name" => "global"
  }

  FULL_MARKER = MARKER.merge({
      "id" => "1234",
      "last_read_id" => "2345",
      "percentage" => 0,
      "updated_at" => "2012-11-09T23:35:38Z",
      "version" => "NWoZK3kTsExUV00Ywo1G5jlUKKs"
  })

  REPOST_INTERACTION = {
      "action" => "repost",
      "event_date" => "2012-07-16T17:23:34Z",
      "objects" => [
          "...post 1..."
      ],
      "users" => [
          "...@berg's user object",
          "...@dalton's user object",
      ]
  }

  FOLLOW_INTERACTION = {
      "action" => "follow",
      "event_date" => "2012-07-16T17:23:34Z",
      "objects" => [
          "...@dalton's user object",
      ],
      "users" => [
          "...@berg's user object",
      ]
  }
end

include Resources::Helpers
