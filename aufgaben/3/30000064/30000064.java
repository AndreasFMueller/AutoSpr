private Pattern  htmltag, link;
public LinkGetter() {
    htmltag = Pattern.compile("<a\\b[^>]*href=\"[^>]*>(.*?)</a>");
    link = Pattern.compile("href=\"[^>]*\">");
}
