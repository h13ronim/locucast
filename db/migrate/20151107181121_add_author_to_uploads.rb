class AddAuthorToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :author, :string
  end
end
