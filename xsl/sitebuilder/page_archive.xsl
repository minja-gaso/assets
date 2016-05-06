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
			<input type="hidden" name="SCREEN" value="PAGE_ARCHIVE" />
			<input type="hidden" name="WEBSITE_ID" value="{id}" />
			<input type="hidden" name="PAGE_ID" value="{archivePage/fkPageId}" />
			<input type="hidden" name="ARCHIVE_ID" value="{page/id}" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="page_edit">
					<xsl:with-param name="SCREEN" select="'PAGE_ARCHIVE'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>Modify Page</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-success" href="javascript:applyArchive();">Apply Archive</a>
					<a class="btn btn-danger" href="javascript:switchTab('PAGES');">Back to Pages</a>
				</div>
			</div>
		</form>
	</xsl:template>

	<xsl:template name="main">
		<xsl:variable name="selectedTemplateId" select="archivePage/fkTemplateId" />
		<xsl:variable name="vanityUrl" select="concat(/data/website/url, '/', archivePage/url)" />
		<div class="row" id="selection">
			<div class="col-xs-12">
				<label for="ARCHIVE">Archive</label>
				<select name="ARCHIVE" class="form-control" onchange="document.portal_form.ARCHIVE_ID.value=this.options[this.selectedIndex].value;document.portal_form.submit();">
					<xsl:for-each select="archivePage">
						<option value="{id}">
							<xsl:if test="/data/website/page/id = id">
								<xsl:attribute name="selected">selected</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="concat(title, '   ', creationTimestamp)" />
						</option>
					</xsl:for-each>
				</select>
			</div>
		</div>
		<hr />
		<div class="row" id="data">
			<div class="form-group col-xs-12">
				<label for="PAGE_TITLE">Title</label>
				<input type="text" class="form-control" name="PAGE_TITLE" id="PAGE_TITLE" value="{page/title}" readonly="readonly" />
			</div>
			<div class="form-group col-xs-12">
				<label for="PAGE_SUBTITLE">Subtitle</label>
				<input type="text" class="form-control" name="PAGE_SUBTITLE" id="PAGE_SUBTITLE" value="{page/subtitle}" readonly="readonly" />
			</div>
			<!--
			<div class="form-group col-xs-12">
				<label for="PAGE_URL">Vanity URL</label>
				<input type="text" class="form-control" name="PAGE_URL" id="PAGE_URL" value="{page/url}" readonly="readonly" />
			</div>
			<div class="form-group col-xs-12">
				<label for="PAGE_TEMPLATE">Template</label>
				<select class="form-control" name="PAGE_TEMPLATE" id="PAGE_TEMPLATE" onchange="saveWebsitePage();" readonly="readonly">
					<option value="0" />
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
			-->
			<div class="form-group col-xs-12">
				<label for="PAGE_HTML" class="show">HTML</label>
				<textarea class="form-control" name="PAGE_HTML" id="PAGE_HTML" rows="20" readonly="readonly">
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
