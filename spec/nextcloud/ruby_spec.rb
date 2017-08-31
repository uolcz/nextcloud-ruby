require "spec_helper"

RSpec.describe Nextcloud::Ruby do
  it "has a version number" do
    expect(Nextcloud::Ruby::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
