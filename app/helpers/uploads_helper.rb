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

  def show_new_audiobook_cart?(uploads_count, uploads_slice_count, current_slice_index)
    return false if uploads_count % 4 == 0

    (4 * (current_slice_index + 1)) - (4 - uploads_slice_count) == uploads_count
  end

  def add_cover_url_image
    image_tag("https://dummyimage.com/220x220/ffffff/ffab40.png&text=Add+Cover")
  end
end
