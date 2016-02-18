<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="messages">
    <xsl:if test="count(/data/message) &gt; 0">
      <xsl:key name="message-type" match="message" use="type" />
      <!--
        Info messages
      -->
      <xsl:choose>
        <xsl:when test="count(key('message-type', 'info')) &gt; 1">
          <ul class="alert alert-info">
            <xsl:for-each select="key('message-type', 'info')">
              <li><xsl:value-of select="label" /></li>
            </xsl:for-each>
          </ul>
        </xsl:when>
        <xsl:when test="count(key('message-type', 'info')) = 1">
          <div class="alert alert-info">
            <xsl:for-each select="key('message-type', 'info')">
              <xsl:value-of select="label" />
            </xsl:for-each>
          </div>
        </xsl:when>
      </xsl:choose>
      <!--
        Error messages
      -->
      <xsl:choose>
        <xsl:when test="count(key('message-type', 'error')) &gt; 1">
          <ul class="alert alert-danger">
            <xsl:for-each select="key('message-type', 'error')">
              <li><xsl:value-of select="label" /></li>
            </xsl:for-each>
          </ul>
        </xsl:when>
        <xsl:when test="count(key('message-type', 'error')) = 1">
          <div class="alert alert-danger">
            <xsl:for-each select="key('message-type', 'error')">
              <xsl:value-of select="label" />
            </xsl:for-each>
          </div>
        </xsl:when>
      </xsl:choose>

      <!--
        Success messages
      -->
      <xsl:choose>
        <xsl:when test="count(key('message-type', 'success')) &gt; 1">
          <ul class="alert alert-success">
            <xsl:for-each select="key('message-type', 'success')">
              <li><xsl:value-of select="label" /></li>
            </xsl:for-each>
          </ul>
        </xsl:when>
        <xsl:when test="count(key('message-type', 'success')) = 1">
          <div class="alert alert-success">
            <xsl:for-each select="key('message-type', 'success')">
              <xsl:value-of select="label" />
            </xsl:for-each>
          </div>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <xsl:template name="messages2">
    <xsl:if test="count(/data/message[type='error']) &gt; 0">
      <ul class="alert alert-danger list-styled">
        <xsl:for-each select="/data/message[type='error']">
          <!--
          <xsl:variable name="type">
            <xsl:choose>
              <xsl:when test="type='error'">danger</xsl:when>
              <xsl:when test="type='success'">success</xsl:when>
            </xsl:choose>
          </xsl:variable>
          -->
          <li><xsl:value-of select="label" /></li>
        </xsl:for-each>
      </ul>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
