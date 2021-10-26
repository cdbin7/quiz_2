class LikesController < ApplicationController
  def create
    idea = Idea.find params[:idea_id]
    like = Like.new(idea: idea, user: current_user)

    if can?(:like, idea)
      if like.save
        flash[:notice] = "Liked Idea"
        
      else
        flash[:alert] = like.errors.full_messages.join(', ')
      end
     
    else
      flash[:alert] = "You can't like your own idea"
    end
      redirect_to request.referer
  end

  def destroy
    like = Like.find params[:id]
    if can?(:destroy, like)
      if like.destroy
        flash[:notice] = "Unliked Idea"
        
      else
        flash[:notice] = like.errors.full_messages.join(', ')
      end
    else
      flash[:alert] = "You can't unlike you don't own"
    end
      redirect_to request.referer
  end

end
