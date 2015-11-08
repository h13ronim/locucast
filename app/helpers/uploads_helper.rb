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

  def add_cover_url_image(options = {})
    image_tag("https://dummyimage.com/220x220/ffffff/ffab40.png&text=Add+Cover", options)
  end

  def cover_image(upload, with_link = true, class_name = nil)
    options = {}
    options[:class] = class_name if class_name
    options[:style] = "min-height: 220px"

    if upload.picture_url
      image_tag(upload.picture_url, options)
    else
      with_link ? link_to(add_cover_url_image, audiobook_path(upload), options) : add_cover_url_image(options)
    end
  end

  def uploads_form_path(upload)
    if params[:action] == 'edit'
      audiobook_path(@upload)
    else
      audiobooks_path
    end
  end
end
