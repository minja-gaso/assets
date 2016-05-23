<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="global_util.xsl" />
	<xsl:include href="includes/variables.xsl" />
	<xsl:include href="includes/nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="admin"></xsl:template>
	<xsl:template match="environment"></xsl:template>
	<xsl:template match="website">
		<xsl:variable name="url" select="concat(/data/environment/serverName, '/sitebuilder/preview/', template/id)" />

		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="TEMPLATE" />
			<input type="hidden" name="WEBSITE_ID" value="{/data/website/id}" />
			<input type="hidden" name="TEMPLATE_ID" value="{/data/website/template/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="template_edit" />
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>Modify Template</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-success" href="javascript:saveWebsiteTemplate();">Save</a>
					<a class="btn btn-danger" href="javascript:switchTab('TEMPLATES');">Back to Templates</a>
					<a class="btn btn-primary" href="{$url}" target="_blank">View Skin</a>
				</div>
			</div>
		</form>
	</xsl:template>

	<xsl:template name="main">
		<div class="row" id="title">
			<div class="form-group col-xs-12">
				<label for="TEMPLATE_TITLE">Name</label>
				<input type="text" class="form-control" name="TEMPLATE_TITLE" id="TEMPLATE_TITLE" value="{template/title}" />
			</div>
			<div class="form-group col-xs-12">
				<label for="TEMPLATE_HTML" class="show">HTML</label>
				<textarea class="form-control" name="TEMPLATE_HTML" id="TEMPLATE_HTML" rows="20">
					<xsl:choose>
						<xsl:when test="string-length(template/html) &gt; 0">
							<xsl:value-of select="template/html" />
						</xsl:when>
						<xsl:otherwise><xsl:text>&#x0A;</xsl:text></xsl:otherwise>
					</xsl:choose>
				</textarea>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
