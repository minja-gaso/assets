<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
</xsl:stylesheet>
