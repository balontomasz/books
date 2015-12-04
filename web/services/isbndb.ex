defmodule Books.Isbndb do
  @access_key System.get_env("ISBNDB_ACCESS_KEY")

  def fetch(isbn) do
    xml = response(isbn).body

    %{
      :author => author(xml),
      :cover_url => cover_url(isbn),
      :isbn => isbn,
      :title => title(xml)
    }
  end

  defp response(isbn) do
    HTTPotion.get(link(isbn))
  end

  defp link(isbn) do
    "http://isbndb.com/api/books.xml?access_key=#{@access_key}&results=details&index1=isbn&value1=#{isbn}"
  end

  def title(xml) do
    titlelong = Floki.FlatText.get(Floki.find(xml, "titlelong"))
    title = Floki.FlatText.get(Floki.find(xml, "title"))

    if String.length(titlelong) > 0, do: titlelong, else: title
  end

  def author(xml) do
    Floki.FlatText.get(Floki.find(xml, "authorstext"))
  end

  defp cover_url(isbn) do
    "http://covers.openlibrary.org/b/isbn/#{isbn}-L.jpg"
  end
end
