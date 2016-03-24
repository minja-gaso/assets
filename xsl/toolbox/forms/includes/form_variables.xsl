<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="quote"><xsl:text>'</xsl:text></xsl:variable>
  <xsl:variable name="is_self_assessment">
    <xsl:choose>
      <xsl:when test="/data/environment/componentId = 2"><xsl:value-of select="'true'" /></xsl:when>
      <xsl:otherwise><xsl:value-of select="'false'" /></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="webformBaseUrl">
    <xsl:choose>
      <xsl:when test="$is_self_assessment = 'true'">
        <xsl:value-of select="concat(/data/environment/serverName, '/webform/self-assessment/')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(/data/environment/serverName, '/webform/public/')" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="webformById" select="concat($webformBaseUrl, /data/form/id)" />
  <xsl:variable name="webformPrettyUrl" select="concat($webformBaseUrl, /data/form/prettyUrl)" />
  <xsl:variable name="webformUrlToUse">
    <xsl:value-of select="$webformBaseUrl" />
    <xsl:choose>
      <xsl:when test="string-length(/data/form/prettyUrl) &gt; 0"><xsl:value-of select="/data/form/prettyUrl" /></xsl:when>
      <xsl:otherwise><xsl:value-of select="/data/form/id" /></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="QUESTION_LIST_ACTION">
      <xsl:choose>
        <xsl:when test="$is_self_assessment = 'false'">QUESTION_LIST</xsl:when>
        <xsl:otherwise>QUESTIONS_AND_ANSWERS</xsl:otherwise>
      </xsl:choose>
  </xsl:variable>
	<xsl:variable name="formLabel">
		<xsl:choose>
			<xsl:when test="/data/environment/componentId = 1">Standard Forms &amp; Surveys</xsl:when>
			<xsl:otherwise>Self-Assessment Surveys</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
  <xsl:variable name="baseUrl">
    <xsl:choose>
      <xsl:when test="$is_self_assessment = 'true'">
        <xsl:value-of select="concat(/data/environment/serverName, '/webform/self-assessment/')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(/data/environment/serverName, '/webform/public/')" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
	<xsl:variable name="viewUrl">
    <xsl:value-of select="concat($baseUrl, /data/form/prettyUrl)" />
  </xsl:variable>
</xsl:stylesheet>
