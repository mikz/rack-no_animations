require 'spec_helper'
require 'rack/no_animations/percy'

RSpec.describe Rack::NoAnimations::Percy do

  subject(:generator) { described_class }

  context '.style_snippet' do
    subject { described_class.style_snippet }

    it { is_expected.to eq('<style>@-moz-document domain(proxyme.percy.io) { * { -moz-transition: none !important; transition: none !important; -moz-animation: none !important; animation: none !important; } }</style>') }
  end

  context '.snippets' do
    subject { described_class.snippets }

    it { is_expected.to include(described_class.style_snippet) }
  end
end
