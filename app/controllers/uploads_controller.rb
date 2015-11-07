class UploadsController < ApplicationController
  before_filter :set_success_upload_flash, only: [:show]

  def new
    build_upload
  end

  def create
    build_upload
    save_upload or render :new
  end

  def show
    @upload = current_user.uploads.find(params[:id])
  end

  private

  def set_success_upload_flash
    flash[:notice] = "All files uploaded." if params[:show_success_upload_flash].present?
  end

  def save_upload
    redirect_to @upload if @upload.save
  end

  def build_upload
    @upload = upload_scope.new(upload_params)
  end

  def upload_params
    params[:upload].andand.permit(:name, :description)
  end

  def upload_scope
    current_user.uploads
  end
end
