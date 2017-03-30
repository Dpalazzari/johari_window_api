class HomeController < ApplicationController

  def index
    markdown = File.read('README.md')
    render html:  Redcarpet::Markdown.new(Redcarpet::Render::HTML.new).render(markdown).html_safe
  end

end