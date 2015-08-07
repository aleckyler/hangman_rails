class PlaysController < ApplicationController
  before_action :set_play, only: [:show, :edit, :update, :destroy]

  # GET /plays
  # GET /plays.json
  def index
    @plays = Play.all
  end

  # GET /plays/1
  # GET /plays/1.json
  def show
  end

  # GET /plays/new
  def new
    @play = Play.new
  end

  # GET /plays/1/edit
  def edit
  end

  # POST /plays
  # POST /plays.json
  def create
    @play = Play.new(play_params)

    # Adding to create to hopefully make a notice if the guess is not in the available_letters

      respond_to do |format|
        if @play.save
          @play.guess = @play.guess.downcase
          if !(@play.guess =~ (/\A[a-zA-Z]+\z/))
            format.html { redirect_to :back, notice: 'Guesses must be a letter.' }
          elsif (@play.game.available_letters.include? @play.guess)
            @play.game.available_letters = (@play.game.available_letters.split() - @play.guess.split()).join(" ")
            # check if guess is in word_array
            if (@play.game.word.split(//).include? @play.guess)
              i=0
              while i < @play.game.underscore_array.length
                if @play.game.word.split(//)[i] == @play.guess
                  @play.game.underscore_array[i] = @play.guess
                end
                i += 1
              end
              @play.game.save
              if (@play.game.underscore_array == @play.game.word.split(//).join())
                @play.game.underscore_array = "Game Over!"
                @play.game.save
                format.html {redirect_to win_game_path(@play.game)}
              else
                format.html {redirect_to @play.game #, notice: "#{@play.guess} is in the word!"
              }
              end
            else
              @play.game.lives = @play.game.lives.to_i - 1
              @play.game.save
              if (@play.game.lives == "0")
                @play.game.underscore_array = "Game Over!"
                @play.game.save
                format.html {redirect_to lose_game_path(@play.game)}
              else
                format.html {redirect_to @play.game #, notice: "#{@play.guess} is not in the word."
              }
              end

            end
            # --------------------------------------------------------------------------------

            format.json { render :show, status: :created, location: @play.game }
          else

              format.html {redirect_to :back, notice: "#{@play.guess} is not an available letter."}

          end

        else
          format.html { redirect_to :back}
          format.json { render json: @play.errors, status: :unprocessable_entity }
        end
      end
      @play.destroy

    # ----------------------------------------------------------------------------------------

    # respond_to do |format|
    #   if @play.save
    #     format.html { redirect_to @play, notice: 'Play was successfully created.' }
    #     format.json { render :show, status: :created, location: @play }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @play.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /plays/1
  # PATCH/PUT /plays/1.json
  def update
    respond_to do |format|
      if @play.update(play_params)
        format.html { redirect_to @play, notice: 'Play was successfully updated.' }
        format.json { render :show, status: :ok, location: @play }
      else
        format.html { render :edit }
        format.json { render json: @play.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plays/1
  # DELETE /plays/1.json
  def destroy
    @play.destroy
    respond_to do |format|
      format.html { redirect_to plays_url, notice: 'Play was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_play
      @play = Play.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def play_params
      params.require(:play).permit(:guess, :game_id)
    end
end
