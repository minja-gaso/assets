<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/calendar_variables.xsl" />
	<xsl:include href="../includes/calendar_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="SKIN" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<!-- survey content -->
			<div class="row">
				<nav>
					<xsl:call-template name="primary_navigation">
						<xsl:with-param name="SCREEN" select="'SKIN'" />
					</xsl:call-template>
				</nav>
				<div class="col-lg-12 bordered-area">
					<h2>Appearance</h2>
					<xsl:call-template name="messages" />
					<div class="row" id="skin-select">
						<div class="form-group col-xs-12">
							<label for="CALENDAR_SKIN">Choose a Skin</label>
							<select class="form-control" name="CALENDAR_SKIN" id="CALENDAR_SKIN">
								<option />
								<xsl:for-each select="/data/skin">
									<option value="{id}">
										<xsl:if test="/data/calendar/fkSkinId = id">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										<xsl:text><xsl:value-of select="title" /></xsl:text>
									</option>
								</xsl:for-each>
							</select>
						</div>
					</div>
					<hr />
					<div class="row" id="skin-preview">
						<div class="form-group col-xs-12">
							<label for="CALENDAR_PREVIEW">Preview</label>
							<div class="embed-responsive embed-responsive-16by9">
							  <iframe class="embed-responsive-item" src="{$listUrl}">//</iframe>
							</div>
						</div>
					</div>
					<div class="btn-toolbar btn-actions">
						<a class="btn btn-default" href="javascript:saveCalendar();submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:calendars();submitForm();">Back to Calendars</a>
						<a class="btn btn-default" href="{$listUrl}" target="_blank">View Calendar</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
