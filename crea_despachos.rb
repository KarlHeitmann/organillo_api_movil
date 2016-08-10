require 'net/http'
Shoes.app width: 400 do
  background rgb(240, 250, 208)
  stack width: 200 do
    flow do
      para "Orden de Salida (orden de salida)" #Corresponde a nombre del contenedor
      @os = edit_line
    end
    flow do
      para "Patente (patente)"
      @patente = edit_line
    end
    flow do
      para "Origen (deposito)"
      @origen = edit_line
    end
  end
  stack width: 200 do
    flow do
      para "Rut Cliente(propietario)"
      @cliente = edit_line
      #@cliente.text = "21222334K"
      #@cliente.text = "61704000K"
      @cliente.text = "Codelco"
    end
    flow do
      para "Rut Chofer"
      @chofer = edit_line
      @chofer.text = "fmedina@sitrans.cl"
    end
    flow do
      para "Rut Proveedor"
      @proveedor = edit_line
      @proveedor.text = "31222335K"
    end

    button "Enviar" do
      uri = URI('http://localhost:9292/dispatches.json')
      #uri = URI('http://cins.resed.cl/dispatches.json')
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
