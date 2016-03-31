<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="quote"><xsl:text>'</xsl:text></xsl:variable>
	<xsl:variable name="listUrl" select="concat(/data/environment/serverName, '/blog/list/', /data/blog/prettyUrl)" />
	<xsl:variable name="listUrlById" select="concat(/data/environment/serverName, '/blog/list/', /data/blog/id)" />
  <xsl:variable name="topicUrl">
		<xsl:value-of select="concat(/data/environment/serverName, '/blog/detail/', /data/blog/prettyUrl, '?TOPIC_ID=', /data/blog/topic/id)" />
  </xsl:variable>
	<xsl:variable name="publishYear" select="substring(/data/blog/topic/publishDate,1,4)" />
	<xsl:variable name="publishMonth" select="substring(/data/blog/topic/publishDate,6,2)" />
	<xsl:variable name="publishDay" select="substring(/data/blog/topic/publishDate,9,2)" />
	<xsl:variable name="publishDate">
		<xsl:value-of select="concat($publishMonth, '/', $publishDay, '/', $publishYear)" />
	</xsl:variable>
	<xsl:variable name="publishTime" select="substring(/data/blog/topic/publishTime, 1, 8)" />
</xsl:stylesheet>
