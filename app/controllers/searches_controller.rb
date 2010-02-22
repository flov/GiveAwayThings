class SearchesController < ApplicationController
  def index
    @items = Item.search(params[:search].to_s.split)t
  end
end
