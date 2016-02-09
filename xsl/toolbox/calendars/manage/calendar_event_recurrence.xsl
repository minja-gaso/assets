<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/calendar_variables.xsl" />
	<xsl:include href="../includes/calendar_nav.xsl" />




	<xsl:template match="/">
		<xsl:variable name="startDate">
			<xsl:variable name="year" select="substring(/data/calendar/event/startDate,1,4)" />
			<xsl:variable name="month" select="substring(/data/calendar/event/startDate,6,2)" />
			<xsl:variable name="day" select="substring(/data/calendar/event/startDate,9,2)" />
			<xsl:value-of select="concat($month, '/', $day, '/', $year)" />
		</xsl:variable>
		<xsl:variable name="endDate">
			<xsl:variable name="year" select="substring(/data/calendar/event/endDate,1,4)" />
			<xsl:variable name="month" select="substring(/data/calendar/event/endDate,6,2)" />
			<xsl:variable name="day" select="substring(/data/calendar/event/endDate,9,2)" />
			<xsl:value-of select="concat($month, '/', $day, '/', $year)" />
		</xsl:variable>
		<xsl:variable name="startTime" select="substring(/data/calendar/event/startTime, 1, 8)" />
		<xsl:variable name="endTime" select="substring(/data/calendar/event/endTime, 1, 8)" />
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="EVENT_RECURRENCE" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<input type="hidden" name="EVENT_ID" value="{/data/calendar/event/id}" />
			<!-- survey content -->
			<div class="row">
				<div class="col-lg-12">
					<nav>
						<xsl:call-template name="event_content_navigation">
							<xsl:with-param name="SCREEN" select="'EVENT_RECURRENCE'" />
						</xsl:call-template>
					</nav>
					<h2>Event Recurrence</h2>
					<xsl:call-template name="messages" />
					<div class="form-group">
						<label for="EVENT_TITLE">Title</label>
						<input type="text" class="form-control" name="EVENT_TITLE" id="EVENT_TITLE" value="{/data/calendar/event/title}" />
					</div>
					<div class="form-row">
						<div class="btn-toolbar">
							<a class="btn btn-default" href="javascript:saveEvent();">Save</a>
							<a class="btn btn-default" href="javascript:eventListScreen();">Back to Events</a>
							<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Calendar</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
