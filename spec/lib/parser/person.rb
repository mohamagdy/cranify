require "rails_helper"

describe Parser::Person do
  let(:name) { "Mohamed" }
  let(:email) { "mohamed@example.com" }

  context "parse name-email string" do
    it "should parse name-email string" do
      people_str = "#{name} <#{email}>"
      people = Parser::Person.parse(people_str)

      expect(people.count).to eq(1)
      expect(people.first.name).to eq("#{name} ")
      expect(people.first.email).to eq(email)
    end
  end
end