class PartyController < ApplicationController
  include YouTubeHelper
  include PartyHelper
  respond_to :json
  def index
    @party = Party.new
    @user = User.new
    @song = Song.new
  end

  def show
    @party = Party.find(session[:party_id])
    p @comments = @party.comments
    @queue = @queue = @party.queue
  end

  def create
    @party = Party.new(party_params)
    @user = User.new(user_params)
    @song = Song.new(first_song)
    if @party.save && @user.save
      session[:party_id] = @party.id
      init_song = find(first_song[:name])
      p "*" * 50
      @song = Song.create(name: init_song[:title], youtube_url: init_song[:ytid], user_id: @user.id, party_id: @party.id)
      @party.queue = []
      @queue = @party.queue << @song.serializable_hash
      @party.update(queue: @queue)
      redirect_to retrieve_party_path
    else
      flash[:notice] = @user.errors.messages
      flash[:notice] = @party.errors.messages
      render 'index'
    end
  end

  def retrieve_video_id
    find_video_helper(current_party)
    render json: {url: @current_video }.to_json, :callback => params[:callback]
  end

  def retrieve_next_video_id
    find_video_helper(current_party)
    render json: {url: @current_video }.to_json
  end

  def retrieve_queue
    @queue = Party.find_by_id(session[:party_id]).queue
    render json: {queue: @queue}.to_json
  end

private
  def party_params
    params.require(:party).permit(:hash_tag)
  end

  def first_song
    params.require(:song).permit(:name)
  end

  def user_params
    params.require(:user).permit(:name, :phone_number)
  end
end
