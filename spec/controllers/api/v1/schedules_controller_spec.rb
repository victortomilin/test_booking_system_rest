require 'rails_helper'

RSpec.describe Api::V1::SchedulesController, type: :controller do
  let! :schedules { create_list :schedule, 10 }

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
    context "exist schedule" do
      let :schedule { schedules.first }
      before { get :show, params: { id: schedule.id } }

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end

      it "has a proper attributes structure" do
        expect(json_body(response).attributes).to have_attributes(
          open_time: schedule.open_time,
          close_time: schedule.close_time,
          day_of_week: schedule.day_of_week
        )
      end

      it "has a proper relationships structure" do
        expect(json_body(response).relationships.restaurant.data).to have_attributes(id: schedule.restaurant.id.to_s)
      end
    end

    it "has a 404 status code" do
      get :show, params: { id: 0 }
      expect(response.status).to eq(404)
    end
  end

  describe "POST create" do
    context "success" do
      let :schedule { build :schedule }

      before { post :create, params: { schedule: schedule.as_json } }

      it "has a 201 status code" do
        expect(response.status).to eq(201)
      end

      it "has a proper attributes structure" do
        expect(json_body(response).attributes).to have_attributes(
          open_time: schedule.open_time,
          close_time: schedule.close_time,
          day_of_week: schedule.day_of_week
        )
      end

      it "has a proper relationships structure" do
        expect(json_body(response).relationships.restaurant.data).to have_attributes(id: schedule.restaurant.id.to_s)
      end
    end

    context "failure" do
      let :schedule { schedules.first }
      before { post :create, params: {
        schedule: { day_of_week: schedule.day_of_week, restaurant_id: schedule.restaurant.id } }
      }

      it "has a 422 status code" do
        expect(response.status).to eq(422)
      end

      it "has a proper error messages" do
        expect(json_errors(response)).to have_attributes(day_of_week: ["has already been taken"])
      end
    end
  end

  describe "PUT update" do
    context "success" do
      let :new_day_of_week { Faker::Number.between(1, 7) }
      before { put :update, params: {
        id: schedules.first.id,
        schedule: { day_of_week: new_day_of_week }
      } }

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end

      it "has a proper attributes structure" do
        expect(json_body(response).attributes).to have_attributes(day_of_week: new_day_of_week.to_i)
      end
    end

    context "failure" do
      before { put :update, params: {
        id: schedules.first.id,
        schedule: { day_of_week: schedules.last.day_of_week, restaurant_id: schedules.last.restaurant.id }
      } }

      it "has a 422 status code" do
        expect(response.status).to eq(422)
      end

      it "has a proper error messages" do
        expect(json_errors(response)).to have_attributes(day_of_week: ["has already been taken"])
      end
    end
  end

  describe "DELETE destroy" do
    it "has a 200 status code" do
      delete :destroy, params: { id: schedules.last.id }
      expect(response.status).to eq(200)
    end
  end
end
