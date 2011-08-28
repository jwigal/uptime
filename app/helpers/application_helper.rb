module ApplicationHelper
  # dynamically include js or stylesheet includes from a view
  #http://media.railscasts.com/videos/088_dynamic_select_menus.mov
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files)}
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files)}
  end

  # setting page title for the application
  #http://blog.johnwyles.com/articles/2009/02/04/rails-recipe-for-setting-the-page-title-within-a-view/
  def title(phrase, container = nil)
    @page_title ||= phrase
    content_tag(container, @page_title) if container
  end


end
