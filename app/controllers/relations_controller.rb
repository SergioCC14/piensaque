class RelationsController < ApplicationController

  def create
    # Hay que comprobar si ya se siguen antes
    # Hay que comprobar que no se siga a si mismo
    # Hay que renderizar de nuevo el botón con (Siguiendo/Seguir)

    if (@relation = Relation.create(relation_params))

      @user = User.find_by_id(@relation.user_relation_id)

      respond_to do |format|
        format.html { render }
        format.js { render }
      end
    else
      error404
    end
  end

  # DELETE /relation/:id
  def destroy
    if (@relation = Relation.find_by_id(params[:id]))
      if (current_user.id == @relation.user_id)
        @user = User.find_by_id(@relation.user_relation_id)
        @relation.destroy

        respond_to do |format|
          format.html { render }
          format.js { render }
        end
      else
        error404
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