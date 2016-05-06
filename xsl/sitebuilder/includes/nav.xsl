<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="primary_navigation">
    <xsl:param name="SCREEN" />
    <ul class="nav nav-tabs">
      <!--
        General - fill out basic form/survey information
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = 'GENERAL'">
          <li role="presentation" class="active"><a href="#">General</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('GENERAL');">General</a></li>
        </xsl:otherwise>
      </xsl:choose>
      <!--
        Html - modify skin html
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = 'TEMPLATES'">
          <li role="presentation" class="active"><a href="#">Templates</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('TEMPLATES');">Templates</a></li>
        </xsl:otherwise>
      </xsl:choose>

      <!--
        Roles - set privileges
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = 'PAGES'">
          <li role="presentation" class="active"><a href="#">Pages</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation" class=""><a href="javascript:switchTab('PAGES');">Pages</a></li>
        </xsl:otherwise>
      </xsl:choose>
      <!--
        Html - modify skin html
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = 'FOOTER'">
          <li role="presentation" class="active"><a href="#">Footer</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('FOOTER');">Footer</a></li>
        </xsl:otherwise>
      </xsl:choose>
      <!--
        CSS - Override styles
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = 'CSS'">
          <li role="presentation" class="active"><a href="#">CSS</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('CSS');">CSS</a></li>
        </xsl:otherwise>
      </xsl:choose>
    </ul>
  </xsl:template>
  <xsl:template name="app_css_navigation">
    <xsl:param name="SCREEN" />
    <ul class="nav nav-tabs">
      <!--
        App CSS - editing an application's CSS for skin
      -->
      <xsl:variable name="appLabel">
        <xsl:choose>
          <xsl:when test="/data/skin/selectedApp = 'CALENDAR'">Calendar</xsl:when>
          <xsl:when test="/data/skin/selectedApp = 'FORMS'">Form</xsl:when>
          <xsl:otherwise>App</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$SCREEN = 'APP_CSS'">
          <li role="presentation" class="active"><a href="#"><xsl:value-of select="$appLabel" /> CSS</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('SKIN_APP_CSS');"><xsl:value-of select="$appLabel" /> CSS</a></li>
        </xsl:otherwise>
      </xsl:choose>
    </ul>
  </xsl:template>
  <xsl:template name="list_nav">
    <ul class="nav nav-tabs">
      <li role="presentation" class="active"><a href="#">Site List</a></li>
    </ul>
  </xsl:template>
  <xsl:template name="template_edit">
    <ul class="nav nav-tabs">
      <li role="presentation" class="active"><a href="#">Edit Template</a></li>
    </ul>
  </xsl:template>
  <xsl:template name="page_edit">
    <xsl:param name="SCREEN" />
    <ul class="nav nav-tabs">
      <xsl:choose>
        <xsl:when test="$SCREEN = 'PAGE'">
          <li role="presentation" class="active"><a href="#">Edit Page</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('PAGE');">Edit Page</a></li>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="$SCREEN = 'PAGE_ARCHIVE'">
          <li role="presentation" class="active"><a href="#">Page Archive</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('PAGE_ARCHIVE');">Page Archive</a></li>
        </xsl:otherwise>
      </xsl:choose>

    </ul>
  </xsl:template>
</xsl:stylesheet>
