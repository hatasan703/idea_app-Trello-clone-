class ProfilesController < ApplicationController
  before_action :set_profile, except: :index

  def index
  end

  def new
    @user.build_profile
  end

  def create
    @user = User.new(profile_params)
    if @user.save
    else
    end
  end

  def update
    if @user.update(profile_params)
      redirect_to profiles_path
    else
      redirect_to edit_profile_path
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.profile == nil
      @user.build_profile
    end
  end

  def show
  end

  private
  def set_profile
    @user = User.find(current_user.id)
  end

  def profile_params
    params.require(:user).permit(:id,profile_attributes:[:id,:image,:name,:sex,:self_introduction])
  end

end
