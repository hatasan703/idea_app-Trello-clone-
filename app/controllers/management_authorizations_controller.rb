class ManagementAuthorizationsController < ApplicationController
  before_action :set_management_authorization, only: [:edit, :update, :show, :destroy]
  def update
    respond_to do |format|
      if @management_authorization.update(management_authorization_params)
        format.html { redirect_to @management_authorization, notice: ';jkdsl was successfully updated.' }
        format.json { render :show, status: :ok, location: @management_authorization }
      else
        format.html { render :edit }
        format.json { render json: @management_authorization.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @management_authorization.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def management_authorization_params
    params.require(:group).permit(members_attributes:[:admin,:activate,:user_id,:id])
  end

  def set_management_authorization
    @management_authorization = Group.find(params[:id])
  end
end
