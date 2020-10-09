class PrototypesController < ApplicationController

  before_action :authenticate_user!
  before_action :move_to_index, except: [:index, :edit]
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototypes = Prototype.new
  end

  def create
    if Prototype.create(prototype_params)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototypes = Prototype.find(params[:id])
  end

  def update
    if Prototype.update(prototype_params)
      redirect_to prototypes_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
