class CreateUploadedFiles < ActiveRecord::Migration
  def change
    create_table :uploaded_files do |t|
      t.belongs_to :upload, index: true, foreign_key: true, null: false
      t.string :url, null: false

      t.timestamps null: false
    end
  end
end
