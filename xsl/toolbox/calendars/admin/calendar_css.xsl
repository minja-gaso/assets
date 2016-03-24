<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/calendar_variables.xsl" />
	<xsl:include href="../includes/calendar_nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="CSS" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'CSS'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group hidden" id="top-actions">
					<a class="btn btn-default" href="javascript:saveCalendar();submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:calendars();submitForm();">Back to Calendars</a>
					<a class="btn btn-default" href="{$listUrl}" target="_blank">View Calendar</a>
				</div>
				<h2>Custom Styling</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar">
					<a class="btn btn-default" href="javascript:saveCalendar();submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:calendars();submitForm();">Back to Calendars</a>
					<a class="btn btn-default" href="{$listUrl}" target="_blank">View Calendar</a>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<div class="row" id="title">
			<div class="form-group col-xs-12">
				<label for="CALENDAR_CSS">CSS</label>
				<textarea class="form-control" name="CALENDAR_CSS" id="CALENDAR_CSS" rows="20">
					<xsl:choose>
						<xsl:when test="string-length(/data/calendar/skinCssOverrides) &gt; 0">
<xsl:value-of select="/data/calendar/skinCssOverrides" />
						</xsl:when>
						<xsl:otherwise>
#calendar-main {}
#calendar-main h1 {}
						</xsl:otherwise>
					</xsl:choose>
				</textarea>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
