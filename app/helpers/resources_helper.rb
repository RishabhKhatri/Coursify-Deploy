module ResourcesHelper
  def embed_link(resource)
    if !resource.video.nil?
      youtubeId = YoutubeID.from(resource.video)
      resource.video = "https://youtube.com/embed/#{youtubeId}"
      resource.save!
    end
  end
end
