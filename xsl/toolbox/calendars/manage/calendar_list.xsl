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
			<input type="hidden" name="SCREEN" value="FORM_LIST" />
			<input type="hidden" name="CALENDAR_ID" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="list_nav" />
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>Your Calendars</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<table class="table table-bordered table-condensed table-striped">
			<thead>
				<tr>
					<th class="col-lg-1 col-md-1 text-center">
						<input type="checkbox" onclick="toggleCheckboxes(this, 'CALENDAR_ID_LIST');" />
					</th>
					<th class="col-lg-9 col-md-9">Title</th>
					<th class="col-lg-1 col-md-1 text-center">View</th>
					<th class="col-lg-1 col-md-1 text-center">Edit</th>
				</tr>
			</thead>
			<tbody>
				<xsl:choose>
					<xsl:when test="count(/data/calendar) &gt; 0">
						<xsl:apply-templates select="calendar" />
					</xsl:when>
					<xsl:otherwise>
						<tr>
							<th class="font-normal" colspan="5">Click the <strong>Create New Calendar</strong> button above to get started.</th>
						</tr>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="calendar">
		<tr>
			<th class="text-center"><input type="checkbox" name="CALENDAR_ID_LIST" value="{id}" /></th>
			<td><a href="javascript:editCalendar('{id}');submitForm();"><xsl:value-of select="title" /></a></td>
			<td class="text-center"><a href="{concat($listBaseUrl, prettyUrl)}" target="_blank"><span class="fa fa-search" /></a></td>
			<td class="text-center"><a href="javascript:editCalendar('{id}');submitForm();"><span class="fa fa-edit" /></a></td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
