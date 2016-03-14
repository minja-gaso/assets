<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/variables.xsl" />
	<xsl:include href="includes/nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="CSS" />
			<input type="hidden" name="SKIN_APP_NAME" />
			<input type="hidden" name="SKIN_ID" value="{/data/skin/id}" />
			<!-- survey content -->
			<div class="row">
				<nav>
					<xsl:call-template name="primary_navigation">
						<xsl:with-param name="SCREEN" select="'CSS'" />
					</xsl:call-template>
				</nav>
				<div class="col-lg-12 bordered-area">
					<h2>Custom Styling</h2>
					<xsl:call-template name="messages" />
					<div class="row" id="apps">
						<div class="form-group col-xs-12">
							<label>Application CSS</label>
							<ul class="list-group">
								<li class="list-group-item"><a href="javascript:document.portal_form.SCREEN.value='APP_CSS';document.portal_form.SKIN_APP_NAME.value='CALENDAR';document.portal_form.submit();">Calendar</a></li>
								<li class="list-group-item"><a href="javascript:document.portal_form.SCREEN.value='APP_CSS';document.portal_form.SKIN_APP_NAME.value='FORMS';document.portal_form.submit();">Forms</a></li>
							</ul>
						</div>
					</div>
					<div class="row" id="title">
						<div class="form-group col-xs-12">
							<label for="SKIN_CSS" class="show">Skin CSS <a class="label label-primary pull-right" onclick="resetCss();saveSkin();submitForm();">Reset CSS</a></label>
							<textarea class="form-control" name="SKIN_CSS" id="SKIN_CSS" rows="20">
								<xsl:choose>
									<xsl:when test="string-length(/data/skin/skinCssOverrides) &gt; 0">
<xsl:value-of select="/data/skin/skinCssOverrides" />
									</xsl:when>
									<xsl:otherwise>body {}</xsl:otherwise>
								</xsl:choose>
							</textarea>
						</div>
					</div>
					<div class="btn-toolbar btn-actions">
						<a class="btn btn-default" href="javascript:saveSkin();submitForm();">Save</a>
						<a class="btn btn-default" href="javascript:skins();submitForm();">Back to Skins</a>
						<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Calendar</a>
					</div>
				</div>
			</div>
		</form>
	</xsl:template>
</xsl:stylesheet>
