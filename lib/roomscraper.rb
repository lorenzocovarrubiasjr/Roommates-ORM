class RoomScraper

  def initialize(index_url)
    @doc = Nokogiri::HTML(open(index_url))
    binding.pry
  end

  def call
    rows.each do |row_doc|
      scrape_row[row_doc]
    end
  end

private
  def rows
    @rows ||= @doc.search("li.result-row")
  end

  def scrape_row(row)
    {
    :date_created => row.search('#sortable-results > ul > li:nth-child(1) > p > time'),
    :title => row.search('#sortable-results > ul > li:nth-child(2) > p > a').text,
    :url => row.search('#sortable-results > ul > li:nth-child(2) > p > a').attribute("href"),
    :price => row.search('#sortable-results > ul > li:nth-child(1) > p > span.result-meta > span.result-price').text
    }
  end

end
