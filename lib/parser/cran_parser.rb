# econding utf-8

require "dcf"
require "zlib"
require "rubygems/package"
require "open-uri"

OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0

module Parser
  class CranParser
    def self.all
      packages_file_content = Net::HTTP.get(
        URI.parse(Rails.application.config.cran_packages_url)
      )

      Dcf.parse(packages_file_content).each do |package|
        package = self.find(
          Parser::Package.new(name: package["Package"], version: package["Version"])
        )

        ::Package.create_from_params(package)
      end
    end

    def self.find(package)
      package_root_url = Rails.application.config.cran_package_url

      extracted_package = Gem::Package::TarReader.new(
        Zlib::GzipReader.open(
          open(
            "#{package_root_url}/#{package.name}_#{package.version}.tar.gz"
          )
        )
      )

      extracted_package.seek("#{package.name}/DESCRIPTION") do |description_file|
        parsed_description_file = Dcf.parse(
          description_file.read.force_encoding("Windows-1252").encode("UTF-8")
        ).first

        Parser::Package.new(
          name: parsed_description_file["Package"],
          version: parsed_description_file["Version"],
          date: parsed_description_file["Date"],
          title: parsed_description_file["Title"],
          description: parsed_description_file["Description"],
          authors: Parser::Person.parse(parsed_description_file["Author"]),
          mantainers: Parser::Person.parse(parsed_description_file["Maintainer"])
        )
      end
    end
  end
end
