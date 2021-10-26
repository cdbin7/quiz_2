class IdeasController < ApplicationController
  before_action :find_idea, only:[:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except:[:index, :show]
  before_action :authorize_user!, only:[:update, :destroy]

  def new
    @idea = Idea.new
  end

  def index
    @ideas = Idea.all.order(created_at: :desc)
    

  end

  def create
    @idea = Idea.new params.require(:idea).permit(:title, :description)
    @idea.user = current_user
    if @idea.save
      flash[:notice] = "Idea created successfully!"
      redirect_to idea_path(@idea)
    else
      flash[:alert] = @idea.errors.full_messages
      render :new
    end
  end

  def show
    # @idea = Idea.find params[:id]
    @reviews = @idea.reviews.order(created_at: :desc)
    @review = Review.new
    @like = @idea.likes.find_by(user: current_user)
  end

  def edit
    # @idea = Idea.find params[:id]
  end

  def update
    if @idea.update params.require(:idea).permit(:title, :description)
      redirect_to idea_path(@idea)
    else
      render :edit
    end
  end

  def destroy
    if @idea.destroy
      redirect_to ideas_path
    else
      render :show
    end
  end

  private
  def find_idea
    @idea = Idea.find params[:id]
  end

  def authorize_user!
    redirect_to root_path, alert: "Not Authorized!" unless can?(:crud, @idea)
  end

end
