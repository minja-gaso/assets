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
          Roles - set privileges
        -->
        <xsl:choose>
          <xsl:when test="$SCREEN = 'ROLES'">
            <li role="presentation" class="active pull-right"><a href="#">Roles</a></li>
          </xsl:when>
          <xsl:otherwise>
            <li role="presentation" class="pull-right"><a href="javascript:switchTab('ROLES');">Roles</a></li>
          </xsl:otherwise>
        </xsl:choose>
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
          <li role="presentation"><a href="javascript:switchTab('EVENTS');">Events</a></li>
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
          <li role="presentation"><a href="javascript:switchTab('EVENT');">Event</a></li>
        </xsl:otherwise>
      </xsl:choose>
        <!--
          Recurring - enable or disable recurrence of event
        -->
        <xsl:choose>
          <xsl:when test="$SCREEN = 'EVENT_RECURRENCE'">
            <li role="presentation" class="active"><a href="#">Recurrence</a></li>
          </xsl:when>
          <xsl:otherwise>
            <li role="presentation"><a href="javascript:switchTab('EVENT_RECURRENCE');">Recurrence</a></li>
          </xsl:otherwise>
        </xsl:choose>
    </ul>
  </xsl:template>
</xsl:stylesheet>
