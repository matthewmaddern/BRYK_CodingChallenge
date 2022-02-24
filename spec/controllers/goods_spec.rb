require 'rails_helper'
require 'spec_helper'
require 'rack/test'

RSpec.describe GoodsController, type: :controller do
  fixtures :users

  describe "POST /bulk-upload" do
    it "will accept a csv file to be uploaded" do
      upload_file = Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/bulk_upload.csv")
      post :bulk_upload, params: { file: upload_file }, session: { user_id: 1 }

      expect(flash[:error]).to be_nil
      expect(response).to have_http_status(:no_content)
    end

    it "will accept return an error if a bad csv is uploaded" do
      upload_file = Rack::Test::UploadedFile.new("#{Rails.root}/spec/fixtures/files/bulk_upload_bad.csv")
      post :bulk_upload, params: { file: upload_file }, session: { user_id: 1 }

      expect(flash[:error]).to be_present
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
