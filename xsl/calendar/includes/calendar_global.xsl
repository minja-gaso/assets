<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:variable name="screenName" select="/data/environment/screenName" />
  <xsl:template name="sidebar">
    <h3>Categories</h3>
    <ul class="list-group">
      <xsl:for-each select="/data/calendar/category">
        <li class="list-group-item">
          <a href="/calendar/search/{/data/calendar/prettyUrl}?searchType=category&amp;categoryId={id}">
            <xsl:value-of select="label" />
          </a>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
  <xsl:template name="external_files">
    <!-- Bootstrap -->
    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" />
  </xsl:template>
  <xsl:template name="top_nav">
    <ul class="list-inline">
      <li>
        <a class="btn btn-social-icon btn-rss" href="/calendar/rss/{/data/calendar/prettyUrl}">
          <span class="fa fa-rss"></span>
        </a>
      </li>
      <li>
        <a class="btn btn-social-icon btn-flickr">
          <span class="fa fa-envelope"></span>
        </a>
      </li>
      <li class="pull-right">
        <div id="search">
          <div class="col-xs-12 input-group">
            <xsl:variable name="attributeName">
              <xsl:choose>
                <xsl:when test="string-length(/data/calendar/search/query) &gt; 0">value</xsl:when>
                <xsl:otherwise>placeholder</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="attributeValue">
              <xsl:choose>
                <xsl:when test="string-length(/data/calendar/search/query) &gt; 0">
                  <xsl:value-of select="/data/calendar/search/query" />
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="'Search'" />
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <input type="text" class="form-control" name="searchKeyword" id="searchKeyword" size="25">
              <xsl:attribute name="{$attributeName}"><xsl:value-of select="$attributeValue" /></xsl:attribute>
            </input>
            <a class="input-group-addon" onclick="javascript:document.portal_form.searchType.value='keyword';document.portal_form.action='/calendar/search/{/data/calendar/prettyUrl}';document.portal_form.submit();">
              <span class="fa fa-search" />&#160;Search
            </a>
          </div>
          <script type="text/javascript">
            var keyword = document.getElementById('searchKeyword');
            keyword.addEventListener('keyup', function(e){
              var code = (e.keyCode ? e.keyCode : e.which);
              if(code == 13) {
                this.nextSibling.click();
              }
            });
          </script>
        </div>
      </li>
    </ul>
  </xsl:template>
</xsl:stylesheet>
