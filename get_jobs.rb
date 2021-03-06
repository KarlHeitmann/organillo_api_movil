require 'net/http'
require 'yaml'
require_relative 'comunicacion'

CONFIG = 'config.yml'

def masajear(file)
  params = {
    'photo[image_uid]' => "data:image/jpeg;base64,#{`base64 --wrap=0 #{file}`}",
    'photo[comentario]' => @comentario.text, 'photo[lat]' => @lat, 'photo[lng]' => @lng, 'photo[instante]' => @instante
  }
  return params
end
def set_gps(lat, lng)
  @lat = lat
  @lng = lng
end

def get_jobs
  Shoes.app width: 400 do
    background rgb(240, 250, 208)
    @config_data = YAML.load_file(CONFIG)
    @config_data = @config_data["Parametros web"]

    puts @config_data["dominio"]
    set_gps("-33.079", "-71.605")
    @instante = "25/02/2016-09:47"

    stack width: 200 do
      button "test" do
        puts @lat
        params = masajear("manzana.jpg")
        #puts params
      end
      button "Enviar apple" do
        params = masajear("manzana.jpg")
        @uri = URI("#{@config_data["dominio"]}/jobs/#{@dispatch_id.text}/photos")
        res = Net::HTTP.post_form(@uri, params)
        puts res.body
        alert "recibido"
      end
      button "Enviar banana" do
        params = masajear("banana.png")
        @uri = URI("#{@config_data["dominio"]}/jobs/#{@dispatch_id.text}/photos")
        res = Net::HTTP.post_form(@uri, params)
        puts res.body
        alert "recibido"
      end
      button "Enviar orange" do
        params = masajear("orange.png")
        @uri = URI("#{@config_data["dominio"]}/jobs/#{@dispatch_id.text}/photos")
        res = Net::HTTP.post_form(@uri, params)
        puts res.body
        alert "recibido"
      end
      button "Enviar lena" do
        params = masajear("lena.bmp")
        @uri = URI("#{@config_data["dominio"]}/jobs/#{@dispatch_id.text}/photos")
        res = Net::HTTP.post_form(@uri, params)
        puts res.body
        alert "recibido"
      end
    end
  end
end

