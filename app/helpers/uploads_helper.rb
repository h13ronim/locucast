module UploadsHelper
  def tokenized_feed_path(upload)
    raw(
      feed_path(
        upload,
        format: :xml,
        token: upload.token
      )
    )
  end
end
