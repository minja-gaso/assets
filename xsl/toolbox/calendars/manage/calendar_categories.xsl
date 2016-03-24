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
			<input type="hidden" name="SCREEN" value="CATEGORIES" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<input type="hidden" name="CATEGORY_ID" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_content_navigation">
					<xsl:with-param name="SCREEN" select="'CATEGORIES'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group" id="top-actions">
					<div class="btn-toolbar">
						<a class="btn btn-default disabled" href="javascript:submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:calendars();submitForm();">Back to Calendars</a>
						<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Calendar</a>
					</div>
				</div>
				<h2>Events for <em><xsl:value-of select="/data/calendar/title" /></em></h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-default disabled" href="javascript:saveEvent();">Save</a>
					<a class="btn btn-default" href="javascript:eventListScreen();">Back to Events</a>
					<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Calendar</a>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<div class="form-group">
			<label for="CALENDAR_ADD_CATEGORY">New Category</label>
			<div class="input-group">
				<input type="text" class="form-control" name="CALENDAR_ADD_CATEGORY" id="CALENDAR_ADD_CATEGORY" />
				<span class="input-group-btn">
					<button class="btn btn-primary" onclick="javascript:addCategory();">Add Category</button>
				</span>
			</div>
		</div>
		<div class="form-group">
			<label for="AVAILABLE_CATEGORIES">Available Categories</label>
			<xsl:choose>
				<xsl:when test="count(category) &gt; 0">
					<table class="table">
						<thead>
							<th class="col-lg-11">Name</th>
							<th class="col-lg-1 text-center">Delete</th>
						</thead>
						<tbody>
							<xsl:apply-templates select="category" />
						</tbody>
					</table>
				</xsl:when>
				<xsl:otherwise>
					<p>No categories exist.</p>
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	<xsl:template match="category">
		<tr>
			<th><xsl:value-of select="label" /></th>
			<th class="text-center"><a href="javascript:deleteCategory('{id}');submitForm();"><span class="fa fa-trash" /></a></th>
		</tr>
	</xsl:template>
</xsl:stylesheet>
