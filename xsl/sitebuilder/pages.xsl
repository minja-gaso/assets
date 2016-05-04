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
	<xsl:template match="environment"></xsl:template>
	<xsl:template match="website">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="PAGES" />
			<input type="hidden" name="WEBSITE_ID" value="{id}" />
			<input type="hidden" name="PAGE_ID" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'PAGES'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group btn-toolbar">
					<a class="btn btn-default" href="javascript:createWebsitePage();"><span class="fa fa-plus"><span class="hide">Plus</span></span> Create New Page</a>
				</div>
				<h2>Pages</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
			</div>
		</form>
	</xsl:template>
	<xsl:template name="main">
		<table class="table table-bordered table-condensed table-striped">
			<thead>
				<tr>
					<th class="col-lg-1 col-md-1 text-center">
						<input type="checkbox" onclick="toggleCheckboxes(this, 'SKIN_ID_LIST');" />
					</th>
					<th class="col-lg-6 col-md-6">Title</th>
					<th class="col-lg-1 col-md-1 text-center">View</th>
					<th class="col-lg-1 col-md-1 text-center">Edit</th>
					<th class="col-lg-1 col-md-1 text-center">Delete</th>
				</tr>
			</thead>
			<tbody>
				<xsl:choose>
					<xsl:when test="count(page) &gt; 0">
						<xsl:apply-templates select="page" />
					</xsl:when>
					<xsl:otherwise>
						<th class="font-normal" colspan="5">Click the <strong>Create New Template</strong> button above to get started.</th>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="page">
		<xsl:variable name="url" select="concat(/data/environment/serverName, '/sitebuilder/page/', id)" />
		<xsl:variable name="templateID" select="fkTemplateId" />
		<tr>
			<th class="text-center"><input type="checkbox" name="SKIN_ID_LIST" value="{id}" /></th>
			<td>
				<a href="javascript:editWebsitePage('{id}');">
					<xsl:choose>
						<xsl:when test="string-length(title) &gt; 0">
							<xsl:value-of select="title" />
						</xsl:when>
						<xsl:otherwise>
							<span class="text-danger">Please add a title to this page</span>
						</xsl:otherwise>
					</xsl:choose>
				</a>
				<div class="help-block">
					<strong>Template</strong><br/>
					<xsl:choose>
						<xsl:when test="string-length(/data/website/template[id = $templateID]/title) &gt; 0">
							<xsl:value-of select="/data/website/template[id = $templateID]/title" />
						</xsl:when>
						<xsl:otherwise>
							<em>None</em>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</td>
			<td class="text-center"><a href="{$url}" target="_blank"><span class="fa fa-search" /></a></td>
			<td class="text-center"><a href="javascript:editWebsitePage('{id}');"><span class="fa fa-edit" /></a></td>
			<td class="text-center"><a href="javascript:deleteWebsitePage('{id}');"><span class="fa fa-trash" /></a></td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
