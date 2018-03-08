require 'net/http'
require 'yaml'

require_relative 'rutas'

CONFIG = 'config.yml'


#'{"trace": {"lat":"-58.17256227443719","lng":"-156.65548382095133", "dispatch_id": "1", "instante":"25/02/2016-09:47", "tipo":"S"  }}' http://localhost:3000/traces.json
#'{"trace": {"lat":"-58.17256227443719","lng":"-156.65548382095133", "dispatch_id": "1", "instante":"21/02/2016-10:21", "tipo":"L"  }}' http://localhost:3000/traces.json
#'{"trace": {"lat":"-58.17256227443719","lng":"-156.65548382095133", "dispatch_id": "1", "instante":"05/01/2016-11:07", "tipo":"D"  }}' http://localhost:3000/traces.json

#'{"trace": {"lat":"-33.079","lng":"-71.605", "instante":"25/02/2016-09:47"}, "dispatch_id": '"$2"'}' localhost:3000/shippings_driver_trace.json
#'{"trace": {"lat":"-33.081","lng":"-71.612", "instante":"21/02/2016-10:21"}, "dispatch_id": '"$2"'}' localhost:3000/shippings_driver_trace.json
#'{"trace": {"lat":"-33.0805","lng":"-71.611", "instante":"05/01/2016-11:07"}, "dispatch_id": '"$2"'}' localhost:3000/shippings_driver_trace.json

def envia_trace
  Shoes.app width: 400 do
    puts "hola"
    background rgb(240, 250, 208)
    @config_data = YAML.load_file(CONFIG)
    @config_data = @config_data["Parametros web"]
    puts "hola"

    puts @config_data["dominio"]

    stack width: 200 do
      flow do
        para "Dispatch ID"
        @dispatch_id = edit_line
        @dispatch_id.text = "1"
      end
    end
    stack width: 200 do
      button "Enviar carga" do
        @uri = URI("#{@config_data["dominio"]}/jobs/#{@dispatch_id.text}/traces.json")
        params = {
          'trace[lat]' => RUTA_1[0][:lat], 'trace[lng]' => RUTA_1[0][:lon],
          'trace[instante]' => "25/08/2017-09:49"
        }
        res = Net::HTTP.post_form(@uri, params)
        alert res.body
      end
      button "Enviar salida" do
        @uri = URI("#{@config_data["dominio"]}/jobs/#{@dispatch_id.text}/traces.json")
        params = {
          'trace[lat]' => RUTA_2[0][:lat], 'trace[lng]' => RUTA_2[0][:lon],
          'trace[instante]' => "25/08/2017-10:47"
        }
        res = Net::HTTP.post_form(@uri, params)
        alert res.body
      end
      button "Enviar llegada" do
        @uri = URI("#{@config_data["dominio"]}/jobs/#{@dispatch_id.text}/traces.json")
        params = {
          'trace[lat]' => RUTA_3[0][:lat], 'trace[lng]' => RUTA_3[0][:lon],
          'trace[instante]' => "25/08/2017-13:21"
        }
        res = Net::HTTP.post_form(@uri, params)
        alert res.body
      end
      button "Enviar descarga" do
        @uri = URI("#{@config_data["dominio"]}/jobs/#{@dispatch_id.text}/traces.json")
        params = {
          'trace[lat]' => RUTA_4[0][:lat], 'trace[lng]' => RUTA_4[0][:lon],
          'trace[instante]' => "25/08/2017-15:07"
        }
        res = Net::HTTP.post_form(@uri, params)
        alert res.body
      end
    end
  end
end

