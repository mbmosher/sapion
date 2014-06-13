class PhotosController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @photos = current_user.profile.photos
    @photo = Photo.new()
    @profile = current_user.profile
  end
  
  def new
    @photo = Photo.new
  end
  
  def edit
    @photo = Photo.find(params[:id])
    @profile = current_user.profile
  end
  
  def update
    @photo = Photo.find(params[:id])
    @profile = current_user.profile
    
    if @photo.update(photo_params)
  		redirect_to profile_photos_path(@profile)
  	else
  		render 'edit'
  	end
	end
    

  def create
  	@photo = Photo.new(photo_params)
  	@profile = Profile.find(params[:profile_id])
  	
    @photo.profile_id = @profile.id

    @photo.save
  	redirect_to profile_photos_path(@profile)
  end

  def destroy
    @photo = current_user.profile.photos.find(params[:id])
    @photo.destroy
    redirect_to profile_photos_path(current_user.profile)
  end
  
  private
  
  def photo_params
    params.require(:photo).permit(:avatar, :caption, :remote_avatar_url)
  end
end
