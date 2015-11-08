class UploadDecorator < Draper::Decorator
  delegate_all

  def title_with_author
    [object.author, object.name].join(' - ')
  end

end
