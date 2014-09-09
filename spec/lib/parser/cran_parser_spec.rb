require "rails_helper"

describe Parser::CranParser do
  let(:all_cran_packages) { Parser::CranParser.all }

  context "parse PACKAGE file" do
    it "returns the correct number of packages" do
      expect(all_cran_packages.count).to eq(1)
    end

    it "returns the name of the parsed packages" do
      expect(all_cran_packages.first.name).to eq(@package[:name])
    end

    it "returns the version of the parsed packages" do
      expect(all_cran_packages.first.version).to eq(@package[:version])
    end
  end
end