<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="global_util.xsl" />
	<xsl:include href="includes/variables.xsl" />
	<xsl:include href="includes/nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<xsl:apply-templates select="website" />
	</xsl:template>
	<xsl:template match="website">
		<xsl:variable name="url" select="concat(/data/environment/serverName, '/sitebuilder/preview/', id)" />

		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="GENERAL" />
			<input type="hidden" name="WEBSITE_ID" value="{/data/website/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'GENERAL'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>General Information</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-default" href="javascript:saveWebsite();">Save</a>
					<a class="btn btn-default" href="javascript:skins();submitForm();">Back to Skins</a>
				</div>
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<div class="row" id="title">
			<div class="form-group col-xs-12">
				<label for="WEBSITE_TITLE">Title</label>
				<input type="text" class="form-control" name="WEBSITE_TITLE" id="WEBSITE_TITLE" value="{/data/website/title}" />
			</div>
			<div class="form-group col-xs-12">
				<label for="WEBSITE_URL">Vanity URL</label>
				<input type="text" class="form-control" name="WEBSITE_URL" id="WEBSITE_URL" value="{concat(/data/environment/serverName, '/', /data/website/vanityUrl)}" />
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
