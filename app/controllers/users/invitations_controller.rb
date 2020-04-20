class Users::InvitationsController < Devise::InvitationsController
  before_action :set_company_id

  def new
    super
  end

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user.nil?
      # 新規ユーザー招待
      @user = User.invite_user!(invite_params, current_user, @company_id)
      after_invite
    elsif @user.invited_judg(@company_id)
      # 既存ユーザー招待
      @user.invite!(current_user, @company_id)
      after_invite
    else
      flash[:error] = '既に招待されているユーザーです'
      render 'new'
    end

  end

  def edit
    if @user.name.present?
      Employee.join_to_company(@company_id, @user.id)
      sign_in @user
      redirect_to company_ideas_path(@company_id)
    else
      super
    end
  end

  def update
    super
    Employee.join_to_company(@company_id, @user.id)
  end

  private

  def invite_params
    params.require(:user).permit(:email)
  end

  def after_accept_path_for(resource)
    companies_path
  end

  def set_company_id
    @company_id = params[:company_id]
  end

  def after_invite
    @user.update_after_invite
    redirect_to company_ideas_path(@company_id)
  end
end