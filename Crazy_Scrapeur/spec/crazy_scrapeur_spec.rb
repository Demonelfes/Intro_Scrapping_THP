require_relative "../lib/crazy_scrapeur.rb"

describe "The crazy_scrapeur method" do
  it "should not return a nil value" do
    expect(crazy_scrapeur).not_to be_nil
  end
  it "should return an array of hash" do
    crazy_class = crazy_scrapeur.class
    expect(crazy_class).to eq([{}, {}].class)
  end
  it "should return 200 elements in the array" do
    count = (crazy_scrapeur).count
    expect(count).to eq(200)
  end
end
