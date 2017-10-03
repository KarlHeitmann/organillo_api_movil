require 'net/http'
require 'yaml'

require_relative 'rutas'


CONFIG = 'config.yml'


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

Shoes.app width: 600 do
  background rgb(240, 250, 208)
  @config_data = YAML.load_file(CONFIG)
  @config_data = @config_data["Parametros web"]

  @uri = URI("#{@config_data["dominio"]}")
  puts @uri

  stack width: 200 do
    flow do
      para "Job ID"
      @job_id = edit_line
      @job_id.text = "1"
    end
    flow do
      para "Latitud"
      @latitude = edit_line
      @latitude.text = "4.56933878"
    end
    flow do
      para "Longitude"
      @longitude = edit_line
      @longitude.text = "-74.09735803"
    end
  end

  stack width: 200 do
    button "Enviar ruta 1" do
      request = @uri + "/jobs/#{@job_id.text}/roads"
      puts RUTA_1.length
      i=0
      RUTA_1.each do |r|
        params = {
          'road[lat]' => r[:lat], 'road[lng]' => r[:lon]
        }
        puts params
        puts request
        res = Net::HTTP.post_form(request, params)
        puts res.body
        puts i
        i+=1
        alert "ok"
      end
    end

    button "Enviar ruta 2" do
      request = @uri + "/jobs/#{@job_id.text}/roads"
      puts RUTA_2.length
      i=0
      RUTA_2.each do |r|
        params = {
          'road[lat]' => r[:lat], 'road[lng]' => r[:lon]
        }
        res = Net::HTTP.post_form(request, params)
        puts res.body
        puts i
        i+=1
        alert "ok"
      end
    end

    button "Enviar ruta 3" do
      request = @uri + "/jobs/#{@job_id.text}/roads"
      puts RUTA_3.length
      i=0
      RUTA_3.each do |r|
        params = {
          'road[lat]' => r[:lat], 'road[lng]' => r[:lon]
        }
        res = Net::HTTP.post_form(request, params)
        puts res.body
        puts i
        i+=1
        alert "ok"
      end
    end

    button "Enviar ruta 4" do
      request = @uri + "/jobs/#{@job_id.text}/roads"
      puts RUTA_4.length
      i=0
      RUTA_4.each do |r|
        params = {
          'road[lat]' => r[:lat], 'road[lng]' => r[:lon]
        }
        res = Net::HTTP.post_form(request, params)
        puts res.body
        puts i
        i+=1
        alert "ok"
      end
    end

  end

  stack width: 200 do
    button "Enviar ruta artificial 1" do
      request = @uri + "/jobs/#{@job_id.text}/roads"
      28.times do |i|
        params = masajear(i)
        res = Net::HTTP.post_form(request, params)
        puts res.body
        alert "ok"
      end
    end

    button "Enviar ruta artificial corta" do
      request = @uri + "/jobs/#{@job_id.text}/roads"
      28.times do |i|
        if (i % 5) == 0
          params = masajear(i)
          res = Net::HTTP.post_form(request, params)
          puts res.body
          alert "ok"
        end
      end
    end

    button "Enviar test artificial" do
      request = @uri + "/jobs/#{@job_id.text}/roads"
      params = masajear(0)
      res = Net::HTTP.post_form(request, params)
      puts res.body
      alert "ok"
    end
  end
end


