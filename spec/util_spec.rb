require "helper"

describe FlavorGem do
  it "has ALL_FLAVORS" do
    expect(FlavorGem::ALL_FLAVORS).to be_a(Array)
    all_flavors_name = FlavorGem::ALL_FLAVORS.join "|"
    expect(FlavorGem::ALL_FLAVORS_NAME).to be == all_flavors_name
  end
end

describe "Thor::Actions" do
  class Dummy < Thor
    include Thor::Actions
  end

  describe "#file_has_template?" do
    subject { Dummy.new }
    it { is_expected.to respond_to(:file_has_template?) }
    it "returns true when file includes template" do
    end
  end
end
