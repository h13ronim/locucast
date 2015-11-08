require 'open-uri'

class UploadedFile < ActiveRecord::Base
  extend OrderAsSpecified
  acts_as_paranoid

  belongs_to :upload

  validates :upload, presence: true
  validates :url, presence: true, :url => true

  before_validation :normalize_url

  after_commit :run_postprocess, on: :create

  def name
    denormalized_url.split("/").last
  end

  private

  def run_postprocess
    UploadedFilePostprocessJob.perform_later(self)
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

  def normalize_url
    self.url = Addressable::URI.parse(url.to_s).normalize
  end

  def denormalized_url
    Addressable::URI.unencode(url.to_s)
  end
end
