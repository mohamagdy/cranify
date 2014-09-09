require "dcf"
require "zlib"
require "rubygems/package"
require "open-uri"

module Parser
  class CranParser
    def self.all
      packages_file_content = Net::HTTP.get(
        URI.parse(Rails.application.config.cran_packages_url)
      )

      Dcf.parse(packages_file_content).inject([]) do |memo, package|
        memo << Parser::Package.new(
          name: package["Package"],
          version: package["Version"]
        )
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
        parsed_description_file = Dcf.parse(description_file.read).first

        Parser::Package.new(
          name: parsed_description_file["Package"],
          version: parsed_description_file["Version"],
          date: parsed_description_file["Date"],
          title: parsed_description_file["Title"],
          description: parsed_description_file["Description"],
          authors: parsed_description_file["Author"],
          maintainer: parsed_description_file["Maintainer"]
        )
      end
    end
  end
end
