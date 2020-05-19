class ProfilesController < ApplicationController
  before_action :set_profile, except: [:index, :show]

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
    @user=User.find(params[:id])
    is_colleague = @user.companies & current_user.companies
    if is_colleague.present?
      @currentUserEntry=Entry.where(user_id: current_user.id)
      @userEntry=Entry.where(user_id: @user.id)
      if @user.id == current_user.id
      else
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        if @isRoom
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
    else
      redirect_to root_path
    end
  end

  private
  def set_profile
    @user = User.find(current_user.id)
  end

  def profile_params
    params.require(:user).permit(:id,profile_attributes:[:id,:image,:name,:sex,:self_introduction])
  end

end
