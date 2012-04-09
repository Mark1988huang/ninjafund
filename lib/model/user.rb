module NinjaFund::Model
  class User
    include DataMapper::Resource
    #
    # Error codes for the user API are as follows:
    #
    #    10001 - An e-mail address is required when creating a new user.
    #    10002 - The specified e-mail address is already in use.
    #    10003 - The specified e-mail address is invalid.
    #    10004 - A name is required when creating a new user.
    #    10005 - The specified user name is invalid.
    #    10006 - A password is required when creating a new user.
    #    10007 - The user with the supplied ID cannot be located.
    #    1000? - An unexpected error occurred while creating the new user.
    
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
      :unique => true,
      :format => :email_address,
      :messages => {
        :presence => { 
          :code => 10001, 
          :message => 'Email' 
        },
        :is_unique => { 
          :code => 10002, 
          :message => 'Email' 
        },
        :length => { 
          :code => 10003, 
          :message => 'Email' 
        },
        :format => { 
          :code => 10003, 
          :message => 'Email' 
        }
      }
      
    property :password,
      BCryptHash,
      :required => true,
      :messages => {
        :presence => { 
          :code => 10006, 
          :message => 'Password' 
        }
      }
      
    property :name,
      String,
      :length => 128,
      :required => true,
      :messages => {
        :presence => { 
          :code => 10004, 
          :message => 'Name' 
        },
        :length => {
          :code => 10005,
          :message => 'Name'
        }
      }
  end
end
