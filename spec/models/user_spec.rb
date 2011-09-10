require 'spec_helper'

describe User do
  
  before(:each) do
    @attr = { 
      :name                  => "Example", 
      :nick                  => "example-32",
      :email                 => "example@colombo.com",
      :password              => "foobar",
      :password_confirmation => "foobar"
    }
  end
  
  describe "validations" do
    
    it "should create a new instance given valid attributes" do
      User.create!(@attr)
    end
    
    describe "nick" do
      
      it "should require a nick" do
        User.new(@attr.merge(:nick => "")).should_not be_valid
      end
      
      it "should reject shorts nicks" do
        User.new(@attr.merge(:nick => "aa")).should_not be_valid
      end
      
      it "should reject long nicks" do
        long_nick = "a" * 17
        User.new(@attr.merge(:nick => long_nick)).should_not be_valid
      end

      it "should reject invalid nick" do
        invalids_nicks = ["a a", "a", "aa"]
        invalids_nicks.each do |invalid_nick|
          User.new(@attr.merge(:nick => invalid_nick)).should_not be_valid
        end
      end
      
      it "should acepts valid nicks" do
        valid_nicks = %w[example ex-ample 16example example_16]
        valid_nicks.each do |nick|
          User.new(@attr.merge(:nick => nick)).should be_valid
        end
      end
    end
    
    describe "name" do
      
      it "should require a name" do
        User.new(@attr.merge(:name => "")).should_not be_valid
      end
    end
    
    describe "email" do
    
      it "should require an email" do
        User.new(@attr.merge(:email => "")).should_not be_valid
      end
      
      it "should reject long emails" do
        long_email = "a" * 39 + "@colombo.com"
        User.new(@attr.merge(:email => long_email)).should_not be_valid
      end
      
      it "should reject invalid mails" do
        invalid_mails = %w[user@foo,com user_at_foo.org example.user@foo.]
        invalid_mails.each do |invalid_mail|
          User.new(@attr.merge(:nick => invalid_mail)).should_not be_valid
        end
      end
      
      it "should acepts valid emails" do
        valid_emails = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        valid_emails.each do |email|
          User.new(@attr.merge(:email => email)).should be_valid
        end
      end
    end
    
    describe "password" do
      
      it "should require a password" do
        User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
      end
      
      it "should require a matching password confirmation" do
        User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
      end
      
      it "should reject short passwords" do
        short = "a" * 5
        User.new(@attr.merge(:password => short, :password_confirmation => short)).should_not be_valid
      end
      
      it "should reject long passwords" do
        long = "a" * 41
        User.new(@attr.merge(:password => long, :password_confirmation => long)).should_not be_valid
      end
    end
  end
  
  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an ecrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the ecrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
  end
  
  describe "has_password? method" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should be true if the password match" do
      @user.has_password?(@attr[:password]).should be_true
    end
    
    it "should be false if the password don't match" do
      @user.has_password?("invalid").should be_false
    end
  end
  
  describe "authenticate method" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should return nil on email/password mismatch" do
      User.authenticate(@attr[:email], "wrongpass").should be_nil
    end
    
    it "should return nil on nick/password mismatch" do
      User.authenticate(@attr[:nick], "wrongpass").should be_nil
    end
    
    it "should return nil for an email with no user" do
      User.authenticate("noemail@user.com", @attr[:password]).should be_nil
    end
    
    it "should return nil for a nick with no user" do
      User.authenticate("nonick", @attr[:password]).should be_nil
    end
    
    it "should return the user on email/password match" do
      User.authenticate(@attr[:email], @attr[:password]).should == @user
    end
    
    it "should return the user on nick/password match" do
      User.authenticate(@attr[:nick], @attr[:password]).should == @user
    end
  end
end
