RSpec.describe Nextcloud::Ruby::Response do
  describe '#new' do
    context 'success' do
      it 'correctly returns xml document' do
        api_response = Nextcloud::Ruby::Response.new('', 201)

        expect(api_response.body).to be_a(Nokogiri::XML::Document)
        expect(api_response.body.content).to eql ''
      end
    end
  end
  describe '#ok' do
    context 'success' do
      it 'has a succesful status code' do
        api_response = Nextcloud::Ruby::Response.new('', 201)

        expect(api_response.ok?).to be true
      end
    end
    context 'failure' do
      it 'has a error status code' do
        api_response = Nextcloud::Ruby::Response.new('', 403)

        expect(api_response.ok?).to be false
      end
    end
  end
end
