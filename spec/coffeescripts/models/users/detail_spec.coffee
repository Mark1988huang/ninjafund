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
    
    @
  @
