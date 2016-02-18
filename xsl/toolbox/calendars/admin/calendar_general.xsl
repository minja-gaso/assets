<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/calendar_variables.xsl" />
	<xsl:include href="../includes/calendar_nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="GENERAL" />
			<input type="hidden" name="CALENDAR_ID" value="{/data/calendar/id}" />
			<!-- survey content -->
			<div class="row">
				<div class="col-lg-12 bordered-area">
					<nav>
						<xsl:call-template name="primary_navigation">
							<xsl:with-param name="SCREEN" select="'GENERAL'" />
						</xsl:call-template>
					</nav>
					<h2>General Information</h2>
					<xsl:call-template name="messages" />
					<div class="form-group">
						<label for="CALENDAR_TITLE">Title</label>
						<input type="text" class="form-control" name="CALENDAR_TITLE" id="CALENDAR_TITLE" value="{/data/calendar/title}" />
					</div>
					<div class="form-group">
						<label for="CALENDAR_URL">Standard URL</label>
						<p class="help-block">If you do not care about SEO, feel free to link to this URL.</p>
						<div class="input-group">
							<span class="input-group-addon"><xsl:value-of select="$baseUrl" /></span>
							<input type="text" class="form-control" name="CALENDAR_URL" id="CALENDAR_URL" value="{/data/calendar/id}" />
							<input type="hidden" name="HIDDEN_CALENDAR_URL" id="HIDDEN_CALENDAR_URL" value="{$url}" />
							<a href="{concat($baseUrl, /data/calendar/id)}" class="input-group-addon" target="_blank"><span class="fa fa-external-link" /></a>
						</div>
					</div>
					<div class="form-group">
						<label for="CALENDAR_PRETTY_URL">Pretty URL</label>
						<p class="help-block">We recommend a <em>Pretty URL</em>. You may use alphanumeric characters, hyphens, underscores and periods. This will be better for SEO.</p>
						<div class="input-group">
							<span class="input-group-addon"><xsl:value-of select="$baseUrl" /></span>
							<input type="text" class="form-control" name="CALENDAR_PRETTY_URL" id="CALENDAR_PRETTY_URL" value="{/data/calendar/prettyUrl}" />
							<a href="{$prettyUrl}" class="input-group-addon" target="_blank"><span class="fa fa-external-link" /></a>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-lg-6 col-md-6 col-sm-6">
							<label for="CALENDAR_SKIN_URL">Skin URL</label>
							<!--
							<p class="help-block">If you wish to have a skin around the survey, enter a URL.</p>
							-->
							<input type="text" class="form-control" name="CALENDAR_SKIN_URL" id="CALENDAR_SKIN_URL">
								<xsl:choose>
									<xsl:when test="string-length(/data/calendar/skinUrl) &gt; 0">
										<xsl:attribute name="value">
											<xsl:value-of select="/data/calendar/skinUrl" />
										</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="placeholder">
											<xsl:text>http://www.sw.org/location-search</xsl:text>
										</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
							</input>
						</div>
						<div class="form-group col-lg-2 col-md-2 col-sm-2">
							<label for="CALENDAR_SKIN_SELECTOR">Skin CSS Selector</label>
							<!--
							<p class="help-block">Element ID or class in which to insert content.</p>
							-->
							<input type="text" class="form-control" name="CALENDAR_SKIN_SELECTOR" id="CALENDAR_SKIN_SELECTOR">
								<xsl:choose>
									<xsl:when test="string-length(/data/calendar/skinSelector) &gt; 0">
										<xsl:attribute name="value">
											<xsl:value-of select="/data/calendar/skinSelector" />
										</xsl:attribute>
									</xsl:when>
									<xsl:otherwise>
										<xsl:attribute name="placeholder">
											<xsl:text>#ls-gen8-ls-area-body</xsl:text>
										</xsl:attribute>
									</xsl:otherwise>
								</xsl:choose>
							</input>
						</div>
					</div>
					<div class="btn-toolbar">
						<a class="btn btn-default" href="javascript:saveCalendar();submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:calendars();submitForm();">Back to Calendars</a>
						<a class="btn btn-default" href="{$listUrl}" target="_blank">View Calendar</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
