class JoingroupsController < ApplicationController
  before_action :set_joingroups, only: [:edit, :update, :show, :destroy]
  def update
    respond_to do |format|
      if @joingroups.update(joingroups_params)
        format.html { redirect_to @joingroups, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @joingroups }
      else
        format.html { render :edit }
        format.json { render json: @joingroups.errors, status: :unprocessable_entity }
      end
    end
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
