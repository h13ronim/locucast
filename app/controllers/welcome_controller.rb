class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def guest
    create_guest_user
    redirect_to audiobooks_path
  end
end
