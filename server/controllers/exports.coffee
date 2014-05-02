EXPORT_HEADER = """
<!DOCTYPE NETSCAPE-Bookmark-file-1>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">
      <TITLE>Bookmarks</TITLE>
      <H1>Bookmarks Menu</H1>
      <DL><DT><H3>Cozy Bookmark</H3>
        <DL>
"""

EXPORT_FOOTER = """
        </DL>
      </DL>
"""

MakeLink = (name, link, date, tags) ->
    date = +date
    ret = "<DT><A HREF='#{link}' ADD_DATE='#{date}' LAST_MODIFIED='#{date}'"
    if tags?
        ret += " TAGS='#{tags}'"
    ret += ">#{name}</A></DT>\n"
    ret

module.exports = (Bookmark, SendError) ->
    (req, res) ->
        Bookmark.all (err, bookmarks) ->
            if err
                console.error err
                SendError res, 'while retrieving data for export'
                return

            exported = EXPORT_HEADER
            for b in bookmarks
                name = b.title
                link = b.url
                creation_date = new Date b.created
                tags = b.tags
                exported += MakeLink name, link, creation_date, tags

            exported += EXPORT_FOOTER
            res.setHeader 'Content-disposition', 'attachment; filename=bookmarks.html'
            res.send exported
            return
        return

