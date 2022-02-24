require 'rails_helper'
require 'spec_helper'
require 'rack/test'

RSpec.describe GoodsController, type: :controller do
  fixtures :users

  describe "POST /bulk-upload" do
    it "will redirect unauthorised users" do
      upload_file = Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/bulk_upload.csv")
      post :bulk_upload, params: { file: upload_file }, session: { user_id: 1 }

      expect(response).to have_http_status(:no_content)
    end

    it "will accept authorised users" do
      get :index, session: { user_id: 1 }

      expect(response).to have_http_status(:ok)
    end
  end
end
