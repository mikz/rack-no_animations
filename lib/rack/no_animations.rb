module Rack
  class NoAnimations
    TEXT_HTML = %r{text/html}.freeze
    CONTENT_LENGTH = 'Content-Length'.freeze

    DISABLE_ANIMATIONS_SNIPPET = <<-EOF.strip
<script>if (typeof jQuery !== 'undefined') { jQuery.fx.off = true }</script>
<style>
* {
   -o-transition: none !important;
   -moz-transition: none !important;
   -ms-transition: none !important;
   -webkit-transition: none !important;
   transition: none !important;
   -o-transform: none !important;
   -moz-transform: none !important;
   -ms-transform: none !important;
   -webkit-transform: none !important;
   transform: none !important;
   -webkit-animation: none !important;
   -moz-animation: none !important;
   -o-animation: none !important;
   -ms-animation: none !important;
   animation: none !important;
}
</style>
EOF
    SNIPPET_LENGTH = DISABLE_ANIMATIONS_SNIPPET.length

    def initialize(app)
      @app = app
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
      headers['Content-Type'.freeze] =~ TEXT_HTML
    end

    def update_length(headers)
      content_length = headers[CONTENT_LENGTH]
      length = content_length.to_i

      if length.to_s == content_length
        headers[CONTENT_LENGTH] = (length + SNIPPET_LENGTH).to_s
      end
    end


    def disable_animations(response, body = '')
      response.each do |s|
        body << s.to_s# read the whole body
      end

      if (body_index = body.rindex('</body>'.freeze))
        body.insert(body_index, DISABLE_ANIMATIONS_SNIPPET)
      end

      [ body_index, [ body ] ]
    end
  end
end
