require 'erb'

# Based on https://gist.github.com/maxim/1782458
class Redirector
  def self.generate(redirects, items)
    redirect_template = ERB.new(File.read('layouts/redirect.html.erb'))

    redirects.each do |pairs|
      pairs.each_pair do |url, aliases|
        url = url.to_s
        items.each do |item|
          if item.identifier.start_with? url
            new_url = item.identifier
            aliases.each do |alias_url|
              old_url = new_url.gsub(url, alias_url)
              redirect = {:url => new_url, :title => item[:title]}
              items << Nanoc3::Item.new(redirect_template.result(binding), { :redirect => true }, old_url)
            end
          end
        end
      end
    end
  end
end
