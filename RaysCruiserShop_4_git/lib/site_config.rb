# This appears to be the helper for reading the '/config/config.json' file and loading application settings.
# Using the 'Yajl-ruby' gem.      see https://github.com/brianmario/yajl-ruby
require 'yajl'
module SiteConfig
  # The following turns instance method "load_config" into class / singleton method.
  # see http://ozmm.org/posts/singin_singletons.html
  extend self

  # retrieves value from the config file.
  def load_config
    return @_config if @_config
    file = File.new(File.join(Rails.root,'config','config.json'))
    @_config = Yajl::Parser.parse(file.read, :symbolize_keys => true)[Rails.env.to_sym]
  end

  # (see #load_config)
  # fetch keys from the 'config/config.json' file per running RAILS environment,
  # Example:
  #   SiteConfig[:flickr]  =>   {:key=>"a091ee547ee7db0872609d02a8e5b76f", :secret=>"65e1585ecc555eec"}
  def [](name); load_config[name] end
end