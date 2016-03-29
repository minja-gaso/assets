<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />

	<xsl:import href="includes/calendar_global.xsl" />
	<xsl:import href="includes/calendar_date_time.xsl" />
	<xsl:import href="includes/calendar_mini.xsl" />

	<xsl:template match="/">
		<xsl:call-template name="public_calendar" />
	</xsl:template>

	<xsl:template name="public_calendar">
		<div class="row" id="cal-main">
			<div class="col-xs-12">
				<xsl:call-template name="main" />
				<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="main">
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
