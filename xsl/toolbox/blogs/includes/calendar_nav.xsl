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
        Skin - Select a skin
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = 'SKIN'">
          <li role="presentation" class="active"><a href="#">Appearance</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('SKIN');submitForm();">Appearance</a></li>
        </xsl:otherwise>
      </xsl:choose>
      <!--
        CSS - Override styles
      <xsl:choose>
        <xsl:when test="$SCREEN = 'CSS'">
          <li role="presentation" class="active"><a href="#">Override Styles</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('CSS');submitForm();">Override Styles</a></li>
        </xsl:otherwise>
      </xsl:choose>
    -->
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
  <xsl:template name="primary_content_navigation">
    <xsl:param name="SCREEN" />
    <ul class="nav nav-tabs">
      <!--
        Events - list of all events for calendar
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = 'EVENTS'">
          <li role="presentation" class="active"><a href="#">Events</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('EVENTS');submitForm();">Events</a></li>
        </xsl:otherwise>
      </xsl:choose>
        <!--
          Categories - list of all categories
        -->
        <xsl:choose>
          <xsl:when test="$SCREEN = 'CATEGORIES'">
            <li role="presentation" class="active"><a href="#">Categories</a></li>
          </xsl:when>
          <xsl:otherwise>
            <li role="presentation"><a href="javascript:switchTab('CATEGORIES');submitForm();">Categories</a></li>
          </xsl:otherwise>
        </xsl:choose>
    </ul>
  </xsl:template>
  <xsl:template name="event_content_navigation">
    <xsl:param name="SCREEN" />
    <ul class="nav nav-tabs">
      <!--
        Event - the general event information view
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = 'EVENT'">
          <li role="presentation" class="active"><a href="#">Event</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:saveEvent();switchTab('EVENT');submitForm();">Event</a></li>
        </xsl:otherwise>
      </xsl:choose>
      <!--
        Image Upload - upload main event image
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = 'EVENT_IMAGE_UPLOAD'">
          <li role="presentation" class="active"><a href="#">Upload Image</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:saveEvent();switchTab('EVENT_IMAGE_UPLOAD');submitForm();">Upload Image</a></li>
        </xsl:otherwise>
      </xsl:choose>
      <!--
        Recurring - enable or disable recurrence of event
      -->
      <xsl:if test="/data/calendar/event/parentId = 0">
        <xsl:choose>
          <xsl:when test="$SCREEN = 'EVENT_RECURRENCE'">
            <li role="presentation" class="active"><a href="#">Recurrence</a></li>
          </xsl:when>
          <xsl:otherwise>
            <li role="presentation"><a href="javascript:saveEvent();switchTab('EVENT_RECURRENCE');submitForm();">Recurrence</a></li>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </ul>
  </xsl:template>
  <xsl:template name="list_nav">
    <ul class="nav nav-tabs">
      <li role="presentation" class="active"><a href="#">My Calendars</a></li>
      <li role="presentation" class="name pull-right"><a href="#" class="disabled"><xsl:value-of select="concat(/data/user/firstName, ' ', /data/user/lastName)" /></a></li>
    </ul>
  </xsl:template>
</xsl:stylesheet>
