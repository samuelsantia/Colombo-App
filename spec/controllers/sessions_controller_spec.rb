require 'spec_helper'

describe SessionsController do
  render_views
  
  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should have the right title" do
      get 'new'
      response.should have_selector('title', :content => I18n.t('sessions.new.title'))
    end
  end
  
  describe "POST 'create'" do
    
    describe "invalid login" do
      
      before(:each) do
        @attr = { :identificator => "mail@example.com", :password => "invalid" }
      end
      
      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end
      
      it "should have right title" do
        post :create, :session => @attr
        response.should have_selector('title', :content => I18n.t('sessions.new.title'))
      end
      
      it "should have flash error" do
        post :create, :session => @attr
        flash[:error].should == I18n.t('sessions.create.error')
      end
    end
    
    describe "valid login" do
      
      before(:each) do
        @user = Factory(:user)
        @attr = { :identificator => @user.email, :password => @user.password }
      end
      
      it "should login the user" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_loged_in
      end
      
      it "should redirect to the homepage" do
        post :create, :session => @attr
        response.should redirect_to(root_path)
      end
      
      it "should login the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_loged_in
      end
      
      describe "with remember true" do
        
        before(:each) do
          @attr = @attr.merge(:remember_me => 1)
        end
        
        it "should have a cookie storage" do
          post :create, :session => @attr
          cookies[:remember_token].should_not be_nil
        end
        
        it "should not save remember token in a session" do
          post :create, :session => @attr
          session[:remember_token].should be_nil
        end
      end
      
      describe "with remember false" do
        
        before(:each) do
          @attr = @attr.merge(:remember_me => 0)
        end
        
        it "should have a session storage" do
          post :create, :session => @attr
          session[:remember_token].should_not be_nil
        end
        
        it "should not save remember token in a cookie" do
          post :create, :session => @attr
          cookies[:remember_token].should be_nil
        end
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    
    describe "with remember true" do
      
      before(:each) do
        test_login(Factory(:user), 1)
      end
      
      it "should logout the user" do
        delete :destroy
        controller.should_not be_loged_in
        response.should redirect_to(root_path)
      end
      
      it "should clear the remember token cookie" do
        delete :destroy
        cookies[:remember_token].should be_nil
      end
    end
    
    describe "with remember false" do
      
      before(:each) do
        test_login(Factory(:user))
      end
      
      it "should logout the user" do
        delete :destroy
        controller.should_not be_loged_in
        response.should redirect_to(root_path)
      end
      
      it "should clear the session storage" do
        delete :destroy
        session[:remember_token].should be_nil
      end
    end
  end
end
