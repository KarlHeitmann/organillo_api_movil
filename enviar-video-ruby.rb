# para que el programa funcione, instalar el interprete de lenguaje ruby, y ademas, ejecutar el siguiente comando, para instalar la gema "multipart-post"
# > gem install multipart-post


require 'net/http/post/multipart'
require 'awesome_print'
require 'yaml'

CONFIG = 'config.yml'

ap ARGV 

video = ARGV[0]
despacho = ARGV[1]

@config_data = YAML.load_file(CONFIG)
@config_data = @config_data["Parametros web"]

url = URI("#{@config_data["dominio"]}/videos")



File.open("./#{video}") do |mp4| # ./pies.mp4 es la ruta al archivo que se va a subir
  params = { # Este hash contiene el contenido del video y el despacho al cual va asociado el video
    "video[data_raw]" => UploadIO.new(mp4, "video/mp4", video), # crea el contenido del video
    "video[dispatch_id]" => despacho, #corresponde al ID del despacho al cual se asociara el video
    "video[comentario]" => "Lorem ipsum de video"
  }
  ap params
  req = Net::HTTP::Post::Multipart.new(url.path, params)  #construye la peticion http
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.request(req) # ejecuta la peticion http
  end
  ap res
end
