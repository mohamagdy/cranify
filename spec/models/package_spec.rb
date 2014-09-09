require 'rails_helper'

RSpec.describe Package, :type => :model do
  let(:cran_author) { Parser::Person.new(name: "Mohamed", email: "mohamed@example.com") }
  let(:cran_mantainer) { Parser::Person.new(name: "Mohamed", email: "mohamed@example.com") }
  let(:cran_package) do
    Parser::Package.new(
      name: "Rify",
      version: "0.0",
      date: Date.today.to_s,
      title: "R is awesome",
      description: "R is awesome because it's awesome",
      authors: [cran_author],
      mantainers: [cran_mantainer]
    )
  end

  context "create package from params" do
    it "creates a package" do
      expect{ Package.create_from_params(cran_package) }.to change{ Package.count }.by(1)
    end

    it "creates a package and an author" do
      expect{ Package.create_from_params(cran_package) }.to change{ Author.count }.by(1)
    end

    it "creates a package and an version" do
      expect{ Package.create_from_params(cran_package) }.to change{ Mantainer.count }.by(1)
    end

    it "creates a package and an version" do
      expect{ Package.create_from_params(cran_package) }.to change{ Version.count }.by(1)
    end
  end
end
