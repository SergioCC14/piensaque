class SessionsController < ApplicationController
  def new
    raise params.inspect
  end

  def create
    raise params.inspect

    respond_to do |format|
      format.html { render action: "new" }
      format.json { render json: errors, status: :unprocessable_entity }
    end
  end

  def destroy
  end

end
