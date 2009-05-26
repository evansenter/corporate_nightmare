module DownloadCodesHelper
  def format_content_downloaded_for(download_code)
    content = download_code.content_downloaded
    content.map { |content, count| "#{content.title} (#{count})" }.sort.join(", ")
  end
end
