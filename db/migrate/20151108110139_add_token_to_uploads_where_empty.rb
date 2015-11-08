class AddTokenToUploadsWhereEmpty < ActiveRecord::Migration
  def up
    Upload.where(token: nil).find_each do |upload|
      upload.send(:generate_token)
      upload.save!
    end
  end

  def down
    puts 'WARNING: one-way data migration'
  end
end
