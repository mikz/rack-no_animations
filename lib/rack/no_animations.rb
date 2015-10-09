module Rack
  class NoAnimations
    autoload :SnippetGenerator, 'rack/no_animations/snippet_generator'

    TEXT_HTML = %r{text/html}.freeze
    CONTENT_LENGTH = 'Content-Length'.freeze

    attr_reader :snippet

    def initialize(app, snippet_generator = SnippetGenerator)
      @app = app
      @snippet = snippet_generator.snippet.freeze
    end

    def call(env)
      status, headers, body = env = @app.call(env)

      return env unless is_html?(headers)

      response(status, headers, body)
    end

    protected

    def response(status, headers, body)
      changed, body = disable_animations(body)

      update_length(headers) if changed

      [status, headers, body]
    end

    def is_html?(headers)
      headers && headers['Content-Type'.freeze] =~ TEXT_HTML
    end

    def update_length(headers)
      content_length = headers[CONTENT_LENGTH]
      length = content_length.to_i

      if length.to_s == content_length
        headers[CONTENT_LENGTH] = (length + @snippet.length).to_s
      end
    end


    def disable_animations(response, body = '')
      Array(response).each do |s|
        body << s.to_s# read the whole body
      end

      if (body_index = body.rindex('</body>'.freeze))
        body.insert(body_index, @snippet)
      end

      [ body_index, [ body ] ]
    end
  end
end
