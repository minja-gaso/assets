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
          <li role="presentation"><a href="javascript:switchTab('GENERAL');submitForm();">General</a></li>
        </xsl:otherwise>
      </xsl:choose>
        <!--
          Html - modify skin html
        -->
        <xsl:choose>
          <xsl:when test="$SCREEN = 'HTML'">
            <li role="presentation" class="active"><a href="#">Edit HTML</a></li>
          </xsl:when>
          <xsl:otherwise>
            <li role="presentation"><a href="javascript:switchTab('HTML');submitForm();">Edit HTML</a></li>
          </xsl:otherwise>
        </xsl:choose>
      <!--
        CSS - Override styles
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = 'CSS'">
          <li role="presentation" class="active"><a href="#">Override Styles</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('CSS');submitForm();">Override Styles</a></li>
        </xsl:otherwise>
      </xsl:choose>
      <!--
        Roles - set privileges
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = 'ROLES'">
          <li role="presentation" class="active"><a href="#">Roles</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation" class=""><a href="javascript:switchTab('ROLES');submitForm();">Roles</a></li>
        </xsl:otherwise>
      </xsl:choose>
      <!--
        FAQ & Help
      -->
      <li role="presentation" class="help pull-right"><a href="javascript:void(0);"><span class="fa fa-question-circle fa-lg">&#160;</span>&#160;Help</a></li>
      <li role="presentation" class="faq pull-right"><a href="/faq/calendar.html" target="_blank"><span class="fa fa-exclamation-circle fa-lg">&#160;</span>&#160;FAQ</a></li>
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
          <li role="presentation"><a href="javascript:switchTab('SKIN_APP_CSS');submitForm();"><xsl:value-of select="$appLabel" /> CSS</a></li>
        </xsl:otherwise>
      </xsl:choose>
    </ul>
  </xsl:template>
  <xsl:template name="list_nav">
    <ul class="nav nav-tabs">
      <li role="presentation" class="active"><a href="#">My Skins</a></li>
      <li role="presentation" class="name pull-right"><a href="#" class="disabled"><xsl:value-of select="concat(/data/user/firstName, ' ', /data/user/lastName)" /></a></li>
    </ul>
  </xsl:template>
</xsl:stylesheet>
