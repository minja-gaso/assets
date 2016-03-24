<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" />
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
			<input type="hidden" name="SCREEN" value="EVENT_IMAGE_UPLOAD" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<input type="hidden" name="EVENT_ID" value="{/data/calendar/event/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="event_content_navigation">
					<xsl:with-param name="SCREEN" select="'EVENT_IMAGE_UPLOAD'" />
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
				<h2>Add an Event Image</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="form-group">
					<div class="btn-toolbar">
						<button class="btn btn-default" onclick="saveEvent();submitForm();">Save</button>
						<button class="btn btn-default" onclick="eventListScreen();submitForm();">Back to Events</button>
						<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Calendar</a>
						<a class="btn btn-default" href="{$detailViewUrl}" target="_blank">View Event</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<xsl:variable name="parentId" select="/data/event/calendar/parentId" />
		<xsl:choose>
			<xsl:when test="string-length(/data/calendar/event/fileName) &gt; 0">
				<div class="form-group">
					<label for="EVENT_HEADER">
						Uploaded Image
						<xsl:if test="string-length(/data/calendar/event/fileName) &gt; 0">
							<a class="label label-primary" onclick="javascript:deleteEventImage();submitForm();">Delete Image</a>
						</xsl:if>
					</label>
					<div>
						<img src="/uploads/calendar/{/data/calendar/id}/{/data/calendar/event/id}/{/data/calendar/event/fileName}"
							class="img-thumbnail img-responsive"
							alt="{/data/calendar/event/fileDescription}" />
					</div>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="form-group">
					<button class="btn btn-primary my_popup_open">Upload Image</button>
					<script src="/js/resources/jquery.popupoverlay.js">//</script>
					<script>
						$(document).ready(function() {
							$('#my_popup').popup({
								type: 'overlay',
								color: '#f7f7f7',
								opacity: 1,
								transition: '0.3s',
								scrolllock: true
							});
						});
					</script>
				</div>
			</xsl:otherwise>
		</xsl:choose>
		<div id="my_popup" class="sr-only">
			<iframe class="embed-responsive-item" src="/toolbox/calendarEventImageUploadServlet?CALENDAR_ID={/data/calendar/id}&amp;EVENT_ID={/data/calendar/event/id}"></iframe>
			<hr/>
			<button class="btn btn-danger my_popup_close" id="my_popup_close">Close Upload</button>
			<button class="sr-only" id="uploaded"></button>
			<script>
				var uploaded = document.getElementById('uploaded');
				uploaded.addEventListener('click', function(){
					setTimeout(function(){
						document.portal_form.submit();
					}, 1000);
				})
			</script>
		</div>
	</xsl:template>
</xsl:stylesheet>
