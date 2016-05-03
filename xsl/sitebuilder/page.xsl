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
		<xsl:variable name="url" select="concat(/data/environment/serverName, '/sitebuilder/page/', page/id)" />

		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="PAGE" />
			<input type="hidden" name="WEBSITE_ID" value="{/data/website/id}" />
			<input type="hidden" name="PAGE_ID" value="{/data/website/page/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="page_edit" />
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>Modify Page</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-default" href="javascript:saveWebsitePage();">Save</a>
					<a class="btn btn-default" href="javascript:switchTab('PAGES');">Back to Skins</a>
					<a class="btn btn-default" href="{$url}" target="_blank">View Skin</a>
				</div>
			</div>
		</form>
	</xsl:template>

	<xsl:template name="main">
		<xsl:variable name="selectedTemplateId" select="page/fkTemplateId" />
		<xsl:variable name="vanityUrl" select="concat(/data/website/url, '/', page/url)" />
		<div class="row" id="title">
			<div class="form-group col-xs-12">
				<label for="PAGE_TITLE">Name</label>
				<input type="text" class="form-control" name="PAGE_TITLE" id="PAGE_TITLE" value="{page/title}" />
			</div>
			<div class="form-group col-xs-12">
				<label for="PAGE_URL">Vanity URL</label>
				<input type="text" class="form-control" name="PAGE_URL" id="PAGE_URL" value="{page/url}" />
			</div>
			<div class="form-group col-xs-12">
				<label for="PAGE_TEMPLATE">Template</label>
				<select class="form-control" name="PAGE_TEMPLATE" id="PAGE_TEMPLATE" onchange="saveWebsitePage();">
					<xsl:for-each select="template">
						<option value="{id}">
							<xsl:if test="id = $selectedTemplateId">
								<xsl:attribute name="selected">selected</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="title" />
						</option>
					</xsl:for-each>
				</select>
			</div>
			<div class="form-group col-xs-12">
				<label for="PAGE_HTML" class="show">HTML</label>
				<textarea class="form-control" name="PAGE_HTML" id="PAGE_HTML" rows="20">
					<xsl:if test="/data/skin/editable = 'false'">
						<xsl:attribute name="disabled">disabled</xsl:attribute>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="string-length(page/html) &gt; 0">
							<xsl:value-of select="page/html" />
						</xsl:when>
						<xsl:otherwise><xsl:text>&#x0A;</xsl:text></xsl:otherwise>
					</xsl:choose>
				</textarea>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>
