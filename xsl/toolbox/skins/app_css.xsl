<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/variables.xsl" />
	<xsl:include href="includes/nav.xsl" />
	<xsl:variable name="appLabel">
		<xsl:choose>
			<xsl:when test="/data/skin/selectedApp = 'CALENDAR'">Calendar</xsl:when>
			<xsl:when test="/data/skin/selectedApp = 'FORMS'">Form</xsl:when>
			<xsl:otherwise>App</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="APP_CSS" />
			<input type="hidden" name="SKIN_APP_NAME" value="{/data/skin/selectedApp}" />
			<input type="hidden" name="SKIN_ID" value="{/data/skin/id}" />
			<!-- survey content -->
			<div class="row">
				<nav>
					<xsl:call-template name="app_css_navigation">
						<xsl:with-param name="SCREEN" select="'APP_CSS'" />
					</xsl:call-template>
				</nav>
				<div class="col-lg-12 bordered-area">
					<h2>Custom Styling for <xsl:value-of select="$appLabel" /></h2>
					<xsl:call-template name="messages" />
					<div class="row" id="title">
						<div class="form-group col-xs-12">
							<label for="SKIN_APP_CSS" class="show">CSS <a class="label label-primary pull-right" onclick="resetCss();saveSkin();submitForm();">Reset CSS</a></label>
							<textarea class="form-control" name="SKIN_APP_CSS" id="SKIN_APP_CSS" rows="20">
								<xsl:choose>
									<xsl:when test="$appLabel = 'Calendar' and string-length(/data/skin/calendarCss) &gt; 0">
										<xsl:value-of select="/data/skin/calendarCss" />
									</xsl:when>
									<xsl:when test="$appLabel = 'Form' and string-length(/data/skin/formCss) &gt; 0">
										<xsl:value-of select="/data/skin/formCss" />
									</xsl:when>
									<xsl:otherwise><xsl:text>&#x0A;</xsl:text></xsl:otherwise>
								</xsl:choose>
							</textarea>
						</div>
					</div>
					<div class="btn-toolbar btn-actions">
						<a class="btn btn-default" href="javascript:saveAppCss();submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:switchTab('CSS');submitForm();">Back to Skin CSS</a>
						<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Skin</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
