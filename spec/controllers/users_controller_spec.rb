require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector('title', :content => 'Registrarse')
    end
    
    it "should have a nick field" do
      get :new
      response.should have_selector("input[name='user[nick]'][type='text']")
    end
    
    it "should have a email field" do
      get :new
      response.should have_selector("input[name='user[email]'][type='text']")
    end
    
    it "should have a name field" do
      get :new
      response.should have_selector("input[name='user[name]'][type='text']")
    end
    
    it "should have a password field" do
      get :new
      response.should have_selector("input[name='user[password]'][type='password']")
    end
    
    it "should have a password confirmation field" do
      get :new
      response.should have_selector("input[name='user[password_confirmation]'][type='password']")
    end
  end
  
  describe "POST 'create'" do
    
    describe "Failure" do
    
      before(:each) do
        @attr = { :nick => "", :email => "", :name => "", :password => "", :password_confirmation => "" }
      end
      
      it "should re render new" do
        post :create, :user => @attr
        response.should render_template("new")
      end
      
      it "should have right title" do
        post :create, :user => @attr
        response.should have_selector('title', :content => "Registrarse")
      end
      
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end      
    end
    
  end

end
