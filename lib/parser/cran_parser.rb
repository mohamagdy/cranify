require "dcf"

module Parser
  class CranParser
    def self.all
      package_file_content = Net::HTTP.get(
        URI.parse(Rails.application.config.cran_package_url)
      )

      Dcf.parse(package_file_content).inject([]) do |memo, package|
        memo << Parser::Package.new(
          name: package["Package"],
          version: package["Version"]
        )
      end
    end
  end
end