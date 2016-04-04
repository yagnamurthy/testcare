require 'rubygems'
require 'sitemap_generator'

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.carespotter.com"
SitemapGenerator::Sitemap.public_path = 'public/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap show file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:

  %w( show about_us how_it_works faq contact privacy terms_of_service team become_a_caregiver).each do |page|
    add "/#{page.gsub('_', '-')}", changefreq: 'monthly'
  end

  User.pluck('zipcode').uniq.each do |zipcode|
    add "/caregivers/near/#{zipcode}", changefreq: 'weekly' unless zipcode.nil?
  end

  User.pluck('city').uniq.each do |city|
    add "/caregivers/near/#{city.downcase.gsub(' ', '-')}", changefreq: 'weekly' unless city.nil?
  end

  User.pluck(:city, :state).uniq.each do |city, state|
    add "/senior-caregivers/#{state.downcase}/#{city.downcase.gsub(' ', '-')}/", changefreq: 'weekly' unless city.nil?
  end

  Caregiver.where(indexable: true).each do |caregiver|
    add "/caregivers/#{caregiver.id}", changefreq: 'monthly'
  end




  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
