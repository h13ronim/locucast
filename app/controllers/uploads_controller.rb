class UploadsController < ApplicationController
  def new
    build_upload
  end

  def create
    build_upload
    save_upload or render :new
  end

  private

  def save_upload
    redirect_to @upload if @upload.save
  end

  def build_upload
    @upload = upload_scope.new(upload_params)
  end

  def upload_params
    params[:upload].andand.permit(
      :name, :description,
      # TODO: multiple file attachments
    )
  end

  def upload_scope
    current_user.uploads
  end
end
