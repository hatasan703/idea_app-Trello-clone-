class JoingroupsController < ApplicationController
  before_action :set_joingroups, only: [:edit, :update, :show, :destroy]
  
  def update
    @member = Member.where(group_id: @joingroups.id, user_id: current_user.id)
    @member.update(activate: true)
    redirect_to @joingroups
  end

  def destroy
    @joingroups.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def joingroups_params
    params.require(:group).permit(members_attributes:[:activate,:user_id,:id])
  end

  def set_joingroups
    @joingroups = Group.find(params[:id])
  end
end
