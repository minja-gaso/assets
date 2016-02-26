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

	<xsl:variable name="categoryId" select="/data/calendar/search/categoryId" />
	<xsl:variable name="tagId" select="/data/calendar/search/tagId" />

	<xsl:import href="includes/calendar_global.xsl" />
	<xsl:import href="includes/calendar_date_time.xsl" />
	<xsl:import href="includes/calendar_mini.xsl" />

	<xsl:template match="/">
		<form action="" method="get" name="portal_form" id="public-form">
			<div id="calendar-main">
				<input type="hidden" name="searchType" value="keyword" />
				<xsl:if test="/data/calendar/skinUrl">
					<link href="/css/resources/bootstrap/styles/bootstrap.min.css" rel="stylesheet"/>
			    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"/>
				</xsl:if>
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
						<xsl:call-template name="public_calendar" />
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
    <ol class="breadcrumb">
      <li><a href="/calendar/list/{/data/calendar/id}">Home</a></li>
      <li class="active">
				<xsl:choose>
					<xsl:when test="/data/calendar/search/categoryId > 0">
						Category: <xsl:value-of select="/data/calendar/category[id=$categoryId]/label" />
					</xsl:when>
					<xsl:when test="/data/calendar/search/tagId > 0">
						Tag: <xsl:value-of select="/data/calendar/event/tag[id=$tagId]/label" />
					</xsl:when>
					<xsl:otherwise>
						Search: <xsl:value-of select="/data/calendar/search/query" />
					</xsl:otherwise>
				</xsl:choose>
			</li>
    </ol>
		<div class="row">
			<!--
			<div class="col-lg-3 col-md-3 col-sm-3">
				<xsl:call-template name="sidebar" />
			</div>-->
			<div class="col-lg-12 col-md-12 col-sm-12">
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
		<div class="col-xs-6 center-block" id="advanced-search">
			<fieldset id="advanced-search-container">
				<legend>Advanced Search</legend>
				<div class="form-group">
					<label class="sr-only" for="ADVANCED_SEARCH_KEYWORD">Keyword(s)</label>
					<input type="text" class="form-control" name="ADVANCED_SEARCH_KEYWORD" id="ADVANCED_SEARCH_KEYWORD" placeholder="Enter keyword(s)" />
				</div>
				<div class="row">
					<div class="form-group col-sm-6">
						<label class="sr-only" for="ADVANCED_SEARCH_START_DATE">From</label>
						<input type="text" class="form-control" name="ADVANCED_SEARCH_START_DATE" id="ADVANCED_SEARCH_START_DATE" />
					</div>
					<div class="form-group col-sm-6">
						<label class="sr-only" for="ADVANCED_SEARCH_END_DATE">To</label>
						<input type="text" class="form-control" name="ADVANCED_SEARCH_END_DATE" id="ADVANCED_SEARCH_END_DATE" />
					</div>
				</div>
				<xsl:if test="count(/data/calendar/category) &gt; 0">
					<div class="form-group">
						<label>Category</label>
						<select class="form-control" name="ADVANCED_SEARCH_CATEGORY" id="ADVANCED_SEARCH_CATEGORY">
							<xsl:for-each select="/data/calendar/category">
								<option><xsl:value-of select="position()" /></option>
							</xsl:for-each>
						</select>
					</div>
				</xsl:if>
				<div class="text-center">
					<button class="btn btn-primary">Submit</button>
				</div>
			</fieldset>
		</div>
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
