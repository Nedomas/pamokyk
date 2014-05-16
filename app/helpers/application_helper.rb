module ApplicationHelper
  def inline_svg(path)
    file = File.open("app/assets/images/#{path}", "rb")
    raw file.read
  end

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end
end
