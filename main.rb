require_relative 'envia_foto'
require_relative 'envia_trace'
#require_relative 'wapii_login'

CONFIG = 'config.yml'

puts ARGV[1]
options = {}
ARGV.each do |a|
  k, v = a.split("=")
  options[k] = v
end

 #wapii_login("logins_conductores", options)

Shoes.app width: 400 do
  background rgb(240, 250, 208)
  @config_data = YAML.load_file(CONFIG)
  @config_data = @config_data["Parametros web"]

  stack width: 200 do
    flow do
      para "Email" #Corresponde a nombre del contenedor
      @email = edit_line
      @email.text = "khf_88@yahoo.es"
    end
    flow do
      para "Password"
      @password = edit_line
      @password.text = "asdasd"
    end


    button "Obtener autenticacion" do
      uri = URI("#{@config_data["dominio"]}/authenticate.json")
      puts uri
      params = {
        'sign_in[email]' => @email.text,
        'sign_in[password]' => @password.text,
        #'sign_in[role_id]' => ROL_APLICACION[_tipo_usuario_movil]
      }
      puts params
      puts uri
      res = Net::HTTP.post_form(uri, params)
      puts res.body
      #alert res.body
      @token = JSON.parse(res.body)["auth_token"]
      @current_usuario = JSON.parse(res.body)["user"]
      puts @token
    end


    button "Fotos" do
      envia_foto
    end
    button "Traces" do
      envia_trace
    end
    button "Traces" do
      envia_trace
    end

  end
end

