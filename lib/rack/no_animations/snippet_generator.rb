module Rack
  class NoAnimations
    class SnippetGenerator
      ALL_VENDOR_PREFIXES = %w[o moz ms webkit]
      ALL_PROPERTIES = %w[transition transform animation]

      NONE = 'none !important'

      def disable_properties(properties = self.class::ALL_PROPERTIES, prefixes: self.class::ALL_VENDOR_PREFIXES)
        props = prefix(properties, prefixes)

        all = props.map { |prop| "#{prop}: #{NONE};" }

        all.join(' ')
      end

      def disable_css(*args)
        wrap_css('*', disable_properties(*args))
      end

      def style(css)
        "<style>#{css}</style>"
      end

      def disable_jquery_fx
        '<script>if (typeof jQuery !== "undefined") { jQuery.fx.off = true; }</script>'
      end

      def self.style_snippet(*args)
        generator = new
        css = generator.disable_css(*args)
        generator.style(css)
      end

      def self.script_snippet
        generator = new
        generator.disable_jquery_fx
      end

      def self.snippets
        [ style_snippet, script_snippet ]
      end

      def self.snippet
        snippets.join
      end

      protected

      def prefix(properties, prefixes)
        props = Array(properties)
        vendors = Array(prefixes)

        props.flat_map { |prop| vendors.map{|prefix| "-#{prefix}-#{prop}" } << prop }
      end

      def wrap_css(selector, css)
        "#{selector} { #{css} }"
      end
    end
  end
end
