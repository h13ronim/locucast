require 'open-uri'

class UploadedFile < ActiveRecord::Base
  extend OrderAsSpecified

  belongs_to :upload

  validates :upload, presence: true
  validates :url, presence: true

  #after_commit :run_postprocess, :on => :create

  def name
    url.split("/").last
  end

  # TODO: this is stub until better approach to sorting arrives
  def position
    1
  end

  private

  def run_postprocess
    postprocess # TODO: sidekiq
  end

  def file_io
    @file_io ||= open(url)
  end

  def mp3info
    @mp3info ||= Mp3Info.open(file_io)
  end

  def postprocess
    self.title = mp3info.tag.title
    self.author = mp3info.tag.artist
    self.guid = Digest::SHA256.hexdigest(file_io.read)
    self.duration = mp3info.length
    self.length = file_io.size
    save!
  end
end
