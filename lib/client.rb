$:.unshift(File.join(File.expand_path(File.dirname(__FILE__), "client")))

#
# Mixins
#
require 'client/social'

#
# Individual clients
#
require 'client/services/bing'
require 'client/services/corpwatch'
require 'client/services/facebook'
require 'client/services/foursquare'
require 'client/services/google'
require 'client/services/hoovers'
require 'client/services/myspace'
require 'client/services/soundcloud'
require 'client/services/twitpic'
require 'client/services/twitter'
