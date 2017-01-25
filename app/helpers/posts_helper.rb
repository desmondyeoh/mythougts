module PostsHelper
  def highlight_hashtag(content)
    content.gsub(/#(\w+)/) { |tagname| make_link(tagname) }.html_safe
  end

  def make_link(tagname)
    link_to tagname, tag_path(tagname)
  end
end
