module NetFlix
    class Request < Valuable

        RESERVED_CHARACTERS = /[^A-Za-z0-9\-\._~]/

        has_value :http_method, default: 'GET'
        has_value :url, default: 'http://api-public.netflix.com/catalog/titles/index'
        has_value :parameters, klass: HashWithIndifferentAccess, default: {}

        def ordered_keys
            parameters.keys.sort
        end

        def parameter_string
            string = ordered_keys.map do |key|
                "#{key}=#{parameters[key]}"
            end.join('&')
        end

        def authenticator
            @auth = NetFlix::Authenticator.new(request: self, credentials: NetFlix.credentials)
        end

        def target
            URI.parse "#{url}?#{parameter_string}"
        end

        def log
            puts "log"
            puts target.to_s
            NetFlix.log(target.to_s)
        end

        def send
            authenticator.sign!
            log
            fetch(target)
        end

        def fetch(uri_str, limit = 10)
            # You should choose better exception.
            raise ArgumentError, 'HTTP redirect too deep' if limit == 0

            #url = URI.parse(uri_str)
            req = Net::HTTP::Get.new(uri_str, { 'User-Agent' => ua })
            response = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
            case response
                when Net::HTTPSuccess     then response
                when Net::HTTPRedirection then fetch(response['location'], limit - 1)
                else
                    response.error!
            end
        end

        def Request.encode(value)
            puts "Request.encode"
            puts value
            URI.escape(value, RESERVED_CHARACTERS) if value
        end

        # validation stuff
        has_collection :errors

        def valid?
            errors.clear
            validate_http_method
            errors.empty?
        end

        def validate_http_method
            errors << "HTTP method must be POST or GET, but I got #{http_method}" unless ['POST', 'GET'].include? http_method
        end

    end
end
