RSpec.describe Api::V1::RestaurantsController, type: :controller do
  let! :restaurants { create_list :restaurant, 10 }

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
    context "exist restaurant" do
      let :restaurant { restaurants.first }
      before { get :show, params: { id: restaurant.id } }

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end

      it "has a proper attributes structure" do
        expect(json_body(response).attributes).to have_attributes(name: restaurant.name)
      end
    end

    it "has a 404 status code" do
      get :show, params: { id: 0 }
      expect(response.status).to eq(404)
    end
  end

  describe "POST create" do
    context "success" do
      let :name { Faker::Name.name }
      before { post :create, params: { restaurant: { name: name } } }

      it "has a 201 status code" do
        expect(response.status).to eq(201)
      end

      it "has a proper attributes structure" do
        expect(json_body(response).attributes).to have_attributes(name: name)
      end
    end

    context "failure" do
      before { post :create, params: { restaurant: { name: restaurants.first.name } } }

      it "has a 422 status code" do
        expect(response.status).to eq(422)
      end

      it "has a proper error messages" do
        expect(json_errors(response)).to have_attributes(name: ["has already been taken"])
      end
    end
  end

  describe "PUT update" do
    context "success" do
      let :new_name { Faker::Name.name }
      before { put :update, params: {
        id: restaurants.first.id,
        restaurant: { name: new_name }
      } }

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end

      it "has a proper attributes structure" do
        expect(json_body(response).attributes).to have_attributes(name: new_name)
      end
    end

    context "failure" do
      before { put :update, params: {
        id: restaurants.first.id,
        restaurant: { name: restaurants.last.name }
      } }

      it "has a 422 status code" do
        expect(response.status).to eq(422)
      end

      it "has a proper error messages" do
        expect(json_errors(response)).to have_attributes(name: ["has already been taken"])
      end
    end
  end

  describe "DELETE destroy" do
    it "has a 200 status code" do
      delete :destroy, params: { id: restaurants.last.id }
      expect(response.status).to eq(200)
    end
  end
end
