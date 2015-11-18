class SearchesController < ApplicationController

  def index
    if params[:name]
      @search_result = Search.search_result(params[:name])
    end
  end

end
