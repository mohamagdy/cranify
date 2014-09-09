require "rails_helper"

describe Parser::CranParser do
  let(:all_cran_packages) { Parser::CranParser.all }
  let(:cran_package) do
    package = Parser::Package.new(
      name: @package[:name],
      version: @package[:version]
    )
    Parser::CranParser.find(package)
  end

  context "parse PACKAGE file" do
    it "returns the correct number of packages" do
      expect(all_cran_packages.count).to eq(1)
    end
  end

  context "parse DESCRIPTION file" do
    it "returns all the package informtion" do
      expect(cran_package.name).to eq(@package[:name])
    end

    it "returns a parser person object for authors and mantainers" do
      expect(cran_package.authors.first.class).to eq(Parser::Person)
      expect(cran_package.mantainers.first.class).to eq(Parser::Person)
    end

    it "returns the name of the parsed package" do
      expect(cran_package.name).to eq(@package[:name])
    end

    it "returns the version of the parsed package" do
      expect(cran_package.version).to eq(@package[:version])
    end
  end
end