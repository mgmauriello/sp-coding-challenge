RSpec.describe Doctor do

  it "creates a doctor" do
    expect { FactoryBot.create(:doctor, name: "Dr. One") }
      .to change(Doctor, :count).by(1)
  end
end
