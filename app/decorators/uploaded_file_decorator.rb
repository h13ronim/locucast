class UploadedFileDecorator < Draper::Decorator
  delegate_all

  def title_with_author
    [object.author, title_or_name].join(' - ')
  end

  def title_or_name
    object.title || object.name
  end

end
