class Upload < ActiveRecord::Base
  belongs_to :user

  has_many :uploaded_files

  validates :user, presence: true
  validates :name, presence: true
end
