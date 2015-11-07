class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.string :name, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
