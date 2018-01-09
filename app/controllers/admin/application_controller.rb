# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
module Admin
  def self.admin_types
    ['AdminUser']
  end

  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_admin

    def authenticate_admin
      unless Admin.admin_types.include?(current_user.try(:type))
        flash[:alert] = "You are not authorized to access this page."
        redirect_to(root_path)
      end
    end

  end
end
