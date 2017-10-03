require 'net/http'
require 'yaml'

CONFIG = 'config.yml'

Shoes.app width: 400 do
  background rgb(240, 250, 208)
  @config_data = YAML.load_file(CONFIG)
  @config_data = @config_data["Parametros web"]
  puts @config_data["dominio"]
  stack width: 200 do
    flow do
      para "Auxiliar 1" #Corresponde a nombre del contenedor
      @aux1 = edit_line
      @aux1.text = "ASDF123456789"
    end
    flow do
      para "Auxiliar 2"
      @aux2 = edit_line
      @aux2.text = "FALLA DESPACHO"
    end
  end
  stack width: 200 do
    flow do
      para "Usuario 1 rut"
      @usuario1 = edit_line
      @usuario1.text = "163889977"
    end
    button "Enviar" do

      uri = URI("#{@config_data["dominio"]}/jobs.json")
      puts uri
      params = {
        'job[usuario1_rut]' => @usuario1.text,
        'job[aux1]' => @aux1.text, 'job[aux2]' => @aux2.text
      }
      puts params

      res = Net::HTTP.post_form(uri, params)
      alert res.body
      
    end
  end
end
