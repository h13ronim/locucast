class AddPostprocessFieldsToUploadedFiles < ActiveRecord::Migration
  def change
    change_table :uploaded_files do |t|
      t.string :title
      t.string :author
      t.string :guid
      t.float :duration
      t.integer :length
    end
  end
end
