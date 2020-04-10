class SearchUserProfilesController < ApplicationController
  def index
    @form = Search::ProfileForm.new params[:search_profile_form]
  end
  def new
    @form = Search::ProfileForm.new(search_params)
    @data =@form.match
  end

  private
  def search_params
    params.require(:search_profile_form).permit(:self_introduction)
  end
end
