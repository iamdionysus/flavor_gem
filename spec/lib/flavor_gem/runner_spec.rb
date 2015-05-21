require "helper"

describe FlavorGem::Runner do
  it "says funcky1 funcky2 is not in flavors when generate" do
    expect { subject.generate "funcky1", "funcky2" }.to output(/not/).to_stdout
  end
end
