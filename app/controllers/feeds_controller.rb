class FeedsController < ApplicationController
  respond_to :xml

  skip_before_action :authenticate_user!, if: :token?

  def show
    @feed = Feed.new(upload)
  end

  private

  def upload
    if token?
      @upload ||= Upload.where(token: params[:token]).find(params[:id])
    else
      @upload ||= current_user.uploads.find(params[:id])
    end
  end

  def token?
    params[:token].present?
  end
end
