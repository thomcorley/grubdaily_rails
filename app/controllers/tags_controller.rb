class TagsController < ApplicationController
	before_action :set_instance_variables, only: [:show, :edit, :update, :destroy]

  def edit

  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @recipe, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_instance_variables
  	@tag = Tag.find(params[:id])
  	@recipe = @tag.taggable
  end

  def tag_params
  	params.require(:tag).permit(:name)
  end
end
