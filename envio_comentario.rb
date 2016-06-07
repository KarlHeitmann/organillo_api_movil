require 'net/http'

def masajear(file)
  params = {
    'dispatch_id' => @dispatch_id.text,
    'comment[comment]' => @comentario.text, 'comment[lat]' => @lat,
    'comment[lng]' => @lng, 'comment[instante]' => @instante
  }
  return params
end
Shoes.app width: 400 do
  background rgb(240, 250, 208)

  @uri = URI('http://localhost:3000/shippings_driver_comment.json')
  #@uri = URI('http://cins.resed.cl/shippings_driver_comment.json')
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
  end
end

