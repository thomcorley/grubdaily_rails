class TagsController < ApplicationController
  def edit
  	@tag = Tag.find(params[:id])
  	@recipe = @tag.taggable
  end
end
