class SearchesController < ApplicationController
  
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
    @pets = []
    @kids = []
    @ages = []
    today = Date.today
    
    # SQL filter by height and weight
    @profiles = Profile.where(:height => h, :weight => w)
    
    # Filter by distance...
    
    # Filter by orientation...
    
    # Filter by age range
    @profiles.each do |p|
      age = today.year - p.birthday.year 
      if age > @search.minage && age < @search.maxage
        @ages << p
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
