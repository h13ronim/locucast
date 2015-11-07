class Upload < ActiveRecord::Base
  belongs_to :user

  has_many :uploaded_files

  validates :user, presence: true
  validates :name, presence: true

  def uploaded_files_ordered
    uploaded_files.order_as_specified(id: uploaded_files_order)
  end
end
