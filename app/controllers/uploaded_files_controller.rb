class UploadedFilesController < ApplicationController
  before_filter :set_upload, only: [:create]
  before_filter :set_uploaded_file, only: [:destroy]

  def create
    build_uploaded_file
    save_uploaded_file
  end

  def destroy
    @uploaded_file.destroy
    redirect_to audiobook_path(@uploaded_file.upload)
  end

  private

  def set_upload
    @upload = uploads_scope.find(params[:upload_id])
  end

  def uploads_scope
    current_or_guest_user.uploads
  end

  def save_uploaded_file
    redirect_to audiobook_path(@upload) if @uploaded_file.save
  end

  def build_uploaded_file
    @uploaded_file = uploaded_files_scope.new(uploaded_file_params)
  end

  def uploaded_file_params
    { url: decoded_url_param }
  end

  def decoded_url_param
    @decoded_url_param ||= URI.decode(params[:url])
  end

  def uploaded_files_scope
    @upload.andand.uploaded_files || current_or_guest_user.uploaded_files
  end

  def set_uploaded_file
    @uploaded_file = uploaded_files_scope.find(params[:id])
  end
end
