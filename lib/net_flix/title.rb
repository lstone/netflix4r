module NetFlix
  class Title < Valuable

    has_value :id
    has_value :release_year
    has_collection :genres
    has_collection :actors
    has_value :title
    has_value :web_page
    has_collection :delivery_formats

    def to_json
      attributes.to_json
    end

    def self.from_json(data)
      self.new(JSON.parse(data))
    end

    def to_s
      title || 'unknown title'
    end

    class << self

      def complete_list
        data = NetFlix::API::Catalog::Titles.index
        TitleBuilder.from_xml(data)
      end

      def search(params)
        data = NetFlix::API::Catalog::Titles.search(params)
        TitleBuilder.from_xml(data)
      end

      def getSynopsis(url, params)
          NetFlix::API::Catalog::Titles.getSynopsis(url, params)
      end

      def getSimilars(title_id, title_type, params)
          NetFlix::API::Catalog::Titles.getSimilars(title_id, title_type, params)
      end

    end
  end # class Title
end # module NetFlix

