RSpec.describe Nextcloud::Ruby::Tag do
  describe '#find' do
    context 'success' do
      it 'correctly finds tag' do
        id = 2

        VCR.use_cassette 'tag_find_success' do
          api_response = Nextcloud::Ruby::Tag.find(id)

          expect(api_response).to be_a(Nextcloud::Ruby::Models::Tag)
          expect(api_response.id).to eql 2
          expect(api_response.name).to eql 'test'
        end
      end
    end
    context 'failure' do
      it 'fails to find tag' do
        id = 0

        VCR.use_cassette 'tag_find_failure' do
          api_response = Nextcloud::Ruby::Tag.find(id)

          expect(api_response).to be_nil
        end
      end
    end
  end
  describe '#all' do
    context 'success' do
      it 'correctly returns tags' do
        VCR.use_cassette 'tag_all_success' do
          api_response = Nextcloud::Ruby::Tag.all

          expect(api_response).to be_a(Array)
          expect(api_response).to all(be_an(Nextcloud::Ruby::Models::Tag))
        end
      end
    end
  end
end
