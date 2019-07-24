RSpec.describe Api::V1::UsersController, type: :controller do
  let! :users { create_list :user, 10 }

  describe "GET index" do
    before { get :index }

    it "has a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "has a 10 elements list" do
      expect(json_body(response).size).to eq(10)
    end
  end

  describe "GET show" do
    context "exist user" do
      let :user { users.first }
      before { get :show, params: { id: user.id } }

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end

      it "has a proper attributes structure" do
        expect(json_body(response)).to have_attributes(id: user.id.to_s)
      end
    end

    it "has a 404 status code" do
      get :show, params: { id: 0 }
      expect(response.status).to eq(404)
    end
  end

  describe "POST create" do
    context "success" do
      before { post :create }

      it "has a 201 status code" do
        expect(response.status).to eq(201)
      end
    end
  end

  describe "DELETE destroy" do
    it "has a 200 status code" do
      delete :destroy, params: { id: users.last.id }
      expect(response.status).to eq(200)
    end
  end
end
