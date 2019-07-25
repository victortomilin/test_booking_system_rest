RSpec.describe PrepareReservationContext do
  describe "call empty" do
    let :result { PrepareReservationContext.call }

    it "should be a failure" do
      expect(result).to be_a_failure
    end

    it "has error message" do
      expect(result.message).to eq "Couldn't find TestBookingSystem::Models::User without an ID"
    end
  end
end
