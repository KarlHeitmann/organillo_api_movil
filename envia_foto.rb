require 'net/http'

def masajear(file)
  params = {
    'dispatch_id' => @dispatch_id.text, 'data_raw' => "data:image/jpeg;base64,#{`base64 --wrap=0 #{file}`}",
    'comentario' => @comentario.text, 'lat' => @lat, 'lng' => @lng, 'instante' => @instante
  }
  return params
end
Shoes.app width: 400 do
  background rgb(240, 250, 208)

  #@uri = URI('http://localhost:3000/shippings_driver_photo.json')
  @uri = URI('http://cins.resed.cl/shippings_driver_photo.json')
  puts @uri
  @lat = "0"
  @lng = "0"
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
          @lat = "1"
          @lng = "2"
          puts @lat, @lng, @instante
        end
        para "Posicion 1"
      end
      flow do
        radio do 
          @lat="4"
          @lng="5"
          puts @lat, @lng, @instante
          masajear
        end
        para "Posicion 2"
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
