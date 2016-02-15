<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/calendar_variables.xsl" />
	<xsl:include href="../includes/calendar_nav.xsl" />

	<xsl:template match="/">
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
					<div class="row">
						<div class="form-group col-lg-2 col-md-3 col-sm-3">
							<label for="EVENT_START_DATE">Start Date</label>
							<input type="text" class="form-control datepicker" name="EVENT_START_DATE" id="EVENT_START_DATE" value="{$startDate}" />
						</div>
						<div class="form-group col-lg-4 col-md-6 col-sm-6">
							<label class="EVENT_RECUR_TYPE">Recur by</label>
							<div class="form-inline">
								<label>
									<input type="radio" name="EVENT_RECUR_TYPE" id="EVENT_RECUR_BY_END_DATE" /> End Date
								</label>
								<br/>
								<label>
									<input type="radio" name="EVENT_RECUR_TYPE" id="EVENT_RECUR_BY_INTERVAL" /> Interval
								</label>
							</div>
						</div>
					</div>
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
