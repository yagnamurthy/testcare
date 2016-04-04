require 'zlib'
require 'open-uri'

class SitemapController < ApplicationController
  layout nil

  def index
    source = File.open("#{Rails.root}/public/sitemaps/sitemap.xml.gz")
    gz = Zlib::GzipReader.new(source)
    render xml: gz.read, content_type: 'application/xml'
  end
end
