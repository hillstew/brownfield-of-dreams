# app/controllers/activation_controller.rb
class ActivationController < ApplicationController
  def update
    current_user.update_attribute(:status, 'active')
  end
end
