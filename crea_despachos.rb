require 'net/http'
require 'yaml'

CONFIG = 'config.yml'

=begin
bleh = {"dispatch"=>{
  "numero_orden_salida"=>"ASDF123456789",
 "numero_guia_de_despacho"=>"VOID",
 "patente"=>"FALLA DESPACHO",
 "origen"=>"ANTOFAGASTA",
 "destino"=>"VOID",
 "chofer_email"=>"rpti@sitrans.cl",
 "cliente_nombre"=>"WAN"
}}
=end

Shoes.app width: 400 do
  background rgb(240, 250, 208)
  @config_data = YAML.load_file(CONFIG)
  @config_data = @config_data["Parametros web"]
  stack width: 200 do
    flow do
      para "Orden de Salida (orden de salida)" #Corresponde a nombre del contenedor
      @os = edit_line
      @os.text = "ASDF123456789"
    end
    flow do
      para "Patente (patente)"
      @patente = edit_line
      @patente.text = "FALLA DESPACHO"
    end
    flow do
      para "Origen (deposito)"
      @origen = edit_line
      @origen.text = "ANTOFAGASTA"
    end
  end
  stack width: 200 do
    flow do
      para "Rut Cliente(propietario)"
      @cliente = edit_line
      @cliente.text = "WAN"
    end
    flow do
      para "Rut Chofer"
      @chofer = edit_line
      @chofer.text = "rpti@sitrans.cl"
    end
    flow do
      para "Rut Proveedor"
      @proveedor = edit_line
      @proveedor.text = "31222335K"
    end

    button "Enviar" do

      uri = URI("#{@config_data["dominio"]}/dispatches")
      puts uri
=begin
      params = {
        'dispatch[cliente_rut]' => @cliente.text, 'dispatch[proveedor_rut]' => @proveedor.text, 'dispatch[chofer_rut]' => @chofer.text,
        'dispatch[numero_orden_salida]' => @os.text,'dispatch[numero_guia_de_despacho]' => @gd.text,
        'dispatch[patente]' => @patente.text,'dispatch[origen]' => @origen.text,'dispatch[destino]' => @destino.text,
        'dispatch[codigo_contenedor]' => @cc.text
      }
=end
      params = {
        'dispatch[cliente_nombre]' => @cliente.text, 'dispatch[chofer_email]' => @chofer.text,
        'dispatch[numero_orden_salida]' => @os.text, 'dispatch[numero_guia_de_despacho]' => "VOID",
        'dispatch[patente]' => @patente.text,'dispatch[origen]' => @origen.text,'dispatch[destino]' => "VOID"
      }

      res = Net::HTTP.post_form(uri, params)
      alert res.body
      
    end
  end
end
