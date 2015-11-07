class FeedsController < ApplicationController
  respond_to :xml

  def show
    @feed = Feed.new(upload)
  end

  private

  def upload
    @upload ||= Upload.find(params[:id])
  end
end
