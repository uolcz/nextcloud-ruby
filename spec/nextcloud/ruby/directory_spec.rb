RSpec.describe Nextcloud::Ruby::Directory do
  describe '#create' do
    context 'success' do
      it 'correctly creates directory' do
        path = 'testdirectory'

        VCR.use_cassette 'directory_success' do
          api_response = Nextcloud::Ruby::Directory.create(path)

          expect(api_response.status_code).to eql 201
          expect(api_response.body.content).to eql ''
        end
      end
    end
    context 'failure' do
      it 'fails to create directory' do
        path = ''

        VCR.use_cassette 'directory_failure' do
          api_response = Nextcloud::Ruby::Directory.create(path)

          expect(api_response).to be_a(Nextcloud::Ruby::Response)
          expect(api_response.status_code).to eql 405
          expect(api_response.body.content).not_to eql ''
        end
      end
    end
  end
  describe '#delete' do
    context 'success' do
      it 'correctly deletes directory' do
        path = 'testdirectory'

        VCR.use_cassette 'directory_delete_success' do
          api_response = Nextcloud::Ruby::Directory.delete(path)

          expect(api_response.status_code).to eql 204
          expect(api_response.body.content).to eql ''
        end
      end
    end
    context 'failure' do
      it 'fails to delete directory' do
        path = ''

        VCR.use_cassette 'directory_delete_failure' do
          api_response = Nextcloud::Ruby::Directory.delete(path)

          expect(api_response).to be_a(Nextcloud::Ruby::Response)
          expect(api_response.status_code).to eql 403
          expect(api_response.body.content).not_to eql ''
        end
      end
      it 'fails to delete directory' do
        path = 'testthatdoesnotexist'

        VCR.use_cassette 'directory_delete_failure_non_existent' do
          api_response = Nextcloud::Ruby::Directory.delete(path)

          expect(api_response).to be_a(Nextcloud::Ruby::Response)
          expect(api_response.status_code).to eql 404
          expect(api_response.body.content).not_to eql ''
        end
      end
    end
  end
  describe '#find' do
    context 'success' do
      it 'correctly finds directory' do
        path = 'findtestdirectory'

        VCR.use_cassette 'directory_find_success' do
          api_response = Nextcloud::Ruby::Directory.find(path)

          expect(api_response).to be_a(Nextcloud::Ruby::Models::Directory)
          expect(api_response.id).to eql 421
        end
      end
    end
    context 'failure' do
      it 'fails to find directory' do
        path = 'notexistingdirectory'

        VCR.use_cassette 'directory_find_failure' do
          api_response = Nextcloud::Ruby::Directory.find(path)

          expect(api_response).to be_nil
        end
      end
    end
  end
  describe '#set_tag' do
    context 'success' do
      it 'correctly set directory tag' do
        path = 'findtestdirectory'
        id = 2

        VCR.use_cassette 'directory_set_tag_success' do
          directory = Nextcloud::Ruby::Directory.find(path)
          tag = Nextcloud::Ruby::Tag.find(id)
          api_response = Nextcloud::Ruby::Directory.set_tag(directory, tag)

          expect(api_response).to be_a(Nextcloud::Ruby::Response)
          expect(api_response.status_code).to eql 201
          expect(api_response.body.content).to eql ''
        end
      end
    end
    context 'failure' do
      it 'fails to set directory tag' do
        path = 'notexistingdirectory'
        id = 0

        VCR.use_cassette 'directory_set_tag_failure' do
          directory = Nextcloud::Ruby::Directory.find(path)
          tag = Nextcloud::Ruby::Tag.find(id)
          api_response = Nextcloud::Ruby::Directory.set_tag(directory, tag)

          expect(api_response).to be_a(Nextcloud::Ruby::Response)
          expect(api_response.status_code).to eql 400
          expect(api_response.body.content).to eql ''
        end
      end
    end
  end
end
