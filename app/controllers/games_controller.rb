class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @play = Play.new
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)


    respond_to do |format|
      if @game.save
        @game.word = @game.word.downcase
        @game.word_array = @game.word.split(//)
        @game.underscore_array = ""
        @game.word.length.times{ @game.underscore_array << "_" }
        j=0
        while j < @game.underscore_array.length
          if @game.word.split(//)[j] == " "
            @game.underscore_array[j] = " | "
          end
          j += 1
        end
        @game.save
        # @game.underscore_array = @underscores.split(//)

        # Sending texts to the @game.player_cell
        message = "#{@game.host_name} has invited you, #{@game.player_name}, to play hangman at https://agreens-hangman.herokuapp.com/games/#{@game.id}"
        if !(@game.player_cell.blank?)
          account_sid = 'AC6de2095bec3e026ffad44343aafb3e3e'
          auth_token = '6681e12cd0e0b799b7ac0a74d1f47795'
          @client = Twilio::REST::Client.new account_sid, auth_token

          message = @client.account.messages.create(
            :body => message,
            :to => "+1#{@game.player_cell}",
            :from => "+15618590902")
          puts message.to
        elsif !(@game.player_email.blank?)
          UserMailer.welcome_email(@game).deliver_now

          # self.mail from: "Hangman (#{@game.host_name}) <mailgun@sandboxbcfb012dd95c4c1cb9a69438020e9e7f.mailgun.org>",
          #   to: "#{@game.player_email}",
          #   subject: 'New Game Invitation',
          #   text: message

          # HTTParty.post("https://api:key-405ec90d6ff47b3c575fbdfcdef50f04"\"@api.mailgun.net/v3/sandboxbcfb012dd95c4c1cb9a69438020e9e7f.mailgun.org/messages",
          #   {:from => "Hangman (#{@game.host_name}) <mailgun@sandboxbcfb012dd95c4c1cb9a69438020e9e7f.mailgun.org>",
          #   :to => "#{@game.player_email}",
          #   :subject => "New Game Invitation",
          #   :text => message})
        end
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name, :host_name, :player_name, :player_cell, :player_email, :word, :lives, :available_letters)
    end
end
