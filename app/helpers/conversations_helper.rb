module ConversationsHelper
  # This method takes the title of the link (which is also used to specify a GET parameter), the currently opened folder, and a hash with options passed directly to the content_tag method. Then, check if the opts hash already has a class key. If not, set it to an empty string and then append an active class if this is the current box.
  def mailbox_section(title, current_box, opts = {})
    opts[:class] = opts.fetch(:class, '')
    opts[:class] += ' active' if title.downcase == current_box
    content_tag :li, link_to(title.capitalize, conversations_path(box: title.downcase)), opts
  end
end
