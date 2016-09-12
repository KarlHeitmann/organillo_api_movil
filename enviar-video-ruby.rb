# para que el programa funcione, instalar el interprete de lenguaje ruby, y ademas, ejecutar el siguiente comando, para instalar la gema "multipart-post"
# > gem install multipart-post


require 'net/http/post/multipart'

#url = URI.parse('http://localhost:9292/videos')
url = URI.parse('http://pti2.sitransdocs.cl/videos')
File.open("./pies.mp4") do |mp4| # ./pies.mp4 es la ruta al archivo que se va a subir
  params = { # Este hash contiene el contenido del video y el despacho al cual va asociado el video
    "video[data_raw]" => UploadIO.new(mp4, "video/mp4", "pies.mp4"), # crea el contenido del video
    "video[dispatch_id]" => "1" #corresponde al ID del despacho al cual se asociara el video
  }
  req = Net::HTTP::Post::Multipart.new(url.path, params)  #construye la peticion http
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.request(req) # ejecuta la peticion http
  end
end
