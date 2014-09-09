require 'rails_helper'

RSpec.describe Person, :type => :model do
  context "predicates" do
    it "returns true for author" do
      expect(Author.new.author?).to eq(true)
    end

    it "returns false for mantainer" do
      expect(Author.new.mantainer?).to eq(false)
    end

    it "returns true for mantainer" do
      expect(Mantainer.new.mantainer?).to eq(true)
    end

    it "returns true for author" do
      expect(Mantainer.new.author?).to eq(false)
    end
  end
end
