module UploadsHelper
  def tokenized_feed_path(upload)
    raw(
      feed_path(
        upload,
        format: :xml,
        target: '_blank',
        token: upload.token
      )
    )
  end
end
