class Package < ActiveRecord::Base
  # Relations
  has_many :versions
  has_many :mantainers
  has_many :authors

  def self.create_from_params(params)
    # Package
    package = self.where(name: params.name).first_or_initialize

    package.attributes = {
      title: params.title,
      description: params.description
    }

    package.save

    # Version and mantainers
    package.versions.where(
      number: params.version,
      publication_date: params.date
    ).first_or_create

    # Authors
    [:authors, :mantainers].each do |people|
      params.send(people).each do |person|
        package.send(people).where(
          email: person.email,
          name: person.name
        ).first_or_create
      end
    end
  end
end
