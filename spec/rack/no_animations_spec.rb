require 'spec_helper'

describe Rack::NoAnimations do
  let(:app) { double('app') }
  subject(:middleware) { described_class.new(app) }
  let(:snippet_generator) {  Rack::NoAnimations::SnippetGenerator }

  let(:snippet) { middleware.snippet }

  describe 'disabling css animations' do
    subject { snippet }

    it { is_expected.to include(snippet_generator.style_snippet) }
  end

  describe 'disabling jquery animations' do
    subject { snippet }

    it { is_expected.to include(snippet_generator.script_snippet) }
  end

  describe 'call' do

    let(:env) { double('env') }
    subject(:call) { middleware.call(env) }

    before do
      expect(app).to receive(:call).with(env).and_return([status, headers, body])
    end

    context 'html page' do
      let(:status) { 200 }
      let(:body) { '<html></html>'}
      let(:headers) { {'Content-Type' => 'text/html'} }

      it { is_expected.to be }

      context 'with body' do
        subject(:response) { _, _, response = call; response }

        let(:body) { '<html><body></body></html>' }
        it { is_expected.to eq(["<html><body>#{snippet}</body></html>"]) }
      end
    end
  end


  describe 'using percy generator' do
    subject(:middleware) { described_class.new(app, Rack::NoAnimations::Percy) }

    describe 'using only firefox' do
      subject { snippet }
      it { is_expected.to eq('<style>@-moz-document domain(proxyme.percy.io) { * { -moz-transition: none !important; transition: none !important; -moz-animation: none !important; animation: none !important; } }</style>') }
    end

  end
end
