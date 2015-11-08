class Upload < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user

  has_many :uploaded_files

  validates :user, presence: true
  validates :name, presence: true
  validates :token, presence: true, length: { is: 64 }

  before_validation :generate_token, on: :create

  def uploaded_files_ordered
    uploaded_files.order_as_specified(id: uploaded_files_order)
  end

  private

  def generate_token
    self.token = Digest::SHA256.hexdigest(token_base)
  end

  def token_base
    [
      user_id,
      Time.now.to_s,
      ENV['TOKEN_SALT']
    ].join('#')
  end
end
