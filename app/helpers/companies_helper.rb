module CompaniesHelper

  def idea_count(user)
    user.ideas.where(company_id: @company.id).length
  end

  def open_idea_count(user)
    user.ideas.where(company_id: @company.id, open: true).length
  end

  def last_login_at(user)
    user.current_sign_in_at.strftime('%m/%d %H:00')
  end
end
