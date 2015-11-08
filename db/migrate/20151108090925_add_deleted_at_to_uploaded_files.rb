class AddDeletedAtToUploadedFiles < ActiveRecord::Migration
  def change
    add_column :uploaded_files, :deleted_at, :datetime
    add_index :uploaded_files, :deleted_at
  end
end
