require 'net/http'

def masajear
  puts "poto"
end
Shoes.app width: 400 do
  background rgb(240, 250, 208)

  @uri = URI('http://localhost:3000/shippings_driver_photo.json')
  #@uri = URI('http://cins.resed.cl/shippings_driver_photo.json')
  puts @uri

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
          @instante = "3"
          puts @lat, @lng, @instante
        end
        para "Posicion 1"
      end
      flow do
        radio do 
          @lat="4"
          @lng="5"
          @instante = "6"
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
      masajear

    end
    button "Enviar apple" do
      params = {
        'dispatch_id' => @dispatch_id.text, 'data_raw' => "data:image/jpeg;base64,#{`base64 --wrap=0 manzana.jpg`}",
        'comentario' => @comentario.text
      }
      res = Net::HTTP.post_form(@uri, params)
      alert res.body
    end
    button "Enviar banana" do
      params = {
        'dispatch_id' => @dispatch_id.text, 'data_raw' => "data:image/jpeg;base64,#{`base64 --wrap=0 banana.png`}",
        'comentario' => @comentario.text
      }
      res = Net::HTTP.post_form(@uri, params)
      alert res.body
    end
    button "Enviar orange" do
      params = {
        'dispatch_id' => @dispatch_id.text, 'data_raw' => "data:image/jpeg;base64,#{`base64 --wrap=0 orange.png`}",
        'comentario' => @comentario.text
      }
      res = Net::HTTP.post_form(@uri, params)
      alert res.body
    end
    button "Enviar lena" do
      params = {
        'dispatch_id' => @dispatch_id.text, 'data_raw' => "data:image/jpeg;base64,#{`base64 --wrap=0 lena.bmp`}",
        'comentario' => @comentario.text
      }
      res = Net::HTTP.post_form(@uri, params)
      alert res.body
    end
  end
end
