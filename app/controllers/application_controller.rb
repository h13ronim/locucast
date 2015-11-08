class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery except: :receive_guest

  before_action :authenticate_user!
  helper_method :current_or_guest_user

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || uploads_path
  end

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id] && session[:guest_user_id] != current_user.id
        logging_in
        guest_user(with_retry = false).try(:destroy)
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user(with_retry = true)
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find(session[:guest_user_id] ||= create_guest_user.id)

  rescue ActiveRecord::RecordNotFound # if session[:guest_user_id] invalid
     session[:guest_user_id] = nil
     guest_user if with_retry
  end

  private

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    # For example:
    # guest_comments = guest_user.comments.all
    # guest_comments.each do |comment|
      # comment.user_id = current_user.id
      # comment.save!
    # end
  end

  def create_guest_user
    u = User.create(email: "guest_#{Time.now.to_i}#{rand(100)}@example.com")
    u.save!(validate: false)
    session[:guest_user_id] = u.id
    guest_user_template.uploads.each do |upload_template|
      upload = u.uploads.new(
        upload_template.attributes.reject {|k,v| [:id].include?(k.to_sym) }
      )
      raise upload.inspect unless upload.save(validate: false)
      UploadedFile.skip_callback(:commit, :after, :run_postprocess)
      upload_template.uploaded_files.each do |uploaded_file_template|
        uploaded_file = upload.uploaded_files.new(
          uploaded_file_template.attributes.reject {|k,v| [:id].include?(k.to_sym) }
        )
        raise uploaded_file.inspect unless uploaded_file.save(validate: false)
      end
    end
    u
  end

  def guest_user_template
    User.where(email: ENV['GUEST_USER_TEMPLATE']).first
  end
end
