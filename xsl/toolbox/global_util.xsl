<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="messages">
    <xsl:if test="count(/data/message) &gt; 0">
      <xsl:for-each select="/data/message">
        <xsl:variable name="type">
          <xsl:choose>
            <xsl:when test="type='error'">danger</xsl:when>
            <xsl:when test="type='success'">success</xsl:when>
          </xsl:choose>
        </xsl:variable>
        <div class="alert alert-{$type}"><xsl:value-of select="label" /></div>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
