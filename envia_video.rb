require 'net/http'
require 'yaml'

CONFIG = 'config.yml'

def masajear(file)
  params = {
    'dispatch_id' => @dispatch_id.text, 'data_raw' => "data:image/jpeg;base64,#{`base64 --wrap=0 #{file}`}",
    'comentario' => @comentario.text, 'lat' => @lat, 'lng' => @lng, 'instante' => @instante
  }
  return params
end
def set_gps(lat, lng)
  @lat = lat
  @lng = lng
end
Shoes.app width: 400 do
  background rgb(240, 250, 208)
  @config_data = YAML.load_file(CONFIG)
  @config_data = @config_data["Parametros web"]

  @uri = URI("#{@config_data["dominio"]}/videos")
  puts @uri
  set_gps("-33.079", "-71.605")
  @instante = "25/02/2016-09:47"

  stack width: 200 do
    flow do 
      para "Dispatch ID"
      @dispatch_id = edit_line
      @dispatch_id.text = "1"
    end
    flow do 
      para "Comentario"
      @comentario = edit_line
      @comentario.text = "Lorem ipsum"
    end
    stack do
      flow do
        radio do
          set_gps("-33.079", "-71.605")
          puts @lat, @lng, @instante
        end
        para "Posicion 1"
      end
      flow do
        radio do 
          set_gps("-33.081", "-71.612")
          puts @lat, @lng, @instante
          masajear
        end
        para "Posicion 2"
      end
      flow do
        radio do 
          set_gps("-33.0805", "-71.611")
          puts @lat, @lng, @instante
          masajear
        end
        para "Posicion 3"
      end
    end
  end
  stack width: 200 do
    button "test" do
      puts @lat
      params = masajear("manzana.jpg")
      #puts params
    end
    button "Enviar apple" do
      params = masajear("manzana.jpg")
      res = Net::HTTP.post_form(@uri, params)
      puts res.body
      alert "recibido"
    end
    button "Enviar banana" do
      params = masajear("banana.png")
      res = Net::HTTP.post_form(@uri, params)
      puts res.body
      alert "recibido"
    end
    button "Enviar orange" do
      params = masajear("orange.png")
      res = Net::HTTP.post_form(@uri, params)
      puts res.body
      alert "recibido"
    end
    button "Enviar lena" do
      params = masajear("lena.bmp")
      res = Net::HTTP.post_form(@uri, params)
      puts res.body
      alert "recibido"
    end
  end
end
