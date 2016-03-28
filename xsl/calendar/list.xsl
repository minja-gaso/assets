<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />

	<xsl:import href="includes/calendar_global.xsl" />
	<xsl:import href="includes/calendar_date_time.xsl" />
	<xsl:import href="includes/calendar_mini.xsl" />

	<xsl:template match="/">
		<form action="" method="get" name="portal_form" id="bswh-marketing">
			<div id="bswh">
				<script>
					var forms = document.getElementsByTagName('form');
					if(forms.length == 1)
					{
						forms[0].name = 'portal_form';
						forms[0].method = 'get';
					}
				</script>
				<input type="hidden" name="searchType" value="keyword" />
				<xsl:call-template name="external_files" />
		    <link href="/css/public/calendar.css" rel="stylesheet"/>
				<xsl:choose>
					<!-- if form not started -->
					<xsl:when test="/data/form/started = 'false'">
						<div class="form-message">
							<xsl:value-of select="/data/form/messageNotStarted" disable-output-escaping="yes" />
						</div>
					</xsl:when>
					<!-- if none of cases above are met, display the form -->
					<xsl:otherwise>
						<div class="" id="cal-container">
							<xsl:call-template name="public_calendar" />
						</div>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</form>
	</xsl:template>

	<xsl:template name="public_calendar">
		<xsl:if test="string-length(/data/form/messagePublicFormIntro) &gt; 0">
			<div class="form-message form-intro">
				<xsl:value-of select="/data/form/messagePublicFormIntro" disable-output-escaping="yes" />
			</div>
		</xsl:if>
		<!--
		<xsl:call-template name="display_mini_calendar" />
		<div class="row">
			<div class="col-lg-3 pull-right input-group">
				<input type="text" class="form-control" name="keyword" />
				<a class="input-group-addon">
					<span class="fa fa-search" />
				</a>
			</div>
		</div>
    <ol class="breadcrumb">
      <li class="active">Home</li>
    </ol>
	-->
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
		<xsl:call-template name="top_nav" />
		<xsl:choose>
			<xsl:when test="count(/data/calendar/event) &gt; 0">
				<ul class="list-group" id="events-list">
					<xsl:key name="events-by-startDate" match="event" use="startDate" />
					<xsl:for-each select="/data/calendar/event">
						<xsl:if test="position() = 1 or startDate != preceding-sibling::*[1]/startDate">
							<li class="list-group-item day-row">
								<xsl:for-each select="key('events-by-startDate', startDate)">
									<xsl:if test="position() = 1">
										<div class="day-label">
											<strong>
												<span class="fa fa-calendar" />&#160;
												<xsl:call-template name="format_date">
													<xsl:with-param name="paramDate" select="startDate" />
												</xsl:call-template>
												<xsl:if test="startDate != endDate">
													&#160;-&#160;
													<xsl:call-template name="format_date">
														<xsl:with-param name="paramDate" select="endDate" />
													</xsl:call-template>
												</xsl:if>
											</strong>
										</div>
									</xsl:if>
									<div class="entry row">
										<div class="col-xs-3 entry-time">
											<span class="fa fa-clock-o" />&#160;
											<xsl:call-template name="format_time">
												<xsl:with-param name="startTime" select="startTime" />
												<xsl:with-param name="endTime" select="endTime" />
											</xsl:call-template>
										</div>
										<div class="col-xs-9 entry-info">
											<a href="/calendar/detail/{/data/calendar/prettyUrl}?eventID={id}"><xsl:value-of select="title" /></a>
											<xsl:if test="string-length(location) &gt; 0">
												<div>
													<span class="fa fa-map-marker pull-left" />
													<p class="location">
														<xsl:value-of select="location" disable-output-escaping="yes" />
													</p>
													<xsl:if test="string-length(locationAdditional) &gt; 0">
														<div class="location-additional">
															<xsl:value-of select="locationAdditional" disable-output-escaping="yes" />
														</div>
													</xsl:if>
												</div>
											</xsl:if>
										</div>
									</div>
								</xsl:for-each>
							</li>
						</xsl:if>
					</xsl:for-each>
				</ul>
			</xsl:when>
			<xsl:otherwise>
				<p>There are currently no available events.</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
