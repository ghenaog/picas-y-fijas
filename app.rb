require 'sinatra'
require 'sinatra/cookies'

get '/' do
  erb :index
end

get '/validar' do
  @numero = params[:numero]
  # Generating 4 values array with no repeating digits
  if cookies[:secret_number]
    vruby = cookies[:secret_number]
  else
    vruby = (0..9).to_a.shuffle.take(4).map { |i| i.to_s }.join('')
    cookies[:secret_number] = vruby
  end

  #Comparing strings
  fija = 0
  pica = 0
  i = 0
  j = 0
  while i < 4
    while j < 4
      if @numero[j] == vruby[i]
        if i == j
          fija = fija + 1
        else
          pica = pica + 1
        end
      end
      j += 1
    end
    j = 0
    i += 1
  end
  @picas = pica
  @fijas = fija
  @vruby = vruby

  if fija == 4
    @secret_number = cookies[:secret_number]
    cookies.delete(:secret_number)
    erb :ganaste
  else
    erb :validar
  end
end
