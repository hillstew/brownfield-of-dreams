# app/facades/admin_dashboard_facade.rb
class AdminDashboardFacade
  def tutorials
    Tutorial.all
  end
end
