require "helper"

describe FlavorGem::Runner do
  it "says funcky_name is not in flavors when generate" do
    expect { subject.generate "funky_name" }.to output(/not/).to_stdout
  end
end
