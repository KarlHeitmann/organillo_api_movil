require 'net/http'

LAT = -33.081
LNG = -71.612

def masajear(i)

  if i < 7
    lat = LAT + i * 0.01
    lng = LNG + i * 0.01
  elsif i < 14
    lat = LAT + (7*2-i) * 0.01
    lng = LNG + i * 0.01
  elsif i < 21
    lat = LAT + (7*2-i) * 0.01
    lng = LNG + (7*4-i) * 0.01
  elsif i < 28
    lat = LAT + (7*4-i) * 0.01
    lng = LNG + (7*4-i) * 0.01
  end

  params = {
    'road[lat]' => lat, 'road[lng]' => lng
  }
  return params
end

Shoes.app width: 400 do
  background rgb(240, 250, 208)
  #@uri = URI('http://localhost:3000')
  @uri = URI('http://cins.resed.cl')
  puts @uri

  stack width: 200 do
    flow do
      para "Dispatch ID"
      @dispatch_id = edit_line
      @dispatch_id.text = "1"
    end
  end
  stack width: 200 do
    button "Enviar ruta 1" do
      request = @uri + "/dispatches/#{@dispatch_id.text}/roads"
      28.times do |i|
        params = masajear(i)
        res = Net::HTTP.post_form(request, params)
        puts res.body
        alert "ok"
      end
    end
  end
end


