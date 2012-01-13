module NinjaFund
  get '/' do
    file = File.join 'public', 'index.html'
    File.open file 
  end
end
