module Comunicacion
  module_function
  def crear_req(token, domain, _uri_string, _metodo)
    puts token
    uri = URI(domain + _uri_string)
    if _metodo == :get
      puts "METODO GET"
      req = Net::HTTP::Get.new(uri)
    elsif _metodo == :post
      puts "______________METODO POST"
      req = Net::HTTP::Post.new(uri)
    elsif _metodo == :put
      puts "______________________________METODO PUT"
      req = Net::HTTP::Put.new(uri)
    elsif _metodo == :delete
      puts "__________________________________________METODO DELETE"
      req = Net::HTTP::Delete.new(uri)
    end
    req.add_field("Authorization:", token)
    return req, uri
  end

  def req_post(token, domain, ruta, params)
    uri = URI(domain + ruta)
    req = Net::HTTP::Post.new(uri.path)
    req["Authorization:"] = token
    req.set_form_data(params)
    return req, uri
    #req.set_form_data('alarm[tipo]' => "incendio", "alarm[patente]" => "xx1234", "alarm[nombre]" => "juan", "alarm[comentario]" => "foobar")

  end

  def mandar_mensaje(token, domain, ruta, parametros)
    req, uri = req_post(token, domain, ruta, parametros)
    resp = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
    puts parametros
    puts resp.body
    resp = JSON.parse(resp.body)

    puts resp
    return resp
  end

end

