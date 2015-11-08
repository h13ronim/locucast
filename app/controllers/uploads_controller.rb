class UploadsController < ApplicationController
  before_filter :set_upload, only: [:show, :update]
  before_filter :set_success_upload_flash, only: [:show]

  def new
    build_upload
  end

  def index
    @uploads = current_user.uploads
  end

  def create
    build_upload
    save_upload or render :new
  end

  def show
    @uploaded_files = @upload.uploaded_files
  end

  def update
    if update_upload
      redirect_to @upload
    else
      render :show
    end
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
    params[:upload].andand.permit(:name, :description, :author, uploaded_files_order: [])
  end

  def upload_scope
    current_user.uploads
  end

  def set_upload
    @upload = current_user.uploads.find(params[:id])
  end

  def update_upload
    @upload.update(upload_params)
  end
end
