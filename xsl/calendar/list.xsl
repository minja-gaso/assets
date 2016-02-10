<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
	<xsl:variable name="apos">'</xsl:variable>
	<xsl:template match="/">
		<form action="" method="post" name="portal_form" id="public-form">
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<input type="hidden" name="POST_FORM" value="false" />
	    <link href="/css/main.css" rel="stylesheet"/>
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
					<xsl:call-template name="public_calendar" />
				</xsl:otherwise>
			</xsl:choose>
			<footer class="text-center">Provided by <em><a href="#">Interactive Marketing</a></em> at <em><a href="#">Baylor Scott &amp; White</a></em></footer>
		</form>
	</xsl:template>
	<xsl:template name="format_time">
		<xsl:param name="startTime" />
		<xsl:param name="endTime" />

		<xsl:variable name="startHourStr" select="substring(startTime, 1, 2)" />
		<xsl:variable name="startHour">
			<xsl:choose>
				<xsl:when test="number($startHourStr) = 0">12</xsl:when>
				<xsl:when test="number($startHourStr) &gt; 12">
					<xsl:value-of select="number($startHourStr) - 12" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="number($startHourStr)" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="startMinuteStr" select="substring(startTime, 4, 2)" />
		<xsl:variable name="startMinute" select="number($startMinuteStr)" />
		<xsl:variable name="startMeridiam">
			<xsl:choose>
				<xsl:when test="number($startHourStr) &gt; 11">p.m.</xsl:when>
				<xsl:otherwise>a.m.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="endHourStr" select="substring(endTime, 1, 2)" />
		<xsl:variable name="endHour">
			<xsl:choose>
				<xsl:when test="number($endHourStr) = 0">12</xsl:when>
				<xsl:when test="number($endHourStr) &gt; 12">
					<xsl:value-of select="number($endHourStr) - 12" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="number($endHourStr)" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="endMinuteStr" select="substring(endTime, 4, 2)" />
		<xsl:variable name="endMinute" select="number($endMinuteStr)" />
		<xsl:variable name="endMeridiam">
			<xsl:choose>
				<xsl:when test="number($endHourStr) &gt; 11">p.m.</xsl:when>
				<xsl:otherwise>a.m.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="startTimeLabel">
			<xsl:value-of select="$startHour" />
			<xsl:if test="$startMinute &gt; 0">
				<xsl:text>:</xsl:text>
				<xsl:value-of select="$startMinute" />
			</xsl:if>
			<xsl:if test="$startMeridiam != $endMeridiam">
				<xsl:value-of select="concat(' ', $startMeridiam)" />
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="endTimeLabel">
			<xsl:value-of select="$endHour" />
			<xsl:if test="$endMinute &gt; 0">
				<xsl:text>:</xsl:text>
				<xsl:value-of select="$endMinute" />
			</xsl:if>
			<xsl:value-of select="concat(' ', $endMeridiam)" />
		</xsl:variable>

		<xsl:value-of select="$startTimeLabel" /> - <xsl:value-of select="$endTimeLabel" />
	</xsl:template>

	<xsl:template name="public_calendar">
		<xsl:if test="string-length(/data/form/messagePublicFormIntro) &gt; 0">
			<div class="form-message form-intro">
				<xsl:value-of select="/data/form/messagePublicFormIntro" disable-output-escaping="yes" />
			</div>
		</xsl:if>
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
											</strong>
										</div>
									</xsl:if>
									<div class="row">
										<div class="col-lg-2 col-md-3 col-sm-3">
											<xsl:call-template name="format_time">
												<xsl:with-param name="startTime" select="startTime" />
												<xsl:with-param name="endTime" select="endTime" />
											</xsl:call-template>
										</div>
										<div class="col-lg-10 col-md-9 col-sm-9">
											<a href="/calendar/detail/{/data/calendar/id}?eventID={id}"><xsl:value-of select="title" /></a>
											<xsl:if test="string-length(location) &gt; 0">
												<p class="location">
													<xsl:value-of select="location" disable-output-escaping="yes" />
												</p>
											</xsl:if>
											<xsl:if test="string-length(locationAdditional) &gt; 0">
												<p class="location-additional">
													<xsl:value-of select="locationAdditional" disable-output-escaping="yes" />
												</p>
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
		<xsl:if test="string-length(/data/form/messagePublicFormClosing) &gt; 0">
			<div class="form-message form-closing">
				<xsl:value-of select="/data/form/messagePublicFormClosing" disable-output-escaping="yes" />
			</div>
		</xsl:if>
	</xsl:template>
	<xsl:template name="format_date">
		<xsl:param name="paramDate" />

		<xsl:variable name="year" select="substring($paramDate, 1, 4)" />
		<xsl:variable name="month" select="substring($paramDate, 6, 2)" />
		<xsl:variable name="monthStr">
			<xsl:choose>
				<xsl:when test="$month = '01'">January</xsl:when>
				<xsl:when test="$month = '02'">February</xsl:when>
				<xsl:when test="$month = '03'">March</xsl:when>
				<xsl:when test="$month = '04'">April</xsl:when>
				<xsl:when test="$month = '05'">May</xsl:when>
				<xsl:when test="$month = '06'">June</xsl:when>
				<xsl:when test="$month = '07'">July</xsl:when>
				<xsl:when test="$month = '08'">August</xsl:when>
				<xsl:when test="$month = '09'">September</xsl:when>
				<xsl:when test="$month = '10'">October</xsl:when>
				<xsl:when test="$month = '11'">November</xsl:when>
				<xsl:when test="$month = '12'">December</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="day" select="substring($paramDate, 9, 2)" />
		<xsl:variable name="dayStr">
			<xsl:choose>
				<xsl:when test="substring($day, 1, 1) = '0'">
					<xsl:value-of select="substring($day, 2, 1)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$day" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="formatted_date" select="concat($monthStr, ' ', $dayStr, ', ', $year)" />

		<xsl:value-of select="$formatted_date" />
	</xsl:template>
</xsl:stylesheet>
