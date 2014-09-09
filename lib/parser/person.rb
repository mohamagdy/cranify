# econding utf-8

module Parser
  class Person < OpenStruct
    def self.parse(people)
      people.gsub("and", ",").split(", ").inject([]) do |memo, person|
        memo << self.new(
          name: person.scan(/([^<]*)/).flatten.first,
          email: person.scan(/<([^>]*)>/).flatten.first
        )
      end
    end
  end
end