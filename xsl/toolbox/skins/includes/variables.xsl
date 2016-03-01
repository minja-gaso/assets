<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="quote"><xsl:text>'</xsl:text></xsl:variable>
  <xsl:variable name="baseUrl" select="concat(/data/environment/serverName, '/calendar/list/')" />
  <xsl:variable name="listBaseUrl" select="concat(/data/environment/serverName, '/calendar/list/')" />
  <xsl:variable name="detailBaseUrl" select="concat(/data/environment/serverName, '/calendar/detail/', /data/calendar/prettyUrl)" />
  <xsl:variable name="url" select="concat($baseUrl, /data/calendar/id)" />
  <xsl:variable name="prettyUrl" select="concat($baseUrl, /data/calendar/prettyUrl)" />
  <xsl:variable name="viewUrl">
    <xsl:value-of select="concat(/data/environment/serverName, '/toolbox/skinPreview/', /data/skin/id)" />
  </xsl:variable>
</xsl:stylesheet>
