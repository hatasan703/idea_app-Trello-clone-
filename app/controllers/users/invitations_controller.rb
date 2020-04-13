class Users::InvitationsController < Devise::InvitationsController
  def new
    @company_id = params[:company_id]
    super
  end

  def create
    @company_id = params[:company_id]
    @from    = params[:from]
    @subject = params[:invite_subject]
    @content = params[:invite_content]
    @user = User.invite_guest!(invite_params, current_user, @company_id)

    if @user.errors.empty?
      @user.update_column :invitation_sent_at, Time.now.utc
      flash[:notice] = "successfully sent invite to #{@user.email}"
      respond_with @user, :location => root_path
    else
      render :new
    end
  end

  def edit
    @company_id = params[:company_id]
    @user_id = params[:format]
    super
  end

  def update
    @company_id = params[:company_id]
    @user_id = params[:user][:user_id]
    Employee.create(company_id: @company_id, user_id: @user_id)
    super
  end

  def destroy
    super
  end

  private

  def invite_params
    params.require(:user).permit(:email)
  end
end