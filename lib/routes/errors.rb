module NinjaFund
  module Routes
    class Errors < Base
      error do
        file = File.join( settings.public_folder, '500.html' )
        File.open file
      end
      
      error 401 do
        file = File.join( settings.public_folder, '401.html' )
        File.open file
      end
      
      not_found do
        file = File.join( settings.public_folder, '404.html' )
        File.open file
      end
    end
  end
end
