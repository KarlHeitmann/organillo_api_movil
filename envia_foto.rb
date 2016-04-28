require 'net/http'

Shoes.app width: 400 do
  background rgb(240, 250, 208)

  #@uri = URI('http://localhost:3000/shippings_driver_photo.json')
  @uri = URI('http://cins.resed.cl/shippings_driver_photo.json')
  puts @uri

  stack width: 200 do
    flow do 
      para "Dispatch ID"
      @dispatch_id = edit_line
      @dispatch_id.text = "1"
    end
  end
  stack width: 200 do
    button "Enviar apple" do
      params = {
        'dispatch_id' => @dispatch_id.text, 'data_raw' => "data:image/jpeg;base64,#{`base64 --wrap=0 manzana.jpg`}"
      }
      res = Net::HTTP.post_form(@uri, params)
      alert res.body
    end
    button "Enviar banana" do
      params = {
        'dispatch_id' => @dispatch_id.text, 'data_raw' => "data:image/jpeg;base64,#{`base64 --wrap=0 banana.png`}"
      }
      res = Net::HTTP.post_form(@uri, params)
      alert res.body
    end
    button "Enviar orange" do
      params = {
        'dispatch_id' => @dispatch_id.text, 'data_raw' => "data:image/jpeg;base64,#{`base64 --wrap=0 orange.png`}"
      }
      res = Net::HTTP.post_form(@uri, params)
      alert res.body
    end
    button "Enviar lena" do
      params = {
        'dispatch_id' => @dispatch_id.text, 'data_raw' => "data:image/jpeg;base64,#{`base64 --wrap=0 lena.bmp`}"
      }
      res = Net::HTTP.post_form(@uri, params)
      alert res.body
    end
  end
end
