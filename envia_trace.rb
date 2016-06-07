require 'net/http'

#'{"trace": {"lat":"-58.17256227443719","lng":"-156.65548382095133", "dispatch_id": "1", "instante":"25/02/2016-09:47", "tipo":"S"  }}' http://localhost:3000/traces.json
#'{"trace": {"lat":"-58.17256227443719","lng":"-156.65548382095133", "dispatch_id": "1", "instante":"21/02/2016-10:21", "tipo":"L"  }}' http://localhost:3000/traces.json
#'{"trace": {"lat":"-58.17256227443719","lng":"-156.65548382095133", "dispatch_id": "1", "instante":"05/01/2016-11:07", "tipo":"D"  }}' http://localhost:3000/traces.json

#'{"trace": {"lat":"-33.079","lng":"-71.605", "instante":"25/02/2016-09:47"}, "dispatch_id": '"$2"'}' localhost:3000/shippings_driver_trace.json
#'{"trace": {"lat":"-33.081","lng":"-71.612", "instante":"21/02/2016-10:21"}, "dispatch_id": '"$2"'}' localhost:3000/shippings_driver_trace.json
#'{"trace": {"lat":"-33.0805","lng":"-71.611", "instante":"05/01/2016-11:07"}, "dispatch_id": '"$2"'}' localhost:3000/shippings_driver_trace.json

Shoes.app width: 400 do
  background rgb(240, 250, 208)
  @uri = URI('http://localhost:3000/shippings_driver_trace.json')
  #@uri = URI('http://cins.resed.cl/shippings_driver_trace.json')
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
      params = {
        'dispatch_id' => @dispatch_id.text, 'trace[lat]' => "-33.079", 'trace[lng]' => "-71.605",
        'trace[instante]' => "25/02/2016-09:47", "trace[tipo]" => "S"
      }
      res = Net::HTTP.post_form(@uri, params)
      alert res.body
    end
    button "Enviar llegada" do
      params = {
        'dispatch_id' => @dispatch_id.text, 'trace[lat]' => "-33.081", 'trace[lng]' => "-71.612",
        'trace[instante]' => "21/02/2016-10:21", "trace[tipo]" => "L"
      }
      res = Net::HTTP.post_form(@uri, params)
      alert res.body
    end
    button "Enviar descarga" do
      params = {
        'dispatch_id' => @dispatch_id.text, 'trace[lat]' => "-33.0805", 'trace[lng]' => "-71.611",
        'trace[instante]' => "05/01/2016-11:07", "trace[tipo]" => "D"
      }
      res = Net::HTTP.post_form(@uri, params)
      alert res.body
    end
  end
end

