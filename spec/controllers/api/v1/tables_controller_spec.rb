require 'rails_helper'

RSpec.describe Api::V1::TablesController, type: :controller do
  let! :tables { create_list :table, 10 }

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
    context "exist table" do
      let :table { tables.first }
      before { get :show, params: { id: table.id } }

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end

      it "has a proper attributes structure" do
        expect(json_body(response).attributes).to have_attributes(number: table.number)
      end

      it "has a proper relationships structure" do
        expect(json_body(response).relationships.restaurant.data).to have_attributes(id: table.restaurant.id.to_s)
      end
    end

    it "has a 404 status code" do
      get :show, params: { id: 0 }
      expect(response.status).to eq(404)
    end
  end

  describe "POST create" do
    context "success" do
      let :table { build :table }

      before { post :create, params: { table: table.as_json } }

      it "has a 201 status code" do
        expect(response.status).to eq(201)
      end

      it "has a proper attributes structure" do
        expect(json_body(response).attributes).to have_attributes(number: table.number)
      end

      it "has a proper relationships structure" do
        expect(json_body(response).relationships.restaurant.data).to have_attributes(id: table.restaurant.id.to_s)
      end
    end

    context "failure" do
      let :table { tables.first }
      before { post :create, params: {
        table: { number: table.number, restaurant_id: table.restaurant.id } }
      }

      it "has a 422 status code" do
        expect(response.status).to eq(422)
      end

      it "has a proper error messages" do
        expect(json_errors(response)).to have_attributes(number: ["has already been taken"])
      end
    end
  end

  describe "PUT update" do
    context "success" do
      let :new_number { Faker::Number.number(2) }
      before { put :update, params: {
        id: tables.first.id,
        table: { number: new_number }
      } }

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end

      it "has a proper attributes structure" do
        expect(json_body(response).attributes).to have_attributes(number: new_number.to_i)
      end
    end

    context "failure" do
      before { put :update, params: {
        id: tables.first.id,
        table: { number: tables.last.number, restaurant_id: tables.last.restaurant.id }
      } }

      it "has a 422 status code" do
        expect(response.status).to eq(422)
      end

      it "has a proper error messages" do
        expect(json_errors(response)).to have_attributes(number: ["has already been taken"])
      end
    end
  end

  describe "DELETE destroy" do
    it "has a 200 status code" do
      delete :destroy, params: { id: tables.last.id }
      expect(response.status).to eq(200)
    end
  end
end
