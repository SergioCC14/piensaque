class RelationsController < ApplicationController

  def create

    # Hay que comprobar si ya se siguen antes

    if @relation = Relation.new(relation_params)

      respond_to do |format|
        format.html { render }
        format.js { render }
      end
    else
      error404
    end
  end


  private
    def relation_params
      params.require(:relation).permit(:user_id, :user_relation_id)
    end

end