class UploadedFile < ActiveRecord::Base
  belongs_to :upload

  validates :upload, presence: true
  validates :url, presence: true

  def name
    url.split("/").last
  end
end
