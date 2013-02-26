module ApplicationHelper
	include ActionView::Helpers::TextHelper # to be able to use pluralize in specs, views?

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "CPObaby"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end