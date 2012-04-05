module NinjaFund::Model
  class User
    include DataMapper::Resource
    
    # set the table name for the User class
    storage_names[:default] = "users"
    
    #
    # Properties
    #
    property :id, Serial
    
    property :email,
      String,
      :length => 128,
      :required => true,
      :unique => true
      
    property :password,
      BCryptHash,
      :required => true
      
    property :name,
      String,
      :length => 128,
      :required => true
  end
end
