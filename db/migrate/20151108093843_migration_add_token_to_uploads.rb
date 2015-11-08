class MigrationAddTokenToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :token, :string, limit: 64
  end
end
