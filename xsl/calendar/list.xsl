<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	<xsl:variable name="apos">'</xsl:variable>

	<!-- global variables for mini calendar -->
	<xsl:variable name="start" select="/data/calendar/currentView/startDay"/>
	<xsl:variable name="count" select="/data/calendar/currentView/totalDays"/>
	<xsl:variable name="total" select="$start + $count - 1"/>
	<xsl:variable name="overflow" select="$total mod 7"/>
	<xsl:variable name="nelements">
    <xsl:choose>
        <xsl:when test="$overflow > 0"><xsl:value-of select="$total + 7 - $overflow"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$total"/></xsl:otherwise>
    </xsl:choose>
	</xsl:variable>
	<!-- global variables for mini calendar -->

	<xsl:import href="includes/calendar_global.xsl" />
	<xsl:import href="includes/calendar_date_time.xsl" />
	<xsl:import href="includes/calendar_mini.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form" id="public-form">
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<input type="hidden" name="POST_FORM" value="false" />
			<link rel="stylesheet" href="/css/resources/skeleton.css" type="text/css" />
	    <link href="/css/calendar.css" rel="stylesheet"/>
			<h1 class="form-group"><xsl:value-of select="/data/calendar/title" /></h1>
			<xsl:comment><xsl:value-of select="system-property('xsl:version')"/></xsl:comment>
			<xsl:choose>
				<!-- if form not started -->
				<xsl:when test="/data/form/started = 'false'">
					<div class="form-message">
						<xsl:value-of select="/data/form/messageNotStarted" disable-output-escaping="yes" />
					</div>
				</xsl:when>
				<!-- if none of cases above are met, display the form -->
				<xsl:otherwise>
					<div class="container">
						<xsl:call-template name="public_calendar" />
					</div>
				</xsl:otherwise>
			</xsl:choose>
			<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
		</form>
	</xsl:template>

	<xsl:template name="public_calendar">
		<xsl:if test="string-length(/data/form/messagePublicFormIntro) &gt; 0">
			<div class="form-message form-intro">
				<xsl:value-of select="/data/form/messagePublicFormIntro" disable-output-escaping="yes" />
			</div>
		</xsl:if>
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
		<div class="row">
			<div class="three columns" id="sidebar">
				<xsl:call-template name="sidebar" />
			</div>
			<div class="nine columns" id="main">
				<xsl:call-template name="main" />
			</div>
		</div>
		<xsl:if test="string-length(/data/form/messagePublicFormClosing) &gt; 0">
			<div class="form-message form-closing">
				<xsl:value-of select="/data/form/messagePublicFormClosing" disable-output-escaping="yes" />
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template name="main">
		<xsl:choose>
			<xsl:when test="count(/data/calendar/event) &gt; 0">
				<ul class="list-group">
					<xsl:key name="events-by-startDate" match="event" use="startDate" />
					<xsl:for-each select="/data/calendar/event">
						<xsl:if test="position() = 1 or startDate != preceding-sibling::*[1]/startDate">
							<li class="list-group-item day-row">
								<xsl:for-each select="key('events-by-startDate', startDate)">
									<xsl:if test="position() = 1">
										<div class="day-label">
											<strong>
												<span class="glyphicon glyphicon-calendar" />&#160;
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
										<div class="col-lg-2 col-md-3 col-sm-3">
											<span class="fa fa-clock-o" />&#160;
											<xsl:call-template name="format_time">
												<xsl:with-param name="startTime" select="startTime" />
												<xsl:with-param name="endTime" select="endTime" />
											</xsl:call-template>
										</div>
										<div class="col-lg-10 col-md-9 col-sm-9">
											<a href="/calendar/detail/{/data/calendar/prettyUrl}?eventID={id}"><xsl:value-of select="title" /></a>
											<xsl:if test="string-length(location) &gt; 0">
												<div>
													<span class="fa fa-map-marker pull-left" />
													<p class="location">
														<xsl:value-of select="location" disable-output-escaping="yes" />
														<xsl:if test="string-length(locationAdditional) &gt; 0">
															<span class="location-additional">
																<xsl:value-of select="locationAdditional" disable-output-escaping="yes" />
															</span>
														</xsl:if>
													</p>
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
				<p>There are currently no avilable events.</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
