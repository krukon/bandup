module PostsHelper
    
  def post_find_video content
    yt = content =~ REGEX[:youtube]
    vm = content =~ REGEX[:vimeo]
    links = []
    links << yt if yt
    links << vm if vm

    opt = { width: 400, height: 225, frameborder: 0 }
    if yt && yt == links.min
      opt[:src] = "//www.youtube.com/embed/" + content.scan(REGEX[:youtube])[0][4]
    end

    if vm && vm == links.min
      opt[:src] = "//player.vimeo.com/video/" + content.scan(REGEX[:vimeo])[0][2]
    end

    return nil unless opt[:src]
    content_tag(:iframe, nil, opt)
  end

end
