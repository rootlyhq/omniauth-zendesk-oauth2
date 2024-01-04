require 'omniauth'
require 'spec_helper'
require 'ostruct'

describe OmniAuth::Strategies::Zendesk do
  subject do
    OmniAuth::Strategies::Zendesk.new({})
  end

  context '#zendesk_url' do

    it "defaults to the 'test' subdomain" do
      allow(subject).to receive(:request).and_return(OpenStruct.new(params: {}))
      allow(subject).to receive(:session).and_return({})
      expect(subject.zendesk_url).to eq("https://test.zendesk.com")
    end

    it "overrides the site with client_options" do
      subject = OmniAuth::Strategies::Zendesk.new(
        'KEY', 'SECRET',
        client_options: { site: 'https://test2.zendesk.com' }
      )
      allow(subject).to receive(:request).and_return(OpenStruct.new(params: {}))
      allow(subject).to receive(:session).and_return({})
      expect(subject.zendesk_url).to eq("https://test2.zendesk.com")
    end

    it "overrides the site with a request parameter" do
      subject.options.client_options.site
      allow(subject).to receive(:session).and_return({})
      allow(subject).to receive(:request) do
        double("Request", :params => {"subdomain" => "testsite"})
      end
      expect(subject.zendesk_url).to eq('https://testsite.zendesk.com')
    end
  end

  context 'info' do
    before do
      allow(subject).to receive(:raw_info).and_return(
        'user' => {
          'email' => 'test@test.org',
          'id' => 123,
          'name' => 'Marty McFly',
          'role' => 'admin',
          'organization_id' => 456
        }
      )
    end

    it 'returns the email as uid' do
      expect(subject.uid).to eq 'test@test.org'
    end

    context 'puts all the info in the info hash' do
      it {expect(subject.info).to have_key 'name'}
      it {expect(subject.info).to have_key 'id'}
      it {expect(subject.info).to have_key 'email'}
      it {expect(subject.info).to have_key 'role'}
      it {expect(subject.info).to have_key 'organization_id'}
    end
  end

  describe '#callback_url' do
    let(:base_url) { 'https://example.com' }

    context 'no script name present' do
      it 'has the correct default callback path' do
        allow(subject).to receive(:full_host) { base_url }
        allow(subject).to receive(:script_name) { '' }
        allow(subject).to receive(:query_string) { '' }
        expect(subject.callback_url).to eq(base_url + '/auth/zendesk/callback')
      end
    end

    context 'script name' do
      it 'should set the callback path with script_name' do
        allow(subject).to receive(:full_host) { base_url }
        allow(subject).to receive(:script_name) { '/v1' }
        allow(subject).to receive(:query_string) { '' }
        expect(subject.callback_url).to eq(base_url + '/v1/auth/zendesk/callback')
      end
    end
  end
end
