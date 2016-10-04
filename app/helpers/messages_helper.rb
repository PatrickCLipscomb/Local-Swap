module MessagesHelper
  # This is a helper method for the messages new form, it creates the select box where message recipients are chosen
  def recipients_options
    s = ''
    User.all.each do |user|
      s << "<option value='#{user.id}' #{'selected' if user == chosen_recipient}>#{user.name}</option>"
    end
    s.html_safe
  end
end
