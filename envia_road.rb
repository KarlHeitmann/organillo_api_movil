require 'net/http'

def masajear
  params = {
    'road[lat]' => "-33.081", 'road[lng]' => "-71.612"
  }
end

Shoes.app width: 400 do
  background rgb(240, 250, 208)
  @uri = URI('http://localhost:3000')
  #@uri = URI('http://cins.resed.cl')
  puts @uri

  stack width: 200 do
    flow do
      para "Dispatch ID"
      @dispatch_id = edit_line
      @dispatch_id.text = "1"
    end
  end
  stack width: 200 do
    button "Enviar salida" do
      request = @uri + "/dispatches/#{@dispatch_id.text}/roads"
      params = masajear
      res = Net::HTTP.post_form(request, params)
      puts res.body
      alert "ok"
    end
  end
end


