class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASSWORD']

    #user authenticiation with creds specified in .env
  # Rails.configuration.authenticate = {
  #   :username_key => ENV['ADMIN_USERNAME_KEY'],
  #   :password_key => ENV['ADMIN_PASSWORD_KEY']
  # }

  # http_basic_authenticate_with name: Rails.configuration.authenticate[:username_key], password: Rails.configuration.authenticate[:password_key]
  # # protect_from_forgery with: :exception

  def show
  end
end


Rails.configuration.stripe = {
  :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
  :secret_key      => ENV['STRIPE_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
