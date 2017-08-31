RSpec.describe Nextcloud::Ruby::Configuration do
  before do
    Nextcloud::Ruby.configure do |config|
      config.dav_url = 'https://example.com'
      config.username = 'jon'
      config.password = 'Secret'
      config.directories = [
        'a/b/c',
        'd/e/f'
      ]
    end
  end

  context 'with configuration block' do
    it 'returns the correct dav_url' do
      expect(Nextcloud::Ruby.configuration.dav_url)
        .to eq(URI('https://example.com'))
    end

    it 'returns the correct username' do
      expect(Nextcloud::Ruby.configuration.username).to eq('jon')
    end

    it 'returns the correct password' do
      expect(Nextcloud::Ruby.configuration.password).to eq('Secret')
    end

    it 'returns the correct dorectories' do
      expect(Nextcloud::Ruby.configuration.directories)
        .to match_array(['a/b/c', 'd/e/f'])
    end
  end

  context 'without configuration block' do
    before do
      Nextcloud::Ruby.reset
    end

    it 'raises a configuration error for dav_url' do
      expect { Nextcloud::Ruby.configuration.dav_url }
        .to raise_error(Nextcloud::Ruby::Errors::ConfigNotSet)
    end

    it 'raises a configuration error for username' do
      expect { Nextcloud::Ruby.configuration.username }
        .to raise_error(Nextcloud::Ruby::Errors::ConfigNotSet)
    end

    it 'raises a configuration error for password' do
      expect { Nextcloud::Ruby.configuration.password }
        .to raise_error(Nextcloud::Ruby::Errors::ConfigNotSet)
    end

    it 'raises a configuration error for directories' do
      expect { Nextcloud::Ruby.configuration.directories }
        .to raise_error(Nextcloud::Ruby::Errors::ConfigNotSet)
    end
  end

  context '#reset' do
    it 'resets configured values' do
      expect(Nextcloud::Ruby.configuration.dav_url)
        .to eq(URI('https://example.com'))
      expect(Nextcloud::Ruby.configuration.username).to eq('jon')
      expect(Nextcloud::Ruby.configuration.password).to eq('Secret')
      expect(Nextcloud::Ruby.configuration.directories)
        .to match_array(['a/b/c', 'd/e/f'])

      Nextcloud::Ruby.reset
      expect { Nextcloud::Ruby.configuration.dav_url }
        .to raise_error(Nextcloud::Ruby::Errors::ConfigNotSet)
      expect { Nextcloud::Ruby.configuration.username }
        .to raise_error(Nextcloud::Ruby::Errors::ConfigNotSet)
      expect { Nextcloud::Ruby.configuration.password }
        .to raise_error(Nextcloud::Ruby::Errors::ConfigNotSet)
      expect { Nextcloud::Ruby.configuration.directories }
        .to raise_error(Nextcloud::Ruby::Errors::ConfigNotSet)
    end
  end
end
