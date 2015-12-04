defmodule Books.Isbndb do
  @access_key System.get_env("ISBNDB_ACCESS_KEY")

  def fetch(isbn) do
    response = HTTPotion.get(link(isbn))
  end

  defp link(isbn) do
    "http://isbndb.com/api/books.xml?access_key=#{@access_key}&results=details&index1=isbn&value1=#{isbn}"
  end
end
