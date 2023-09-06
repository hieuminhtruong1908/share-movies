module ApplicationHelper
  def youtube_parser(url)
    reg_exp = %r{^.*((youtu.be/)|(v/)|(/u/\w/)|(embed/)|(watch\?))\??v?=?([^#&?]*).*}
    match = url.match(reg_exp)
    match && match[7].length == 11 ? match[7] : nil
  end
end
