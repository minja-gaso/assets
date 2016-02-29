<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/calendar_variables.xsl" />
	<xsl:include href="../includes/calendar_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="CATEGORIES" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<input type="hidden" name="CATEGORY_ID" />
			<!-- survey content -->
			<div class="row">
				<nav>
					<xsl:call-template name="primary_content_navigation">
						<xsl:with-param name="SCREEN" select="'CATEGORIES'" />
					</xsl:call-template>
				</nav>
				<div class="col-lg-12 bordered-area">
					<h2>Categories</h2>
					<xsl:call-template name="messages" />
					<div class="form-group">
						<label for="CALENDAR_ADD_CATEGORY">New Category</label>
						<div class="input-group">
							<input type="text" class="form-control" name="CALENDAR_ADD_CATEGORY" id="CALENDAR_ADD_CATEGORY" />
							<span class="input-group-btn">
								<button class="btn btn-primary btn-lg" onclick="javascript:addCategory();">Add Category</button>
							</span>
						</div>
					</div>
					<div class="form-group">
						<label for="AVAILABLE_CATEGORIES">Available Categories</label>
						<table class="table">
							<thead>
								<th class="col-lg-11">Name</th>
								<th class="col-lg-1 text-center">Delete</th>
							</thead>
							<tbody>
								<xsl:for-each select="/data/calendar/category">
									<tr>
										<th><xsl:value-of select="label" /></th>
										<th class="text-center"><a href="javascript:deleteCategory('{id}');submitForm();"><span class="fa fa-trash" /></a></th>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
					</div>
					<div class="form-row">
						<div class="btn-toolbar btn-actions">
							<a class="btn btn-default disabled" href="javascript:saveEvent();">Save</a>
							<a class="btn btn-default" href="javascript:eventListScreen();">Back to Events</a>
							<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Calendar</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
