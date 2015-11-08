require 'rails_helper'

describe '/feeds/show', :type => :request do
  subject { get request_url }

  include_context :vcr_chain
  let(:vcr_chain_cassettes) { :upload_url_mp3 }

  let(:user) { create(:user) }

  let(:upload) { create(:upload, user: user) }
  let!(:uploaded_file) { create(:uploaded_file, upload: upload) }

  let(:request_url) { "/feeds/#{upload.id}.xml" }

  context 'when unauthenticated' do
    before { subject }

    it { expect(response.code.to_i).to eq(401) }

    context 'when using token' do
      subject { get "#{request_url}?token=#{upload.token}" }

      it { expect(response.code.to_i).to eq(200) }
    end
  end

  context 'when authenticated' do
    before do
      login_as(user, :scope => :user)
      uploaded_file.send(:postprocess)
      subject
    end

    it { expect(response.code.to_i).to eq(200) }

    let(:guid) do
      'f19f86d2658f39c64187492903c0100a846fa63a72131574f20f49257959c9da'
    end

    it 'returns proper xml with feed' do
      expect(response.body).to eq(
        "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<rss xmlns:itunes=\"http://www.itunes.com/dtds/podcast-1.0.dtd\" version=\"2.0\">
  <channel>
    <title>#{upload.name}</title>
    <link>http://www.example.com/</link>
    <description>#{upload.description}</description>
    <itunes:summary>#{upload.description}</itunes:summary>
    <itunes:author></itunes:author>
    <itunes:image href=\"http://example.com/picture.jpg\" />
    <image>
      <url>http://example.com/picture.jpg</url>
    </image>
    <generator>Locucast</generator>
    <item>
      <title>The Fox and The Grapes</title>
      <itunes:author>Aesop</itunes:author>
      <itunes:image href=\"\"/>
      <enclosure url=\"#{uploaded_file.url}\" length=\"373155\" type=\"audio/mpeg\"/>
      <guid isPermaLink=\"false\">#{guid}</guid>
      <pubDate>#{Date.new(2015, 11, 8).beginning_of_day.rfc2822}</pubDate>
      <itunes:duration>46</itunes:duration>
    </item>
  </channel>
</rss>\n"
      )
    end
  end
end
