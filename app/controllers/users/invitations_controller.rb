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
    @user = User.find_by(email: params[:user][:email])
  

    if @user.present?
      # 既存ユーザー招待
      @user.invite!(current_user, @company_id)
    else
      # 新規ユーザー招待
      @user = User.invite_user!(invite_params, current_user, @company_id)
    end
    
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
    # 既存ユーザーの場合
    if @user.name.present?
      Employee.create(company_id: @company_id, user_id: @user_id)
      sign_in @user
      redirect_to company_ideas_path(@company_id)
    else
      super
    end
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

  def after_accept_path_for(resource)
    companies_path
  end
end