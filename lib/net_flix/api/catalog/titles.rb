module NetFlix
  module API
    module Catalog
      module Titles 

        class << self

          # example Title.search(term: 'sneakers', max_results: 10)
          def search(params = {})
            NetFlix::Request.new(url: 'http://api.netflix.com/catalog/titles', parameters: params).send
          end

          def list(params = {})
            request = NetFlix::Request.new(url: 'http://api.netflix.com/catalog/titles/full', parameters: params).send
              puts request.to_yaml
          end

        end # class methods

      end # class Titles
    end # module Catalog 
  end # module API
end # module NetFlix
