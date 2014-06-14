class FavoritesController < ApplicationController

    before_filter :authenticate_user!

    def create
    	@favorite = Favorite.new()
    	@profile = Profile.find(params[:id])
    	
    	#From here out Profile references should be user references, debugging...
    	# @star = User.find(@profile.user_id)
    	@star = @profile.id

      @favorite.user_id = current_user.id
    	@favorite.star_id = @star

      @favorite.save
    	redirect_to profile_path(@profile)
    end

    def destroy
      @favorite = current_user.favorites.find(params[:id])
      @favorite.destroy
      redirect_to favorites_path
    end

    def index
      @favs = []
      current_user.favorites.order(created_at: :desc).each do |fav|
        @favs << Profile.find(fav.star_id)
      end
    end

    def show
    end

  end
