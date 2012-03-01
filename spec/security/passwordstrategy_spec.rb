require_relative '../spec_helper'
describe "Password Strategy" do
  def app
    Sinatra::Application
  end
  
  subject { NinjaFund::Security::PasswordStrategy.new(app) }
  
  context "when checking if the call is valid" do
    it "should return true if the username and password have been supplied" do
      request '/', :username => 'user', :password => 'password'
      subject.valid?.should be_true
    end

    it "should return true if only the password has been supplied" do
      request '/', :password => 'password'
      subject.valid?.should be_true
    end
       
    it "should return true if only the username has been supplied" do
      request '/', :username => 'user'
      subject.valid?.should be_true
    end
    
    it "should return false if neither the password nor the username have been supplied" do
      request '/'
      subject.valid?.should be_false
    end
  end
end
