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
    button "Fotos" do
      envia_foto
    end
    button "Traces" do
      envia_trace
    end
  end
end

