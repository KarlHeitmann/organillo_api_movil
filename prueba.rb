require 'net/http/post/multipart'

url = URI.parse('http://localhost:9292/videos')
File.open("./manzana.jpg") do |jpg|
  req = Net::HTTP::Post::Multipart.new url.path,
    "video[data_raw]" => UploadIO.new(jpg, "image/jpeg", "image.jpg")
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.request(req)
  end
end
