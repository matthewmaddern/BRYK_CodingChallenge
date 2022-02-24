require 'rails_helper'
require 'spec_helper'

RSpec.describe GoodsController, type: :controller do
  fixtures :users

  describe "GET /index" do

    it "will redirect unauthorised users" do
      get :index

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(login_path)
    end

    it "will accept authorised users" do
      get :index, session: { user_id: 1 }

      expect(response).to have_http_status(:ok)
    end
  end
end
