class UploadedFile < ActiveRecord::Base
  belongs_to :upload

  validates :upload, presence: true
  validates :url, presence: true
end
