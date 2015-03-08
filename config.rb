Time.zone = 'Australia/Brisbane'

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, smartypants: true

set :css_dir,    'assets/stylesheets'
set :images_dir, 'assets/images'
set :js_dir,     'assets/javascripts'

sprockets.append_path File.join "#{root}", "source/assets/bower_components"

activate :autoprefixer
activate :directory_indexes
activate :livereload
activate :syntax

activate :blog do |blog|
  blog.layout = "layouts/blog"
  blog.page_link = "p:num"
  blog.paginate = true
  blog.per_page = 20
  blog.permalink = ":title.html"
  blog.prefix = "blog"
  blog.summary_length    = 200
  blog.summary_separator = /(READMORE)/
end

page '/404.html',     layout: false
page '/404',          layout: false
page '/rss.xml',      layout: false
page '/sitemap.xml',  layout: false

page '/',             layout: :home

configure :build do
  activate :asset_hash
  activate :minify_css
  activate :minify_javascript
  activate :relative_assets
end

activate :deploy do |deploy|
  deploy.method = :git
end
