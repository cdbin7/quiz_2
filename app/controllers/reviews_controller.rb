class ReviewsController < ApplicationController
  before_action :find_review, only: [:destroy]
  before_action :authenticate_user!
  before_action :authorize_user!, only:[:destroy]


  def create
    @review = Review.new(review_params)
    @idea = Idea.find params[:idea_id]
    @review.idea = @idea
    @review.user = current_user

    if @review.save
      redirect_to idea_path(@idea), notice: "Review created!"
    else
      @reviews = @idea.Reviews.order(created_at: :desc)
      render '/ideas/show'
    end
  end

  def destroy
    # @review = Review.find params[:id]
    @idea = Idea.find params[:idea_id]
    if @review.destroy
      redirect_to idea_path(@idea), notice: "Review Deleted"
    else
    end
  
  end


  private

  def find_review
    @review = Review.find params[:id]
  end

  def review_params
    params.require(:review).permit(:body)
  end

  def authorize_user!
    redirect_to root_path, alert: "Not Authorized!" unless can?(:crud, @review)
  end

end
