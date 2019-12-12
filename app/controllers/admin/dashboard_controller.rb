module Admin
  # app/controllers/admin/dashboard_controller.rb
  class DashboardController < Admin::BaseController
    def show
      @facade = AdminDashboardFacade.new
    end
  end
end
