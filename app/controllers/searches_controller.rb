class SearchesController < ApplicationController
  
  before_action :authenticate_user!
  
  def new
    @search = Search.new
  end
  
  def create
    @search = Search.new(search_params)
    @search.user_id = current_user.id
    if @search.save
      redirect_to @search
    else
      render 'new'
    end
  end
  
  def destroy
    @search = Search.find(params[:id])
    @search.destroy
    redirect_to welcome_path
  end
  
  def show
    @search = current_user.search
    
    h = (@search.minheight..@search.maxheight)
    w = (@search.minweight..@search.maxweight)
    a = (@search.minage..@search.maxage)
    t = true
    @pets = []
    @kids = []
    @ages = []
    today = Date.today
    @orient = []
    @dist = []
    @myage = today.year - current_user.profile.birthday.year 
    
    # SQL filter by height and weight
    @profiles = Profile.where(:single => true, :height => h, :weight => w)
    
    # Filter by distance...
    # @profiles.each do |p|
      # distance = Geocoder::Calculations.distance_between([p.latitude,p.longitude], [current_user.profile.latitude,current_user.profile.longitude])
      # distance = p.distance_to(current_user.profile)
      # if distance <= @search.distance
        # @dist << p
      # end
    # end
    # @dist = current_user.profile.nearbys(@search.distance)
    @dist = @profiles.near(current_user.profile.zipcode, @search.distance)
    @profiles = @dist
    
    # Filter by orientation...
    if current_user.profile.orientation == 'S'
      @profiles.each do |p|
        if p.gender != current_user.profile.gender && (p.orientation == 'S' || p.orientation == 'B')
          @orient << p
        end
      end
    end
    if current_user.profile.orientation == 'G'
      @profiles.each do |p|
        if p.gender == current_user.profile.gender && (p.orientation == 'G' || p.orientation == 'B')
          @orient << p
        end
      end
    end
    if current_user.profile.orientation == 'B'
      @profiles.each do |p|
        if p.orientation == 'B' || (p.orientation == 'G' && p.gender == current_user.profile.gender) || (p.orientation == 'S' && p.gender != current_user.profile.gender)
          @orient << p
        end
      end
    end
    @profiles = @orient
    
    # Filter by age range
    @profiles.each do |p|
      age = today.year - p.birthday.year 
      if age > @search.minage && age < @search.maxage 
        if p.agelimit > 0
          if @myage < age + p.agelimit && @myage > age - p.agelimit
            @ages << p
          end
        else
          @ages << p
        end
      end
    end
    @profiles = @ages
    
    # filter by pets
    if @search.pets
      @profiles.each do |p|
        @pets << p if p.pets
      end
      @profiles = @pets
    end
    
    if @search.pets == false
      @profiles.each do |p|
        @pets << p if p.pets == false
      end
      @profiles = @pets
    end
    
    # filter by kids
    if @search.kids
      @profiles.each do |p|
        @kids << p if p.kids
      end
      @profiles = @kids
    end
    
    if @search.kids == false
      @profiles.each do |p|
        @kids << p if p.kids == false
      end
      @profiles = @kids
    end

    # User.tagged_with("awesome", "cool", :any => true, :order_by_matching_tag_count => true)  
    # Sort by users who match the most tags, descending
    
  end
  
  def edit
    @search = Search.find(params[:id])
    # @search = current_user.search
  end
  
  def update
    @search = Search.find(params[:id])
    # @search = current_user.search
  	if @search.update(search_params)
  		redirect_to @search
  	else
  		render 'edit'
  	end
  end
  
  private
  
  def search_params
    params.require(:search).permit(:distance, :minheight, :minweight, :kids, :pets, :minage, :maxheight, :maxweight, :maxage, :gender)
  end
  
  
end
