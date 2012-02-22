require_relative '../spec_helper'

describe "The User" do  
  subject { NinjaFund::Model::User.new }
  
  context "when authenticating" do
    before(:each) do 
      subject.password = BCrypt::Password.create('12345678') 
    end
      
    context "with the correct password" do
      it "should return true" do
        subject.authenticate('12345678').should be_true
      end
    end
    
    context "with an incorrect password" do
      it "should return false" do
        subject.authenticate('invalid').should be_false
      end
    end 
  end
end
