require_relative "../lib/mairie_christmas.rb"

describe "The get_town_urls method" do
  it "should not return a nil value" do
    expect(perform).not_to be_nil
  end
  it "should return an array of hash" do
    expect(perform.class).to eq([{}, {}].class)
  end
  it "should return 185 elements in the array" do
    count = perform.count
    expect(count).to eq(185)
  end
end
