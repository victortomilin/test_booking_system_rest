RSpec.describe PrepareReservationContext do
  describe "call empty" do
    let :result { PrepareReservationContext.call }

    it "should be a failure" do
      expect(result).to be_a_failure
    end

    it "has error message" do
      expect(result.message).to eq "User is not defined."
    end
  end

  describe "call for user" do
    let :result { PrepareReservationContext.call user_id: 0 }

    it "should be a failure" do
      expect(result).to be_a_failure
    end

    it "has error message" do
      expect(result.message).to eq "User is not exist."
    end
  end
end
