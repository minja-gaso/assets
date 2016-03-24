<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/calendar_variables.xsl" />
	<xsl:include href="../includes/calendar_nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates select="calendar" />
	</xsl:template>
	<xsl:template match="calendar">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="EVENT" />
			<input type="hidden" name="CALENDAR_ID" value="{id}" />
			<input type="hidden" name="EVENT_ID" value="{event/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="event_content_navigation">
					<xsl:with-param name="SCREEN" select="'EVENT'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group" id="top-actions">
					<div class="btn-toolbar">
						<button class="btn btn-default" onclick="saveEvent();submitForm();">Save</button>
						<button class="btn btn-default" onclick="eventListScreen();submitForm();">Back to Events</button>
						<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Calendar</a>
						<a class="btn btn-default" href="{$detailViewUrl}" target="_blank">View Event</a>
					</div>
				</div>
				<h2>Edit Event</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="form-row">
					<div class="btn-toolbar">
						<button class="btn btn-default" onclick="saveEvent();submitForm();">Save</button>
						<button class="btn btn-default" onclick="eventListScreen();submitForm();">Back to Events</button>
						<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Calendar</a>
						<a class="btn btn-default" href="{$detailViewUrl}" target="_blank">View Event</a>
					</div>
				</div>
			</div>
			<script src="/js/view/calendar_event_general.js">//</script>
			<script>
				generateTimeOptions('EVENT_END_TIME', '<xsl:value-of select="$endTime" />');
				generateTimeOptions('EVENT_START_TIME', '<xsl:value-of select="$startTime" />');

				$(document).ready(function(){
					$("#EVENT_TAGS_LIST").tagit({
						fieldName: 'EVENT_TAGS',
						removeConfirmation: true,
						allowSpaces: true
					});
					$("#EVENT_START_DATE").datepicker({
						changeMonth: true,
						changeYear: true,
						dateFormat: "mm-dd-yy",
						onSelect: function(selected){
							 $("#EVENT_END_DATE").datepicker("option","minDate", selected)
						}
					}).datepicker("setDate", new Date("<xsl:value-of select="$startDate" />"));
					$("#EVENT_END_DATE").datepicker({
						changeMonth: true,
						changeYear: true,
						dateFormat: "mm-dd-yy",
						onSelect: function(selected){
							 $("#EVENT_START_DATE").datepicker("option","maxDate", selected)
						}
					}).datepicker("setDate", new Date("<xsl:value-of select="$endDate" />"));
				});
			</script>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<xsl:apply-templates select="event" />
	</xsl:template>
	<xsl:template match="event">
		<div class="form-group">
			<strong class="label">Published</strong>
			<div class="form-inline">
				<label class="inline">
					<input type="radio" name="EVENT_PUBLISHED" id="EVENT_PUBLISHED_TRUE" value="true">
						<xsl:if test="published = 'true'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
					</input>&#160;<xsl:text>Yes</xsl:text>
				</label>
				<label class="inline">
					<input type="radio" name="EVENT_PUBLISHED" id="EVENT_PUBLISHED_FALSE" value="false">
						<xsl:if test="published = 'false'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
					</input>&#160;<xsl:text>No</xsl:text>
				</label>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">General</div>
			<div class="panel-body">
				<div class="form-group">
					<label for="EVENT_TITLE">Title <span class="required">*</span></label>
					<input type="text" class="form-control" name="EVENT_TITLE" id="EVENT_TITLE" value="{title}" />
				</div>
				<xsl:if test="eventRecurrence/recurring = 'true' or parentId > 0">
					<div class="form-group">
						<label for="EVENT_TITLE_RECURRING_LABEL">Recurring Label</label>
						<input type="text" class="form-control" name="EVENT_TITLE_RECURRING_LABEL" id="EVENT_TITLE_RECURRING_LABEL" value="{titleRecurringLabel}" />
					</div>
				</xsl:if>
				<div class="row">
					<div class="form-group col-lg-2 col-md-3 col-sm-3">
						<label for="EVENT_START_DATE">Start Date <span class="required">*</span></label>
						<input type="text" class="form-control datepicker" name="EVENT_START_DATE" id="EVENT_START_DATE" value="{$startDate}" />
					</div>
					<div class="form-group col-lg-2 col-md-3 col-sm-3">
						<label for="EVENT_START_TIME">Start Time <span class="required">*</span></label>
						<select class="form-control" name="EVENT_START_TIME" id="EVENT_START_TIME">
							<option />
						</select>
					</div>
					<div class="form-group col-lg-2 col-md-3 col-sm-3">
						<label for="EVENT_END_DATE">End Date <span class="required">*</span></label>
						<input type="text" class="form-control datepicker" name="EVENT_END_DATE" id="EVENT_END_DATE" value="{$endDate}" />
					</div>
					<div class="form-group col-lg-2 col-md-3 col-sm-3">
						<label for="EVENT_END_TIME">End Time <span class="required">*</span></label>
						<select class="form-control" name="EVENT_END_TIME" id="EVENT_END_TIME">
							<option />
						</select>
					</div>
					<div class="form-group col-xs-12">
						<label for="EVENT_DESCRIPTION">Description <span class="required">*</span></label>
						<p class="help-block">Provide a summary for the event.</p>
						<input type="hidden" name="EVENT_DESCRIPTION" id="EVENT_DESCRIPTION" value="{description}" />
						<trix-editor input="EVENT_DESCRIPTION"></trix-editor>
					</div>
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading">Location</div>
			<div class="panel-body">
				<div class="form-group">
					<strong class="label">Is location a Baylor Scott &amp; White owned property?</strong>
					<input type="hidden" name="IS_EVENT_LOCATION_OWNED" value="{locationOwned}" />
					<div class="form-inline">
						<label class="inline">
								<a href="javascript:document.portal_form.IS_EVENT_LOCATION_OWNED.value='true';saveEvent();submitForm();">
									<span class="fa fa-check-square-o">
										<xsl:attribute name="class">
											<xsl:choose>
												<xsl:when test="locationOwned = 'true'">
													<xsl:text>fa fa-check-square-o</xsl:text>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text>fa fa-square-o</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
									</span>
								</a> Yes
						</label>
						<label class="inline">
							<a href="javascript:document.portal_form.IS_EVENT_LOCATION_OWNED.value='false';saveEvent();submitForm();">
								<span class="fa fa-check-square-o">
									<xsl:attribute name="class">
										<xsl:choose>
											<xsl:when test="locationOwned = 'false'">
												<xsl:text>fa fa-check-square-o</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text>fa fa-square-o</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:attribute>
								</span>
							</a> No
						</label>
					</div>
				</div>
				<div class="form-group">
					<label for="EVENT_LOCATION">Building <span class="required">*</span></label>
					<p class="help-block">
						<xsl:choose>
							<xsl:when test="locationOwned = 'true'">Select a location for the event.</xsl:when>
							<xsl:otherwise>Enter a location for the event.</xsl:otherwise>
						</xsl:choose>
					</p>
					<xsl:choose>
						<xsl:when test="locationOwned = 'true'">
							<select class="form-control" name="EVENT_LOCATION" id="EVENT_LOCATION" >
								<option onselect="document.getElementById('EVENT_LOCATION_TEXT').disabled = false;" />
								<option value="Scott &amp; White Memorial Hospital - Temple">
									<xsl:if test="location = 'Scott &amp; White Memorial Hospital - Temple'">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:text>Scott &amp; White Memorial Hospital - Temple</xsl:text>
								</option>
								<option value="Scott &amp; White Memorial Hospital - Killeen">
									<xsl:if test="location = 'Scott &amp; White Memorial Hospital - Killeen'">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:text>Scott &amp; White Memorial Hospital - Killeen</xsl:text>
								</option>
								<option value="Scott &amp; White Clinic - Temple">
									<xsl:if test="location = 'Scott &amp; White Clinic - Temple'">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:text>Scott &amp; White Clinic - Temple</xsl:text>
								</option>
								<option value="Scott &amp; White Clinic - Leander">
									<xsl:if test="location = 'Scott &amp; White Clinic - Leander'">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:text>Scott &amp; White Clinic - Leander</xsl:text>
								</option>
								<option value="Baylor Scott &amp; White Clinic - Cedar Park">
									<xsl:if test="location = 'Baylor Scott &amp; White Clinic - Cedar Park'">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:text>Baylor Scott &amp; White Clinic - Cedar Park</xsl:text>
								</option>
								<option value="Scott &amp; White College Station Hospital">
									<xsl:if test="location = 'Scott &amp; White College Station Hospital'">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:text>Scott &amp; White College Station Hospital</xsl:text>
								</option>
							</select>
						</xsl:when>
						<xsl:otherwise>
							<input type="text" class="form-control" name="EVENT_LOCATION" id="EVENT_LOCATION" value="{location}" />
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div class="form-group">
					<label for="EVENT_LOCATION_ADDITIONAL">Additional Location Information</label>
					<p class="help-block">Unit, floor, room, etc.</p>
					<input type="hidden" name="EVENT_LOCATION_ADDITIONAL" id="EVENT_LOCATION_ADDITIONAL" value="{locationAdditional}" />
					<trix-editor input="EVENT_LOCATION_ADDITIONAL"></trix-editor>
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading"><span class="fa fa-plus-square fa-lg">&#160;</span> Contact Information</div>
			<div class="panel-body">
				<div class="form-group">
					<label for="EVENT_CONTACT_NAME">Name</label>
					<input type="text" class="form-control" name="EVENT_CONTACT_NAME" id="EVENT_CONTACT_NAME" value="{contactName}" />
				</div>
				<div class="form-group">
					<label for="EVENT_CONTACT_PHONE">Phone</label>
					<input type="text" class="form-control" name="EVENT_CONTACT_PHONE" id="EVENT_CONTACT_PHONE" value="{contactPhone}" />
				</div>
				<div class="form-group">
					<label for="EVENT_CONTACT_EMAIL">Email</label>
					<input type="text" class="form-control" name="EVENT_CONTACT_EMAIL" id="EVENT_CONTACT_EMAIL" value="{contactEmail}" />
				</div>
			</div>
		</div>
		<div class="panel panel-default">
			<div class="panel-heading"><span class="fa fa-plus-square fa-lg">&#160;</span> Miscellaneous</div>
			<div class="panel-body">
				<div class="form-group">
					<label for="EVENT_SPEAKER">Speaker</label>
					<input type="text" class="form-control" name="EVENT_SPEAKER" id="EVENT_SPEAKER" value="{speaker}" />
				</div>
				<div class="form-group">
					<label for="EVENT_COST">Cost</label>
					<input type="text" class="form-control" name="EVENT_COST" id="EVENT_COST" value="{cost}" />
				</div>
				<div class="form-group">
					<label for="EVENT_REGISTRATION_LABEL">Registration Label</label>
					<input type="text" class="form-control" name="EVENT_REGISTRATION_LABEL" id="EVENT_REGISTRATION_LABEL" value="{registrationLabel}" />
				</div>
				<div class="form-group">
					<label for="EVENT_REGISTRATION_URL">Registration URL</label>
					<input type="text" class="form-control" name="EVENT_REGISTRATION_URL" id="EVENT_REGISTRATION_URL" value="{registrationUrl}" />
				</div>
				<div class="form-group">
					<label for="EVENT_TAGS">Tags</label>
					<p class="help-block">Press <em>comma</em> to add new tag.  Tags can be comprised of multiple words.</p>
					<ul id="EVENT_TAGS_LIST">
						<xsl:for-each select="tag">
							<li><xsl:value-of select="label" /></li>
						</xsl:for-each>
					</ul>
				</div>
				<xsl:if test="count(../category) &gt; 0">
					<xsl:variable name="categoryId" select="categoryId" />
					<div class="form-group">
						<label for="EVENT_CATEGORY">Category</label>
						<div class="styled-select">
							<select class="form-control" id="EVENT_CATEGORY" name="EVENT_CATEGORY">
								<option value="0" />
								<xsl:for-each select="/data/calendar/category">
									<option value="{id}">
										<xsl:if test="$categoryId = id">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="label" />
									</option>
								</xsl:for-each>
							</select>
						</div>
					</div>
				</xsl:if>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
