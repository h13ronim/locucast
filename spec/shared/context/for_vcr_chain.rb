shared_context :vcr_chain do
  around do |example|
    if [vcr_chain_cassettes].flatten.compact.first
      using_cassettes vcr_chain_cassettes do
        example.run
      end
    else
      example.run
    end
  end

  def using_cassettes(*cas, &block)
    cas = cas.flatten
    first_cassette = cas.shift

    if cas.length > 0
      VCR.use_cassette(first_cassette) do
        using_cassettes(*cas, &block)
      end
    else
      VCR.use_cassette(first_cassette) do
        block.call
      end
    end
  end
end
