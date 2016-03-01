<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/variables.xsl" />
	<xsl:include href="includes/nav.xsl" />

	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="HTML" />
			<input type="hidden" name="SKIN_ID" value="{/data/skin/id}" />
			<!-- survey content -->
			<div class="row">
				<nav>
					<xsl:call-template name="primary_navigation">
						<xsl:with-param name="SCREEN" select="'HTML'" />
					</xsl:call-template>
				</nav>
				<div class="col-lg-12 bordered-area">
					<h2>Modify HTML</h2>
					<div class="alert alert-info">
						<strong>Editable</strong> is set to <em>No</em>.  If you wish to modify the source code, please set <strong>Editable</strong> to <em>Yes</em> on the General tab.
					</div>
					<xsl:call-template name="messages" />
					<div class="row" id="title">
						<div class="form-group col-xs-12">
							<label for="SKIN_HTML" class="show">HTML</label>
							<textarea class="form-control" name="SKIN_HTML" id="SKIN_HTML" rows="20">
								<xsl:if test="/data/skin/editable = 'false'">
									<xsl:attribute name="disabled">disabled</xsl:attribute>
								</xsl:if>
								<xsl:choose>
									<xsl:when test="string-length(/data/skin/skinHtml) &gt; 0">
										<xsl:value-of select="/data/skin/skinHtml" />
									</xsl:when>
									<xsl:otherwise><xsl:text>&#x0A;</xsl:text></xsl:otherwise>
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
