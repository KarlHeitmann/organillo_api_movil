require 'net/http'
Shoes.app width: 400 do
  background rgb(240, 250, 208)
  stack width: 200 do
    flow do
      para "Orden de Salida"
      @os = edit_line
    end
    flow do
      para "Guia de Despacho"
      @gd = edit_line
    end
    flow do
      para "Codigo de Contenedor"
      @cc = edit_line
    end
    flow do
      para "Patente"
      @patente = edit_line
    end
    flow do
      para "Origen"
      @origen = edit_line
    end
    flow do
      para "Destino"
      @destino = edit_line
    end
  end
  stack width: 200 do
    flow do
      para "Rut Cliente"
      @cliente = edit_line
      #@cliente.text = "21222334K"
      @cliente.text = "61704000K"
    end
    flow do
      para "Rut Chofer"
      @chofer = edit_line
      @chofer.text = "163889979"
    end
    flow do
      para "Rut Proveedor"
      @proveedor = edit_line
      @proveedor.text = "31222335K"
    end

    button "Enviar" do
      para @os.text, @gd.text
      #uri = URI('http://localhost:3000/dispatches.json')
      uri = URI('http://cins.resed.cl/dispatches.json')
      puts uri
      params = {
        'dispatch[cliente_rut]' => @cliente.text, 'dispatch[proveedor_rut]' => @proveedor.text, 'dispatch[chofer_rut]' => @chofer.text,
        'dispatch[numero_orden_salida]' => @os.text,'dispatch[numero_guia_de_despacho]' => @gd.text,
        'dispatch[patente]' => @patente.text,'dispatch[origen]' => @origen.text,'dispatch[destino]' => @destino.text,
        'dispatch[codigo_contenedor]' => @cc.text
      }

      res = Net::HTTP.post_form(uri, params)
      alert res.body
      
    end
  end
end
