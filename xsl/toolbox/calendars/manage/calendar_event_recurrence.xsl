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
					<div class="form-group" id="event-recur">
						<label for="EVENT_RECUR">Should this event repeat?</label>
						<div class="form-inline">
							<input type="hidden" name="EVENT_RECUR" id="EVENT_RECUR" value="{/data/calendar/event/eventRecurrence/recurring}" />
							<label>
								<a href="javascript:document.getElementById('EVENT_RECUR').value='true';saveEvent();submitForm();">
									<span>
										<xsl:attribute name="class">
											<xsl:choose>
												<xsl:when test="/data/calendar/event/eventRecurrence/recurring = 'true'">fa fa-check-circle-o</xsl:when>
												<xsl:otherwise>fa fa-circle-o</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
									</span>
								</a>
								&#160;<xsl:text>Yes</xsl:text>
							</label>
							<label>
								<a href="javascript:document.getElementById('EVENT_RECUR').value='false';saveEvent();submitForm();">
									<span>
										<xsl:attribute name="class">
											<xsl:choose>
												<xsl:when test="/data/calendar/event/eventRecurrence/recurring = 'false'">fa fa-check-circle-o</xsl:when>
												<xsl:otherwise>fa fa-circle-o</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
									</span>
								</a>
								&#160;<xsl:text>No</xsl:text>
							</label>
						</div>
					</div>
					<xsl:if test="/data/calendar/event/eventRecurrence/recurring = 'true'">
					<div class="form-group" id="event-recur-monthly">
						<label for="EVENT_RECUR_MONTHLY">Repeat</label>
						<div class="form-inline">
							<input type="hidden" name="EVENT_RECUR_MONTHLY" id="EVENT_RECUR_MONTHLY" value="{/data/calendar/event/eventRecurrence/recurringMonthly}" />
							<div>
								<label>
									<a href="javascript:document.getElementById('EVENT_RECUR_MONTHLY').value='false';saveEvent();submitForm();">
										<span>
											<xsl:attribute name="class">
												<xsl:choose>
													<xsl:when test="/data/calendar/event/eventRecurrence/recurringMonthly = 'false'">fa fa-check-circle-o</xsl:when>
													<xsl:otherwise>fa fa-circle-o</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
										</span>
									</a>
									&#160;<xsl:text>Weekly</xsl:text>
								</label>
							</div>
							<div>
								<label>
									<a href="javascript:document.getElementById('EVENT_RECUR_MONTHLY').value='true';saveEvent();submitForm();">
										<span>
											<xsl:attribute name="class">
												<xsl:choose>
													<xsl:when test="/data/calendar/event/eventRecurrence/recurringMonthly = 'true'">fa fa-check-circle-o</xsl:when>
													<xsl:otherwise>fa fa-circle-o</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
										</span>
									</a>
									&#160;<xsl:text>Monthly</xsl:text>
								</label>
							</div>
						</div>
					</div>
					<div class="form-group" id="event-start-date">
						<label for="EVENT_START_DATE">Start Date</label>
						<input type="text" class="form-control" name="EVENT_START_DATE" id="EVENT_START_DATE" value="{$startDate}" disabled="disabled" readonly="readonly" />
					</div>
					<div class="form-group" id="event-recur-by">
						<label class="EVENT_RECUR_TYPE">Recur using</label>
						<div class="form-inline">
							<input type="hidden" name="EVENT_RECUR_TYPE" id="EVENT_RECUR_TYPE" value="{/data/calendar/event/eventRecurrence/type}" />
							<label>
								<input type="radio" name="EVENT_RECUR_TYPE_CB" id="EVENT_RECUR_BY_END_DATE" onclick="document.getElementById('EVENT_RECUR_TYPE').value='date';">
									<xsl:if test="/data/calendar/event/eventRecurrence/type = 'date'">
										<xsl:attribute name="checked">checked</xsl:attribute>
									</xsl:if>
								</input> End Date
							</label>
							<br/>
							<label>
								<input type="radio" name="EVENT_RECUR_TYPE_CB" id="EVENT_RECUR_BY_INTERVAL" onclick="document.getElementById('EVENT_RECUR_TYPE').value='interval';">
									<xsl:if test="/data/calendar/event/eventRecurrence/type = 'interval'">
										<xsl:attribute name="checked">checked</xsl:attribute>
									</xsl:if>
								</input>  Interval of <input type="text" class="form-control" name="EVENT_RECUR_LIMIT" id="EVENT_RECUR_LIMIT" value="{/data/calendar/event/eventRecurrence/limit}" size="2" maxlength="2" /> occurrences.
							</label>
						</div>
					</div>
					<div class="form-group form-inline" id="event-repeat-interval">
						<label for="EVENT_RECUR_INTERVAL">
							<xsl:text>Repeat every</xsl:text>&#160;
							<input type="text" class="form-control" name="EVENT_RECUR_INTERVAL" id="EVENT_RECUR_INTERVAL" value="{/data/calendar/event/eventRecurrence/interval}" maxlength="2" size="2" />
							<xsl:text>
								<xsl:choose>
									<xsl:when test="/data/calendar/event/eventRecurrence/recurringMonthly = 'true'">month</xsl:when>
									<xsl:otherwise>week</xsl:otherwise>
								</xsl:choose>
							</xsl:text>
							<!--
							<select class="form-control" name="EVENT_RECUR_BY" disabled="disabled">
								<option value="week">
									<xsl:if test="/data/calendar/event/eventRecurrence/recurringMonthly = 'false'">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:text>Week</xsl:text>
								</option>
								<option value="month">
									<xsl:if test="/data/calendar/event/eventRecurrence/recurringMonthly = 'true'">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:text>Month</xsl:text>
								</option>
							</select>
							-->
						</label>
					</div>
					<xsl:choose>
						<xsl:when test="/data/calendar/event/eventRecurrence/recurringMonthly = 'true'">
							<xsl:variable name="ordinal">
								<xsl:choose>
									<xsl:when test="$startDay = 1 or $startDay = 21 or $startDay = 31">st</xsl:when>
									<xsl:when test="$startDay = 2 or $startDay = 22">nd</xsl:when>
									<xsl:when test="$startDay = 3">rd</xsl:when>
									<xsl:otherwise>th</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<p>Repeat on the <strong><xsl:value-of select="concat($startDay, $ordinal)" /> day</strong> of each month.</p>
						</xsl:when>
						<xsl:otherwise>
							<div class="form-group form-inline" id="event-recur-days">
								<p><strong>Days to recur on:</strong></p>
								<label for="EVENT_RECUR_MONDAY">
									<script>
										function recurDay(element)
										{
											var id = element.id;

											var realId = id.split('_CB')[0];
											var realElement = document.getElementById(realId);

											if(element.checked)
											{
												realElement.value = true;
											}
											else
											{
												realElement.value = false;
											}
										}
									</script>
									<input type="hidden" name="EVENT_RECUR_MONDAY" id="EVENT_RECUR_MONDAY" value="{/data/calendar/event/eventRecurrence/monday}" />
									<input type="checkbox" name="EVENT_RECUR_MONDAY_CB" id="EVENT_RECUR_MONDAY_CB" onclick="recurDay(this);">
										<xsl:if test="/data/calendar/event/eventRecurrence/monday = 'true'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>&#160;
									<xsl:text>Monday</xsl:text>
								</label>
								<label for="EVENT_RECUR_TUESDAY">
									<input type="hidden" name="EVENT_RECUR_TUESDAY" id="EVENT_RECUR_TUESDAY" value="{/data/calendar/event/eventRecurrence/tuesday}" />
									<input type="checkbox" name="EVENT_RECUR_TUESDAY_CB" id="EVENT_RECUR_TUESDAY_CB" onclick="recurDay(this);">
										<xsl:if test="/data/calendar/event/eventRecurrence/tuesday = 'true'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>&#160;
									<xsl:text>Tuesday</xsl:text>
								</label>
								<label for="EVENT_RECUR_WEDNESDAY">
									<input type="hidden" name="EVENT_RECUR_WEDNESDAY" id="EVENT_RECUR_WEDNESDAY" value="{/data/calendar/event/eventRecurrence/wednesday}" />
									<input type="checkbox" name="EVENT_RECUR_WEDNESDAY_CB" id="EVENT_RECUR_WEDNESDAY_CB" onclick="recurDay(this);">
										<xsl:if test="/data/calendar/event/eventRecurrence/wednesday = 'true'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>&#160;
									<xsl:text>Wednesday</xsl:text>
								</label>
								<label for="EVENT_RECUR_THURSDAY">
									<input type="hidden" name="EVENT_RECUR_THURSDAY" id="EVENT_RECUR_THURSDAY" value="{/data/calendar/event/eventRecurrence/thursday}" />
									<input type="checkbox" name="EVENT_RECUR_THURSDAY_CB" id="EVENT_RECUR_THURSDAY_CB" onclick="recurDay(this);">
										<xsl:if test="/data/calendar/event/eventRecurrence/thursday = 'true'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>&#160;
									<xsl:text>Thursday</xsl:text>
								</label>
								<label for="EVENT_RECUR_FRIDAY">
									<input type="hidden" name="EVENT_RECUR_FRIDAY" id="EVENT_RECUR_FRIDAY" value="{/data/calendar/event/eventRecurrence/friday}" />
									<input type="checkbox" name="EVENT_RECUR_FRIDAY_CB" id="EVENT_RECUR_FRIDAY_CB" onclick="recurDay(this);">
										<xsl:if test="/data/calendar/event/eventRecurrence/friday = 'true'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>&#160;
									<xsl:text>Friday</xsl:text>
								</label>
								<label for="EVENT_RECUR_SATURDAY">
									<input type="hidden" name="EVENT_RECUR_SATURDAY" id="EVENT_RECUR_SATURDAY" value="{/data/calendar/event/eventRecurrence/saturday}" />
									<input type="checkbox" name="EVENT_RECUR_SATURDAY_CB" id="EVENT_RECUR_SATURDAY_CB" onclick="recurDay(this);">
										<xsl:if test="/data/calendar/event/eventRecurrence/saturday = 'true'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>&#160;
									<xsl:text>Saturday</xsl:text>
								</label>
								<label for="EVENT_RECUR_SUNDAY">
									<input type="hidden" name="EVENT_RECUR_SUNDAY" id="EVENT_RECUR_SUNDAY" value="{/data/calendar/event/eventRecurrence/sunday}" />
									<input type="checkbox" name="EVENT_RECUR_SUNDAY" id="EVENT_RECUR_SUNDAY" onclick="recurDay(this);">
										<xsl:if test="/data/calendar/event/eventRecurrence/sunday = 'true'">
											<xsl:attribute name="checked">checked</xsl:attribute>
										</xsl:if>
									</input>&#160;
									<xsl:text>Sunday</xsl:text>
								</label>
							</div>
						</xsl:otherwise>
					</xsl:choose>
					</xsl:if>
					<div class="form-row">
						<div class="btn-toolbar">
							<a class="btn btn-default" href="javascript:saveEvent();submitForm();">Save</a>
							<a class="btn btn-default" href="javascript:eventListScreen();submitForm();">Back to Events</a>
							<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Calendar</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
