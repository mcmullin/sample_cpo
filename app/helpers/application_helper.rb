module ApplicationHelper
	include ActionView::Helpers::TextHelper # e.g. to be able to use pluralize in specs, views?
  #include ActionView::Helpers::UrlHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "CPObaby"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # could NOT get this to be available in user_mailer_spec.rb, others?
  def confirm_user_url(user)
    url_for(only_path: false, 
            controller: "users", 
            id: "#{user.id}", 
            action: "confirm", 
            confirmation_code: "#{user.confirmation_code}")
  end
end