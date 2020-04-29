class Ideas::IdeasController < ApplicationController
  before_action :set_idea
  before_action :is_matched_user?, only: [:update, :destroy, :move]
  include IdeasHelper


  def index
    @company = Company.find(@company_id)
    @ideas = @company.ideas.where(user_id: current_user.id).sorted
    @employees = @company.users
    @admin = current_user.employees.find_by(company_id: @company.id).admin
  end

  def public
    @company = Company.find(@company_id)
    @ideas = @company.ideas.where(open: true).order(created_at: "DESC")
    @admin = current_user.employees.find_by(company_id: @company.id).admin

    #Vueにデータを渡す
    @user = current_user
    shared_data[:user_id] = @user.try(:id)
    shared_data[:company_admin] = @user.employees.find_by(company_id: @company_id).admin
  end

  def news
     # ニュース取得
     @news_query=URI.encode(@idea.query_word+"+ビジネス+新規事業+起業")
     p @news_query
     @rss = FeedNormalizer::FeedNormalizer.parse(open("https://news.google.com/atom/search?q=#{@news_query}&hl=ja&gl=JP&ceid=JP:ja"))

     respond_to do |format|
       format.html # show.html.erb
       format.json { render json: @idea }
     end
  end

  def create
    # ニュースクエリ取得、保存
    # @idea_content = params[:idea][:content]
    # params[:idea][:query_word] = get_query_word(@idea_content)
    @idea = Idea.new(idea_params)
    respond_to do |format|
      if @idea.save
        format.html { redirect_to company_ideas_path(@company_id) }
        format.json { render :show, status: :created }
      else
        redirect_to company_ideas_path(@company_id)
      end
    end
  end

  def update
      # ニュースクエリ取得、保存
      # @idea_content = params[:idea][:content]
      # params[:idea][:query_word] = get_query_word(@idea_content)
      
    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to company_ideas_path(@company_id) }
        format.json { render :show, status: :ok }
      else
        redirect_to company_ideas_path(@company_id)
      end
    end
  end

  def hidden
    if @idea.admin_user?(current_user)
      respond_to do |format|
        if @idea.update(idea_params)
          format.html { redirect_to company_ideas_path(@company_id) }
          format.json { head :no_content }
        else
          redirect_to company_ideas_path(@company_id)
        end
      end
    end
  end

  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to company_ideas_path(@company_id) }
      format.json { head :no_content }
    end
  end

  def move
    @idea.insert_at(idea_params[:position].to_i)
    render action: :show
  end

  private
  def idea_params
    params.require(:idea).permit(:title, :content, :position, :open, :query_word)
    .merge(user_id: current_user.id, company_id: params[:company_id])
  end

  def set_idea
    @idea = Idea.find(params[:id]) if params[:id]
    @company_id = params[:company_id]
  end

  def is_matched_user?
    unless current_user.id == @idea.user_id
      redirect_to company_ideas_path(company_id)
    end
  end

end
