require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, type: :controller do
  fixtures :users

  describe "GET /users" do

    it "will redirect unauthorised users" do
      get :index

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(login_path)

      get :show, params: { id: 1 }
  
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(login_path)

      get :edit, params: { id: 1 }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(login_path)

      get :update, params: { id: 1 }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(login_path)

      get :destroy, params: { id: 1 }

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(login_path)
    end

    it "will accept authorised users to the new and create action" do
      get :new

      expect(response).to have_http_status(:ok)

      post :create, params: {
        user: {
          username: "NewUser",
          password: "NewUserPassword",
          full_name: "New User",
          email_address: "NewUser@example.com"
        }
      }

      expect(response).to have_http_status(:redirect)
      expect(flash[:notice]).to eq("User was successfully created.")
    end
  end
end
