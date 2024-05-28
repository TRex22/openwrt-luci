module OpenwrtLuci
  class Client
    # include HTTParty_with_cookies

    LOGIN_PATH = '/cgi-bin/luci'
    BACKUP_PATH = '/cgi-bin/cgi-backup'

    attr_reader :username,
      :password,
      :base_path,
      :port,
      :raw_cookie,
      :sessionid,
      :token,
      :verify_ssl

    def initialize(username:, password:, base_path:, port: 8443, verify_ssl: false)
      @username = username
      @password = password
      @base_path = base_path
      @port = port
      @verify_ssl = verify_ssl
    end

    def self.compatible_api_version
      'v1'
    end

    # This is the version of the API docs this client was built off-of
    def self.api_version
      'v1 2024-05-28'
    end

    def backup
      start_time = get_micro_second_time

      login unless raw_cookie

      response = HTTParty.send(
        :post,
        "#{base_path}:#{port}#{BACKUP_PATH}",
        body: "sessionid=#{sessionid}",
        port: port,
        verify: verify_ssl
      )

      end_time = get_micro_second_time
      construct_response_stream(response, start_time, end_time)
    end

    def login
      start_time = get_micro_second_time

      response = HTTParty.send(
        :post,
        "#{base_path}:#{port}#{LOGIN_PATH}",
        body: "luci_username=#{username}&luci_password=#{password}",
        port: port,
        verify: verify_ssl
      )

      end_time = get_micro_second_time

      @login_response = construct_response_object(response, LOGIN_PATH, start_time, end_time)

      @token = response.body[/(token\": \")\w+/].split("token\": \"").last
      @sessionid = response.body[/(sessionid\": \")\w+/].split("sessionid\": \"").last
      @raw_cookie = { token: token, sessionid: sessionid }
    end

    private

    def construct_response_object(response, path, start_time, end_time)
      {
        'body' => response.body,
        'headers' => response.headers,
        'metadata' => construct_metadata(response, start_time, end_time)
      }
    end

    def construct_response_stream(response, start_time, end_time)
      {
        'body' => response.body,
        'headers' => response.headers,
        'metadata' => construct_metadata(response, start_time, end_time)
      }
    end

    def construct_metadata(response, start_time, end_time)
      total_time = end_time - start_time

      {
        'start_time' => start_time,
        'end_time' => end_time,
        'total_time' => total_time
      }
    end

    def body_is_present?(response)
      !body_is_missing?(response)
    end

    def body_is_missing?(response)
      response.body.nil? || response.body.empty?
    end

    def parse_body(response, path)
      html_body = response.body
      doc = Nokogiri::HTML(html_body)


      # TODO:
    rescue Oj::LoadError => _e
      response.body
    end

    def parse_cookie(set_cookie_str, key)
      value = nil
      expiry = nil

      set_cookie_str.each do |item|
        if item.include?(key)
          value = item.split('; ').first.split('=').last

          if item.include?('Expires') || item.include?('expires')
            item.split('; ').each do |sub_item|
              if sub_item.include?('Expires') || sub_item.include?('expires')
                expiry = Time.parse(sub_item.gsub('expires=', '').gsub('Expires=', ''))
              end
            end
          end
        end
      end

      [value, expiry]
    end

    def process_cookies
      # Cookies are always a single string separated by spaces
      raw_cookie.map { |item| item.split('; ').first }.join('; ')
    end

    def get_micro_second_time
      (Time.now.to_f * 1000000).to_i
    end

    def construct_base_path(path, params)
      constructed_path = "#{base_path}/#{path}"

      if params == {}
        constructed_path
      else
        "#{constructed_path}?#{process_params(params)}"
      end
    end

    def process_params(params)
      params.keys.map { |key| "#{key}=#{params[key]}" }.join('&')
    end
  end
end
