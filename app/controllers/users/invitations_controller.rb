class Users::InvitationsController < Devise::InvitationsController
  # before_action :new, if: :invitations_controller?
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
    # ↑ここをカスタマイズしたい！本文届かない
    NotificationMailer.invite_message(@user, @from, @subject, @content, @company_id).deliver if @user.errors.empty?

    if @user.errors.empty?
      @user.update_column :invitation_sent_at, Time.now.utc # mark invitation as delivered
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
    binding.pry
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
    # this is called when creating invitation
    # should return an instance of resource class
    # def invite_resource
    #   # skip sending emails on invite
    #   super { |user| user.skip_invitation = true }
    # end

    # this is called when accepting invitation
    # should return an instance of resource class
    # def accept_resource
    #   binding.pry
    #   resource = resource_class.accept_invitation!(update_resource_params)
    #   # Report accepting invitation to analytics
    #   Analytics.report('invite.accept', resource.id)
    #   resource
    # end
end