<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="quote"><xsl:text>'</xsl:text></xsl:variable>
  <xsl:variable name="baseUrl" select="concat(/data/environment/serverName, '/blog/list/')" />
  <xsl:variable name="listBaseUrl" select="concat(/data/environment/serverName, '/blog/list/')" />
  <xsl:variable name="detailBaseUrl" select="concat(/data/environment/serverName, '/blog/detail/', /data/blog/prettyUrl)" />
  <xsl:variable name="url" select="concat($baseUrl, /data/blog/id)" />
  <xsl:variable name="prettyUrl" select="concat($baseUrl, /data/blog/prettyUrl)" />
  <xsl:variable name="viewUrl">
    <xsl:choose>
      <xsl:when test="string-length(/data/blog/prettyUrl) &gt; 0"><xsl:value-of select="$prettyUrl" /></xsl:when>
      <xsl:otherwise><xsl:value-of select="$url" /></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
	<xsl:variable name="listUrl" select="concat($listBaseUrl, /data/blog/prettyUrl)" />
	<xsl:variable name="detailId">
    <xsl:value-of select="/data/blog/topic/id" />
	</xsl:variable>
  <xsl:variable name="detailViewUrl">
		<xsl:value-of select="concat($detailBaseUrl, '?topicID=', $detailId)" />
  </xsl:variable>
	<xsl:variable name="publishYear" select="substring(/data/blog/topic/publishDate,1,4)" />
	<xsl:variable name="publishMonth" select="substring(/data/blog/topic/publishDate,6,2)" />
	<xsl:variable name="publishDay" select="substring(/data/blog/topic/publishDate,9,2)" />
	<xsl:variable name="publishDate">
		<xsl:value-of select="concat($publishMonth, '/', $publishDay, '/', $publishYear)" />
	</xsl:variable>
	<xsl:variable name="endYear" select="substring(/data/blog/topic/endDate,1,4)" />
	<xsl:variable name="endMonth" select="substring(/data/blog/topic/endDate,6,2)" />
	<xsl:variable name="endDay" select="substring(/data/blog/topic/endDate,9,2)" />
	<xsl:variable name="endDate">
		<xsl:value-of select="concat($endMonth, '/', $endDay, '/', $endYear)" />
	</xsl:variable>
	<xsl:variable name="publishTime" select="substring(/data/blog/topic/publishTime, 1, 8)" />
	<xsl:variable name="endTime" select="substring(/data/blog/topic/endTime, 1, 8)" />
</xsl:stylesheet>
