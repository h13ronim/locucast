class AddPictureUrlToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :picture_url, :string
  end
end
