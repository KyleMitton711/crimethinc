class ToolsController < ApplicationController
  def index
    @html_id = 'page'
    @body_id = 'products'
    @type    = 'tools'
    @title   = title_for prefix: :tools, keys: [:index]
  end
end
