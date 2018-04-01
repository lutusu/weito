require 'rails_helper'

RSpec.describe User, type: :model do
  it "generates a user" do
    expect{ User.create! }.to  change { User.count }.by(1)
  end
end
