class AddUploadedFilesOrderToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :uploaded_files_order, :integer, array: true, default: []
  end
end
