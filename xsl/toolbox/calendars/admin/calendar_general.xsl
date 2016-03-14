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
				<nav>
					<xsl:call-template name="primary_navigation">
						<xsl:with-param name="SCREEN" select="'GENERAL'" />
					</xsl:call-template>
				</nav>
				<div class="col-lg-12 bordered-area">
					<h2>General Information</h2>
					<nav id="wizard">
						<h3>Quick Jumps</h3>
						<ul>
							<li>
								<a class="selected" href="javascript:void(0);" title="current page">
									<span class="stepNumber">1</span>
									<span class="stepDesc text-small">Provide basic info</span>
								</a>
							</li>
							<li>
								<a href="javascript:switchTab('ROLES');submitForm();">
									<span class="stepNumber">2</span>
									<span class="stepDesc text-small">Assign access for other users</span>
								</a>
							</li>
							<li>
								<a href="javascript:document.portal_form.COMPONENT_ID.value=4;editCalendar('{/data/calendar/id}');submitForm();">
									<span class="stepNumber">3</span>
									<span class="stepDesc text-small">Start adding events</span>
								</a>
							</li>
						</ul>
					</nav>
					<xsl:call-template name="messages" />
					<div class="row" id="title">
						<div class="form-group col-xs-12">
							<label for="CALENDAR_TITLE">Title</label>
							<input type="text" class="form-control" name="CALENDAR_TITLE" id="CALENDAR_TITLE" value="{/data/calendar/title}" />
						</div>
					</div>
					<div class="row" id="url">
						<div class="form-group col-xs-12">
							<label for="CALENDAR_URL">Standard URL</label>
							<p class="help-block">If you do not care about SEO, feel free to link to this URL.</p>
							<input type="text" class="form-control" value="{$url}" disabled="disabled" readonly="readonly" />
						</div>
					</div>
					<div class="row" id="pretty-url">
						<div class="form-group col-xs-12">
							<label for="CALENDAR_PRETTY_URL">Pretty URL</label>
							<p class="help-block">SEO-friendly alternative to standard URLs that gives you control.  You may use alphanumeric characters, hyphens, underscores and periods.</p>
							<div class="input-group input-group-url">
								<span class="input-group-addon"><xsl:value-of select="$baseUrl" /></span>
								<input type="text" class="form-control" name="CALENDAR_PRETTY_URL" id="CALENDAR_PRETTY_URL" value="{/data/calendar/prettyUrl}" />
								<a href="{$prettyUrl}" class="input-group-addon" target="_blank"><span class="fa fa-external-link" /></a>
							</div>
						</div>
					</div>
					<div class="row" id="skin">
						<div class="form-group col-xs-12">
							<label for="CALENDAR_SKIN_ID">Choose Skin</label>
							<select class="form-control" id="CALENDAR_SKIN_ID" name="CALENDAR_SKIN_ID">
								<option value="0" />
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
