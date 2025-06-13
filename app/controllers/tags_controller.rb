class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = current_user.tags
  end

  def show
  end

  def new
    @tag = current_user.tags.build
  end

  def create
    @tag = current_user.tags.build(tag_params)

    if @tag.save
      redirect_to tags_path, notice: "Tag was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path, notice: "Tag was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_path, notice: "Tag was successfully deleted.", status: :see_other
  end

  private

  def set_tag
    @tag = current_user.tags.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :color)
  end
end
