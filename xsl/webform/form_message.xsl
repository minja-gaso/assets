<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	<xsl:import href="includes/global.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
  <xsl:template match="data">
    <xsl:apply-templates select="form" />
  </xsl:template>
  <xsl:template match="form">
		<div id="bswh-marketing">
	    <form action="" method="post" name="portal_form" id="bswh-form">
				<input type="hidden" name="ACTION" />
				<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
				<input type="hidden" name="PREVIOUS_PAGE" value="{/data/form/currentPage}" />
				<input type="hidden" name="CURRENT_PAGE" value="{/data/form/currentPage}" />
					<div class="" id="app-container">
						<xsl:call-template name="external_files" />
						<xsl:call-template name="header" />
						<xsl:call-template name="intro_message" />
						<div class="clearfix" id="app-content">
							<xsl:call-template name="main" />
						</div>
						<xsl:call-template name="closing_message" />
						<xsl:call-template name="footer" />
					</div>
			</form>
		</div>
  </xsl:template>

	<xsl:template name="main">
		<main class="col-sm-9" id="app-form">
			<xsl:variable name="score" select="/data/form/score" />
			<xsl:choose>
				<xsl:when test="/data/form/type = 'survey'">
					<div id="submitted">
						<xsl:value-of select="/data/form/messageThankYou" disable-output-escaping="yes" />
					</div>
				</xsl:when>
				<xsl:otherwise>
					<div id="assessment-summary">
						<h2><xsl:value-of select="/data/score[$score &gt;= begin and $score &lt;= end]/title" /></h2>
						<xsl:value-of select="/data/score[$score &gt;= begin and $score &lt;= end]/summary" disable-output-escaping="yes" />
						<small>Note: You scored a <strong><xsl:value-of select="$score" /></strong> on the self-assessment.</small>
					</div>
				</xsl:otherwise>
			</xsl:choose>
		</main>
	</xsl:template>

	<xsl:template name="test">
		<form action="" method="post" name="portal_form" id="public-form">
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="FORM_ID" value="{/data/form/id}" />
			<input type="hidden" name="PREVIOUS_PAGE" value="{/data/form/currentPage}" />
			<input type="hidden" name="CURRENT_PAGE" value="{/data/form/currentPage}" />
    	<link rel="stylesheet" type="text/css" href="/css/main.css?v=1" />
			<h1 class="form-group"><xsl:value-of select="/data/form/title" /></h1>
			<div class="form-message">
				<xsl:choose>
					<xsl:when test="/data/form/status = 'draft'">
						<xsl:value-of select="/data/form/messageNotStarted" disable-output-escaping="yes" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="/data/form/type = 'survey'">
								<xsl:value-of select="/data/form/messageThankYou" disable-output-escaping="yes" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="self_assessment_survey" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</div>
			<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
		</form>
    	<script src="/js/form.js?v=1"></script>
	</xsl:template>
	<xsl:template name="self_assessment_survey">
		<xsl:variable name="score" select="/data/form/score" />
		<div id="summary">
			<h2><xsl:value-of select="/data/score[$score &gt;= begin and $score &lt;= end]/title" /></h2>
			<xsl:value-of select="/data/score[$score &gt;= begin and $score &lt;= end]/summary" disable-output-escaping="yes" />
			<small>Note: You scored a <strong><xsl:value-of select="$score" /></strong> on the self-assessment.</small>
		</div>
	</xsl:template>
</xsl:stylesheet>
