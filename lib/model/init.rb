module NinjaFund
  module Model
    require_relative './user'
    
    # Finalize all of the models after their declaration
    DataMapper.finalize
  end
end
