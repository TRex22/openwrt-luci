require 'httparty'
# require 'httparty_with_cookies'
require 'nokogiri'
require 'oj'

require 'openwrt-luci/version'
require 'openwrt-luci/client'

module OpenwrtLuci
  class Error < StandardError; end
end
