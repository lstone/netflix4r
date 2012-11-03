module NetFlix
    module API
        module Catalog
            module Titles

                class << self

                    # example Title.search(term: 'sneakers', max_results: 10)
                    def search(params = {})
                        NetFlix::Request.new(url: 'http://api-public.netflix.com/catalog/titles', parameters: params).send
                    end

                    #http://api-public.netflix.com/catalog/titles/streaming
                    #http://api-public.netflix.com/catalog/titles/dvd

                    def streaming(url, params = {})
                        NetFlix::Request.new(url: url, parameters: params).send
                    end

                    def dvd(url, params = {})
                        NetFlix::Request.new(url: url, parameters: params).send
                    end

                    def getDetails(url, params = {})
                        NetFlix::Request.new(url: url, parameters: params).send
                    end

                    # example NetFlix::API::Catalog::Titles.getDetails("http://api.netflix.com/catalog/titles/movies/70249769")
                    def getSynopsis(url, params = {})
                        url = url + "/synopsis"
                        NetFlix::Request.new(url: url, parameters: params).send
                    end

                    def getSimilars(title_id, title_type, params = {})
                        url = 'http://api-public.netflix.com/catalog/titles/' + title_type + '/' + title_id.to_s + '/similars'
                        NetFlix::Request.new(url: url, parameters: params).send
                    end

                end # class methods

            end # class Titles
        end # module Catalog
    end # module API
end # module NetFlix
