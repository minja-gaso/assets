<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />

	<xsl:import href="includes/calendar_global.xsl" />
	<xsl:import href="includes/calendar_date_time.xsl" />
	<xsl:import href="includes/calendar_mini.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates select="calendar" />
	</xsl:template>
	<xsl:template match="calendar">
	<!--
		<xsl:apply-templates select="topic" />
	-->
		<div id="bswh-marketing">
			<form action="" method="get" name="portal_form" id="bswh-form">
					<input type="hidden" name="searchType" value="keyword" />
					<div class="" id="app-container">
						<xsl:call-template name="external_files" />
						<xsl:call-template name="intro_message" />
						<xsl:call-template name="header" />
						<div class="clearfix" id="app-content">
							<xsl:call-template name="aside" />
							<xsl:call-template name="main" />
						</div>
						<xsl:call-template name="footer" />
						<xsl:call-template name="closing_message" />
					</div>
			</form>
		</div>
	</xsl:template>

	<xsl:template name="public_calendar">

		<div class="row" id="cal-main">
			<!--
			<div class="three columns" id="sidebar">
				<xsl:call-template name="sidebar" />
			</div>
		-->
			<div class="col-xs-12">
				<h1 class="form-group"><xsl:value-of select="/data/calendar/title" /></h1>
				<xsl:call-template name="main" />
				<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
			</div>
		</div>
		<xsl:if test="string-length(/data/form/messagePublicFormClosing) &gt; 0">
			<div class="form-message form-closing">
				<xsl:value-of select="/data/form/messagePublicFormClosing" disable-output-escaping="yes" />
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template name="main">
		<main class="entry-item">
			<a href="/calendar/list/{prettyUrl}">Home</a>
			<xsl:apply-templates select="event[position() = 1]" />
		</main>
	</xsl:template>

  <xsl:template match="event">
    <article id="entry-{id}" class="entry-{position()}">
			<!--
			<h2>
				<xsl:value-of select="title" />
			</h2>
			-->
			<section class="entry-thumbnail">
				<img src="/uploads/calendar/{../id}/{id}/{fileName}" alt="{fileDescription}" title="{fileDescription}" />
			</section>
      <section class="entry-summary">
				<h3>Summary</h3>
				<xsl:value-of select="description" disable-output-escaping="yes" />
			</section>
			<section class="entry-date-and-location">
				<h3>When &amp; Where</h3>
				<dl>
					<dt>Date</dt>
					<dd>
						<xsl:call-template name="format_date">
							<xsl:with-param name="paramDate" select="startDate" />
						</xsl:call-template>
					</dd>
					<dt>Time</dt>
					<dd>
		        <xsl:call-template name="format_time">
		          <xsl:with-param name="publishTime" select="publishTime" />
		        </xsl:call-template>
					</dd>
					<dt>Location</dt>
					<dd>
						<xsl:if test="string-length(location) &gt; 0">
							<div class="entry-location">
								<xsl:value-of select="location" disable-output-escaping="yes" />
							</div>
							<xsl:if test="string-length(locationAdditional) &gt; 0">
								<div class="entry-location">
									<xsl:value-of select="locationAdditional" disable-output-escaping="yes" />
								</div>
							</xsl:if>
						</xsl:if>
					</dd>
				</dl>
			</section>
			<section class="entry-meta">
				<h3>Details</h3>
				<dl>
					<xsl:if test="string-length(agenda) &gt; 0">
						<dt>Agenda</dt>
						<dd><xsl:value-of select="agenda" disable-output-escaping="no" /></dd>
					</xsl:if>
					<xsl:if test="string-length(agenda) &gt; 0">
						<dt>Speaker</dt>
						<dd><xsl:value-of select="speaker" disable-output-escaping="no" /></dd>
					</xsl:if>
					<xsl:if test="string-length(registrationUrl) &gt; 0">
						<dt>Registration</dt>
						<dd>
							<a href="{registrationUrl}" target="_blank">
								<xsl:choose>
									<xsl:when test="string-length(registrationLabel) &gt; 0">
										<xsl:text>
											<xsl:value-of select="registrationLabel" />
										</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>Register</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</a>
						</dd>
					</xsl:if>
					<xsl:if test="string-length(contactName) &gt; 0">
						<dt>Contact Name</dt>
						<dd><xsl:value-of select="contactName" disable-output-escaping="no" /></dd>
					</xsl:if>
					<xsl:if test="string-length(contactPhone) &gt; 0">
						<dt>Contact Phone</dt>
						<dd><xsl:value-of select="contactPhone" disable-output-escaping="no" /></dd>
					</xsl:if>
					<xsl:if test="string-length(contactEmail) &gt; 0">
						<dt>Contact Email</dt>
						<dd><a href="mailto:{contactEmail}"><xsl:value-of select="contactEmail" disable-output-escaping="no" /></a></dd>
					</xsl:if>
					<xsl:if test="string-length(cost) &gt; 0">
						<dt>Cost</dt>
						<dd><xsl:value-of select="cost" disable-output-escaping="no" /></dd>
					</xsl:if>
				</dl>
			</section>
    </article>
  </xsl:template>
</xsl:stylesheet>
