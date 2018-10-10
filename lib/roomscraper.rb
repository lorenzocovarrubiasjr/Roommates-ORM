class RoomScraper
  attr_accessor :doc

  def initialize(index_url)
    @doc = Nokogiri::HTML(open(index_url))
  end

  def call
    rows.each do |row_doc|
      room = Room.create_from_hash(scrape_row(row_doc))
      room
    end
  end

#private
  def rows
    rows = @doc.search("li.result-row")
  end

  def scrape_row(row)
    {
    :date_created => row.search('time.result-date').text,
    :title => row.search('a.result-title.hdrlnk').text,
    :url => row.search('a.result-title.hdrlnk').attr("href").text,
    :price => row.search('span.result-meta span.result-price').text
    }
  end

end
