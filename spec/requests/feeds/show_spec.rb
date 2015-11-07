require 'rails_helper'

describe '/feeds/show', :type => :request do
  subject { get request_url }

  let(:upload) { create(:upload) }
  let!(:uploaded_file) { create(:uploaded_file, upload: upload) }

  let(:request_url) { "/feeds/#{upload.id}.xml" }

  context 'when unauthenticated' do
    before { subject }

    it { expect(response.code.to_i).to eq(401) }
  end

  context 'when authenticated' do
    before do
      login_as(user, :scope => :user)
      uploaded_file.send(:postprocess)
      subject
    end

    let(:user) { create(:user) }

    it { expect(response.code.to_i).to eq(200) }

    let(:enclosure_url) do
      "#{Rails.root}/spec/fixtures/1984-01_64kb.mp3"
    end
    let(:guid) do
      '0b6b8524741a72d04861b022027834eec220086f336b86c2389c8946a03b6755'
    end

    it 'returns proper xml with feed' do
      expect(response.body).to eq(
        "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<rss xmlns:itunes=\"http://www.itunes.com/dtds/podcast-1.0.dtd\" version=\"2.0\">
  <channel>
    <title>#{upload.name}</title>
    <link>http://www.example.com/feeds/#{upload.id}.xml</link>
    <description>#{upload.description}</description>
    <itunes:summary>#{upload.description}</itunes:summary>
    <itunes:author></itunes:author>
    <generator>Locucast</generator>
    <item>
      <title>1984-01</title>
      <itunes:author>George Orwell R-(Frank Muller)</itunes:author>
      <itunes:image href=\"\"/>
      <enclosure url=\"#{enclosure_url}\" length=\"21147816\" type=\"audio/mpeg\"/>
      <guid isPermaLink=\"false\">#{guid}</guid>
      <pubDate>#{Date.today} 00:01:00 UTC</pubDate>
      <itunes:duration>2643</itunes:duration>
    </item>
  </channel>
</rss>\n"
      )
    end
  end
end
