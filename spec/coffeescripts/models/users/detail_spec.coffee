describe 'NF.Models.Users.Detail', ->
  target = new window.NF.Models.Users.Detail
  
  describe 'parse()', ->
    it 'should return the full object when there is no user property', ->
      response =
        test: 'value'
        another: 'value'
      
      expect(target.parse(response)).toBe response
      
    it 'should return the user component of the response if it exists', ->
      response =
        test: 'value'
        user: 
          another: 'value'
          
      expect(target.parse(response)).toBe response.user
  
  describe 'validate()', ->
    it 'should return an error if the user name is not supplied', ->
      result = target.validate
        email: 'test@company.com'
        password: 'password'
        
      expect(result).toEqual 'We\'re sorry, but a name is required when creating a new user.'
    
    it 'should return an error if the user name is too long', ->
      result = target.validate
        name: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consectetur ullamcorper accumsan. Nullam ut lorem erat, vel nullam.'
        email: 'test@company.com'
        password: 'password'
        
      expect(result).toEqual 'Oh no! It looks like the supplied name is too long.  Please shorten it to less than 128 characters and try again.'
      
    it 'should return an error if the email address is not supplied', ->
      result = target.validate
        name: 'Test Name'
        password: 'password'
        
      expect(result).toEqual 'We\'re sorry, but an e-mail address is required when creating a new user.'
      
    it 'should return an error if the e-mail address is longer than 128 characters', ->
      result = target.validate
        name: 'Test User'
        email: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras consectetur ullamcorper accumsan. Nullam ut lorem erat, vel nullam.'
        password: 'password'
        
      expect(result).toEqual 'Oh no! It looks like the supplied e-mail address is too long.  Please shorten it to less than 128 characters and try again.'
      
    it 'should return an error if the supplied e-mail address is invalid.', ->
      result = target.validate
        name: 'Test User'
        email: 'invalid'
        password: 'password'
      
      expect(result).toEqual 'Oh no! It looks like the supplied e-mail address is invalid.  Please correct it to the form of \'name@company.com\' and try again.'
      
    it 'should return an error if no password has been supplied', ->
      result = target.validate
        name: 'Test User'
        email: 'name@company.com'
        
      expect(result).toEqual 'We\'re sorry, but a password is required when creating a new user.'
    
    it 'should return an error if the supplied password is too short', ->
      result = target.validate
        name: 'Test User'
        email: 'name@company.com'
        password: 'a'
        
      expect(result).toEqual 'Oh no! It looks like the supplied password is too short.  When picking a password, please make it 8 or more characters.'
