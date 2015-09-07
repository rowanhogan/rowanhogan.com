Time.zone = "America/New_York"

require "linkedin_scraper"

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true

set :css_dir,    'assets/stylesheets'
set :images_dir, 'assets/images'
set :js_dir,     'assets/javascripts'

sprockets.append_path File.join "#{root}", "source/assets/bower_components"
ignore 'assets/bower_components/*'

activate :blog do |blog|
  blog.layout = "layouts/blog"
  blog.page_link = "p:num"
  blog.paginate = true
  blog.per_page = 5
  blog.permalink = ":title"
  blog.prefix = "articles"
  blog.summary_length    = 200
  blog.summary_separator = /(READMORE)/
end

activate :autoprefixer
activate :livereload
activate :syntax
activate :directory_indexes

page '/404.html',     layout: false
page '/404',          layout: false
page '/rss.xml',      layout: false
page '/sitemap.xml',  layout: false

redirect 'contact/index.html',  to: '/'

@resume = ::Linkedin::Profile.get_profile("http://www.linkedin.com/in/rowanhogan")

helpers do
  def menu_link(name, link)
    if !page_classes[/(\S+\s+){#{1}}/].blank?
      klass = (link == page_classes[/(\S+\s+){#{1}}/].strip ? 'active' : nil)
    elsif page_classes == 'index' && name == 'Home'
      klass = 'active'
    end
    link_to name, "/#{link}", class: klass
  end
end

configure :build do
  activate :asset_hash
  activate :minify_css
  activate :minify_javascript
  activate :relative_assets
end

activate :deploy do |deploy|
  deploy.method = :git
end
