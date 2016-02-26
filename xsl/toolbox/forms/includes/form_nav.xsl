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
        Questions - for standard surveys, fill out questions in their own screen;  for self-assessment, everything is done on this screen.
      -->
      <xsl:choose>
        <xsl:when test="$SCREEN = $QUESTION_LIST_ACTION">
          <li role="presentation" class="active"><a href="#">Questions</a></li>
        </xsl:when>
        <xsl:otherwise>
          <li role="presentation"><a href="javascript:switchTab('{$QUESTION_LIST_ACTION}');submitForm();">Questions</a></li>
        </xsl:otherwise>
      </xsl:choose>


      <xsl:if test="$is_self_assessment = 'true'">
        <xsl:choose>
          <xsl:when test="$SCREEN = 'ANSWERS'">
            <li role="presentation" class="active"><a href="#">Answers</a></li>
          </xsl:when>
          <xsl:otherwise>
            <li role="presentation"><a href="javascript:switchTab('ANSWERS');submitForm();">Answers</a></li>
          </xsl:otherwise>
        </xsl:choose>
          <xsl:choose>
            <xsl:when test="$SCREEN = 'SCORES'">
              <li role="presentation" class="active"><a href="#">Scores</a></li>
            </xsl:when>
            <xsl:otherwise>
              <li role="presentation"><a href="javascript:switchTab('SCORES');submitForm();">Scores</a></li>
            </xsl:otherwise>
          </xsl:choose>
      </xsl:if>

      <xsl:if test="$is_self_assessment = 'false'">
        <!--
          Reports - generate CSV/PDF reports
        -->
        <xsl:choose>
          <xsl:when test="$SCREEN = 'REPORTS'">
            <li role="presentation" class="active"><a href="#">Reports</a></li>
          </xsl:when>
          <xsl:otherwise>
            <li role="presentation"><a href="javascript:switchTab('REPORTS');submitForm();">Reports</a></li>
          </xsl:otherwise>
        </xsl:choose>

        <!--
          Analytics - run real-time analytics based on filters
        -->
        <xsl:choose>
          <xsl:when test="$SCREEN = 'ANALYTICS'">
            <li role="presentation" class="active"><a href="#">Analytics</a></li>
          </xsl:when>
          <xsl:otherwise>
            <li role="presentation"><a href="javascript:switchTab('ANALYTICS');submitForm();">Analytics</a></li>
          </xsl:otherwise>
        </xsl:choose>

        <!--
          Messages - display messages on various screens for form
        -->
        <xsl:choose>
          <xsl:when test="$SCREEN = 'MESSAGES'">
            <li role="presentation" class="active"><a href="#">Messages</a></li>
          </xsl:when>
          <xsl:otherwise>
            <li role="presentation"><a href="javascript:switchTab('MESSAGES');submitForm();">Messages</a></li>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
    </ul>
  </xsl:template>
  <xsl:template name="score_nav">
    <ul class="nav nav-tabs">
      <li role="presentation" class="active"><a href="#">Edit Score</a></li>
    </ul>
  </xsl:template>
  <xsl:template name="message_nav">
    <ul class="nav nav-tabs">
      <li role="presentation" class="active"><a href="#">Message</a></li>
    </ul>
  </xsl:template>
</xsl:stylesheet>
