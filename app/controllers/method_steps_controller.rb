class MethodStepsController < ApplicationController
	before_action :set_instance_variables, only: [:show, :edit, :update, :destroy]
	before_action :authenticate

	def edit

	end

	def update
		respond_to do |format|
			if @method_step.update(method_step_params)
				format.html { redirect_to @recipe, notice: 'Method Step was successfully updated.' }
				format.json { render :show, status: :ok, location: @recipe }
			else
				format.html { render :edit }
				format.json { render json: @method_step.errors, status: :unprocessable_entity }
			end
		end
	end

	private

	def set_instance_variables
		@method_step = MethodStep.find(params[:id])
		@recipe = @method_step.recipe
	end

	def method_step_params
		params.require(:method_step).permit(:position, :description)
	end
end
