<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/variables.xsl" />
	<xsl:include href="includes/nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates select="skin" />
	</xsl:template>
	<xsl:template match="skin">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="HTML" />
			<input type="hidden" name="SKIN_ID" value="{/data/skin/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'HTML'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>Modify HTML</h2>
				<xsl:call-template name="wizard" />
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-default" href="javascript:saveSkin();submitForm();">Save</a>
					<a class="btn btn-default" href="javascript:skins();submitForm();">Back to Skins</a>
					<a class="btn btn-default" href="{$viewUrl}" target="_blank">View Skin</a>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="wizard">
		<nav id="wizard">
			<h3>Quick Jumps</h3>
			<ul>
				<li>
					<a class="done" href="javascript:switchTab('GENERAL');submitForm();">
						<div class="stepNumber">1</div>
						<span class="stepDesc text-small">Provide basic info</span>
					</a>
				</li>
				<li>
					<a class="done" href="javascript:switchTab('ROLES');submitForm();">
						<div class="stepNumber">2</div>
						<span class="stepDesc text-small">Assign access for other users</span>
					</a>
				</li>
				<li>
					<a class="selected" href="javascript:void(0);">
						<span class="stepNumber">3</span>
						<span class="stepDesc text-small">Modify skin and app HTML</span>
					</a>
				</li>
			</ul>
		</nav>
	</xsl:template>
	<xsl:template name="main">
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
	</xsl:template>
</xsl:stylesheet>
