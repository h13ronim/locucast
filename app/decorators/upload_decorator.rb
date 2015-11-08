class UploadDecorator < Draper::Decorator
  delegate_all

  def title_with_author
    if object.author.present?
      "#{object.author} - #{object.name}"
    else
      object.name
    end
  end

end
