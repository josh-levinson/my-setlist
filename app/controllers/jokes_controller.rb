class JokesController < ApplicationController
  before_action :set_joke, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /jokes or /jokes.json
  def index
    @jokes = current_user.jokes
  end

  # GET /jokes/1 or /jokes/1.json
  def show
  end

  # GET /jokes/new
  def new
    @joke = Joke.new
  end

  # GET /jokes/1/edit
  def edit
    @available_tags = current_user.tags
  end

  # POST /jokes or /jokes.json
  def create
    @joke = current_user.jokes.new(joke_params)
    create_or_update_new_tag

    respond_to do |format|
      if @joke.save
        format.html { redirect_to @joke, notice: "Joke was successfully created." }
        format.json { render :show, status: :created, location: @joke }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @joke.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jokes/1 or /jokes/1.json
  def update
    create_or_update_new_tag

    respond_to do |format|
      if @joke.update(joke_params)
        format.html { redirect_to @joke, notice: "Joke was successfully updated." }
        format.json { render :show, status: :ok, location: @joke }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @joke.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jokes/1 or /jokes/1.json
  def destroy
    @joke.destroy!

    respond_to do |format|
      format.html { redirect_to jokes_path, status: :see_other, notice: "Joke was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_joke
      @joke = current_user.jokes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def joke_params
      params.require(:joke).permit(:name, :description, :content, :rating, tag_ids: [])
    end

    def create_or_update_new_tag
      if params[:joke][:new_tag].present? && params[:joke][:new_tag][:name].present?
        new_tag = current_user.tags.build(
          name: params[:joke][:new_tag][:name],
          color: params[:joke][:new_tag][:color] || '#000000'
        )

        if new_tag.save
          @joke.tag_ids = (@joke.tag_ids + [new_tag.id]).uniq
        end
      end
    end
end
