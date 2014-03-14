class PropDisplaysController < ApplicationController
 layout 'profile'

  def index
  end

  def new
  	@prop_display = PropDisplay.new
  end

  def create
  	@prop_display = PropDisplay.new(params[:prop_display])
  	if @prop_display.save
  		redirect_to :back
  	end  	
  end

end
