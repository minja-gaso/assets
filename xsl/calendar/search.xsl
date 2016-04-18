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

	<xsl:template name="main222">
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

	<xsl:template name="main">
		<main class="entry-list">
			<xsl:key name="startDate" match="event" use="startDate" />
			<xsl:apply-templates select="event[key('startDate', startDate)]" />
		</main>
	</xsl:template>

  <xsl:template match="event">
    <article id="entry-{id}">
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="position() = 1 or startDate != preceding-sibling::*[1]/startDate">entry-<xsl:value-of select="position()" /> entry-leader</xsl:when>
					<xsl:otherwise>entry-<xsl:value-of select="position()" /> entry-standard</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:if test="position() = 1 or startDate != preceding-sibling::*[1]/startDate">
				<date>
					<xsl:call-template name="format_date">
            <xsl:with-param name="paramDate" select="startDate" />
          </xsl:call-template>
				</date>
			</xsl:if>
			<h3>
				<a href="/calendar/detail/{/data/calendar/prettyUrl}?eventID={id}">
					<xsl:value-of select="title" />
				</a>
			</h3>
      <time>
        <xsl:call-template name="format_time">
          <xsl:with-param name="publishTime" select="publishTime" />
        </xsl:call-template>
      </time>
      <section class="entry-summary">
				<xsl:if test="string-length(location) &gt; 0">
					<div class="location">
						<xsl:value-of select="location" disable-output-escaping="yes" />
					</div>
					<xsl:if test="string-length(locationAdditional) &gt; 0">
						<div class="location-additional">
							<xsl:value-of select="locationAdditional" disable-output-escaping="yes" />
						</div>
					</xsl:if>
				</xsl:if>
			</section>
    </article>
  </xsl:template>
</xsl:stylesheet>
