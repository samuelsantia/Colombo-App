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
      response.should have_selector('title', :content => I18n.t('users.new.title'))
    end
    
    it "should have a nick field" do
      get :new
      response.should have_selector("input[name='user[nick]'][type='text']")
    end
    
    it "should have a email field" do
      get :new
      response.should have_selector("input[name='user[email]'][type='email']")
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
    
    describe "Success" do
      
      before(:each) do
        @attr = { :nick => "Colombo", :email => "colombo@example.es", :name => "Pedro Martinez", :password => "foobar", :password_confirmation => "foobar" }
      end
      
      it "should redirect to homepage" do
        post :create, :user => @attr
        response.should redirect_to(root_path)
      end
      
      it "should create a new user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
    end
  end
  
  describe "GET 'my_account'" do
    
    before(:each) do
      @user = Factory(:user)
      test_login(@user)
    end
    
    it "should be succesful" do
      get :my_account
      response.should be_success
    end
    
    it "should have the right title" do
      get :my_account
      response.should have_selector("title", :content => I18n.t('users.my_account.title'))
    end
    
    it "should have a nick field" do
      get :my_account
      response.should have_selector("input[name='user[nick]'][type='text']")
    end
    
    it "should have a email field" do
      get :my_account
      response.should have_selector("input[name='user[email]'][type='email']")
    end
    
    it "should have a name field" do
      get :my_account
      response.should have_selector("input[name='user[name]'][type='text']")
    end
    
    it "should not have a password field" do
      get :my_account
      response.should_not have_selector("input[name='user[password]'][type='password']")
    end
    
    it "should not have a password confirmation field" do
      get :my_account
      response.should_not have_selector("input[name='user[password_confirmation]'][type='password']")
    end
  end
  
  describe "PUT 'update'" do
    
    before(:each) do
      @user = Factory(:user)
      test_login(@user)
    end
    
    describe "failure" do
      
      before(:each) do
        @invalid_attr = { :name => "", :email => "", :nick => "" }
      end
      
      it "should render 'my_account' page" do
        put :update, :id => @user.id, :user => @invalid_attr
        response.should render_template('my_account')
      end
      
      it "should have the right title" do
        put :update, :id => @user.id, :user => @invalid_attr
        response.should have_selector("title", :content => I18n.t('users.my_account.title'))
      end
    end
    
    describe "success" do
      
      before(:each) do
        @attr = { :nick => "newNick", :email => "newmail@mail.es", :name => "New Name" }
      end
      
      it "should change the use's attributes" do
        put :update, :id => @user.id, :user => @attr
        @user.reload
        @user.nick.should == @attr[:nick]
        @user.email.should == @attr[:email]
        @user.name.should == @attr[:name]
      end
      
      it "should redirect to my_account page" do
        put :update, :id => @user.id, :user => @attr
        response.should redirect_to(my_account_path)
      end
    end
  end

end
