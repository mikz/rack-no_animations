require 'spec_helper'

RSpec.describe Rack::NoAnimations::SnippetGenerator do

  let(:generator) { described_class.new }

  NONE = 'none !important'

  ALL_TRANSITION = "-o-transition: #{NONE}; -moz-transition: #{NONE}; -ms-transition: #{NONE}; -webkit-transition: #{NONE}; transition: #{NONE};"
  ALL_TRANSFORM = "-o-transform: #{NONE}; -moz-transform: #{NONE}; -ms-transform: #{NONE}; -webkit-transform: #{NONE}; transform: #{NONE};"
  ALL_ANIMATION = "-o-animation: #{NONE}; -moz-animation: #{NONE}; -ms-animation: #{NONE}; -webkit-animation: #{NONE}; animation: #{NONE};"

  context '#disable_properties' do
    subject { generator.disable_properties }

    it { is_expected.to match(ALL_TRANSITION) }
    it { is_expected.to match(ALL_TRANSFORM) }
    it { is_expected.to match(ALL_ANIMATION)}

    context 'only transition' do
      subject { generator.disable_properties(:transition) }

      it { is_expected.to eq(ALL_TRANSITION) }

      context 'only microsoft and opera' do
        subject { generator.disable_properties(:transition, prefixes: %w[ms o]) }

        it { is_expected.to eq("-ms-transition: #{NONE}; -o-transition: #{NONE}; transition: #{NONE};")}
      end
    end

    context 'only mozilla' do
      subject { generator.disable_properties(prefixes: 'moz') }

      it { is_expected.to eq("-moz-transition: #{NONE}; transition: #{NONE}; -moz-transform: #{NONE}; transform: #{NONE}; -moz-animation: #{NONE}; animation: #{NONE};") }
    end
  end

  context '#style' do
    subject { generator.style('CSS') }

    it { is_expected.to eq('<style>CSS</style>') }
  end


  context '.style_snippet' do
    subject { described_class.style_snippet }

    it { is_expected.to eq("<style>* { #{ALL_TRANSITION} #{ALL_TRANSFORM} #{ALL_ANIMATION} }</style>") }
  end

  context '.snippets' do
    subject { described_class.snippets }

    it { is_expected.to include(described_class.style_snippet) }
  end
end
