<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="quote"><xsl:text>'</xsl:text></xsl:variable>
  <xsl:variable name="baseUrl" select="concat(/data/environment/serverName, '/calendar/public/')" />
  <xsl:variable name="listBaseUrl" select="concat(/data/environment/serverName, '/calendar/list/')" />
  <xsl:variable name="detailBaseUrl" select="concat(/data/environment/serverName, '/calendar/detail/')" />
  <xsl:variable name="url" select="concat($baseUrl, /data/calendar/id)" />
  <xsl:variable name="prettyUrl" select="concat($baseUrl, /data/calendar/prettyUrl)" />
  <xsl:variable name="viewUrl">
    <xsl:choose>
      <xsl:when test="string-length(/data/calendar/prettyUrl) &gt; 0"><xsl:value-of select="$prettyUrl" /></xsl:when>
      <xsl:otherwise><xsl:value-of select="$url" /></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
	<xsl:variable name="listUrl" select="concat($listBaseUrl, /data/calendar/prettyUrl)" />
	<xsl:variable name="startYear" select="substring(/data/calendar/event/startDate,1,4)" />
	<xsl:variable name="startMonth" select="substring(/data/calendar/event/startDate,6,2)" />
	<xsl:variable name="startDay" select="substring(/data/calendar/event/startDate,9,2)" />
	<xsl:variable name="startDate">
		<xsl:value-of select="concat($startMonth, '/', $startDay, '/', $startYear)" />
	</xsl:variable>
		<xsl:variable name="endYear" select="substring(/data/calendar/event/endDate,1,4)" />
		<xsl:variable name="endMonth" select="substring(/data/calendar/event/endDate,6,2)" />
		<xsl:variable name="endDay" select="substring(/data/calendar/event/endDate,9,2)" />
	<xsl:variable name="endDate">
		<xsl:value-of select="concat($endMonth, '/', $endDay, '/', $endYear)" />
	</xsl:variable>
	<xsl:variable name="startTime" select="substring(/data/calendar/event/startTime, 1, 8)" />
	<xsl:variable name="endTime" select="substring(/data/calendar/event/endTime, 1, 8)" />
</xsl:stylesheet>
