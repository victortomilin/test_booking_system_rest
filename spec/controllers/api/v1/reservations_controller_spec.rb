RSpec.describe Api::V1::ReservationsController, type: :controller do
  let! :reservations { create_list :reservation, 10 }

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
    context "exist reservation" do
      let :reservation { reservations.first }
      before { get :show, params: { id: reservation.id } }

      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end

      it "has a proper attributes structure" do
        expect(json_body(response).attributes).to have_attributes(
          start_date: reservation.start_date,
          end_date: reservation.end_date
        )
      end

      it "has a proper relationships structure" do
        relationships = json_body(response).relationships
        expect(relationships.user.data).to have_attributes(id: reservation.user.id.to_s)
        expect(relationships.table.data).to have_attributes(id: reservation.table.id.to_s)
      end
    end

    it "has a 404 status code" do
      get :show, params: { id: 0 }
      expect(response.status).to eq(404)
    end
  end

  describe "POST create" do
    context "success" do
      let :user { create :user }
      let :table { create :table_with_schedules }
      let :start_date { 1.days.from_now.beginning_of_day + 12.hours }
      let :end_date { 1.days.from_now.beginning_of_day + 15.hours }

      before { post :create, params: {
        reservation: {
          date: start_date,
          duration: 180,
          user_id: user.id,
          table_id: table.id
        }
      }}

      it "has a 201 status code" do
        expect(response.status).to eq(201)
      end
    end

    context "failure" do
      let :reservation { reservations.first }
      before { post :create, params: { reservation: {} }}

      it "has a 422 status code" do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE destroy" do
    it "has a 200 status code" do
      delete :destroy, params: { id: reservations.last.id }
      expect(response.status).to eq(200)
    end
  end
end
