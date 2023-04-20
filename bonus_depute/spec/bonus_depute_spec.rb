require_relative "../lib/bonus_depute.rb"

describe "The get_depute_mails method" do
  it "should not return a nil value" do
    annuaire =
      Nokogiri.HTML(
        URI.open(
          "https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
        )
      )
    expect(get_depute_mails(annuaire)).not_to be_nil
  end
  it "should return an array of hash" do
    annuaire =
      Nokogiri.HTML(
        URI.open(
          "https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
        )
      )
    expect(get_depute_mails(annuaire).class).to eq([{}, {}].class)
  end
  it "should return 577 elements in the array" do
    annuaire =
      Nokogiri.HTML(
        URI.open(
          "https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"
        )
      )
    expect(get_depute_mails(annuaire).count).to eq(577)
  end
end
