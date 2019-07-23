RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET show" do
    it "has a 200 status code" do
      user = create :user
      get :show, params: { id: user.id }
      expect(response.status).to eq(200)
    end

    it "has a 404 status code" do
      get :show, params: { id: 0 }
      expect(response.status).to eq(404)
    end
  end

  describe "POST create" do
    it "has a 201 status code" do
      post :create
      expect(response.status).to eq(201)
    end
  end

  describe "DELETE destroy" do
    it "has a 201 status code" do
      user = create :user
      delete :destroy, params: { id: user.id }
      expect(response.status).to eq(200)
    end
  end
end
