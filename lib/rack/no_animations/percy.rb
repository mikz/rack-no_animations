module Rack
  class NoAnimations
    class Percy < SnippetGenerator

      def disable_properties
        super(%w[transition animation], prefixes: 'moz')
      end

      def disable_css
        wrap_css('@-moz-document domain(proxyme.percy.io)', super)
      end

      def self.snippets
        [style_snippet]
      end
    end
  end
end
