class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @rails_rumble_voting_banner = true
  end

  def guest
    create_guest_user
    redirect_to :uploads
  end
end
