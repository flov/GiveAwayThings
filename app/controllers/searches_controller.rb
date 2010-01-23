class SearchesController < ApplicationController
  def index
    @items = Item.search(params[:search].to_s.split)
  end
end
