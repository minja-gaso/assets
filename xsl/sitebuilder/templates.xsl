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
	<xsl:template match="admin"></xsl:template>
	<xsl:template match="website">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="TEMPLATES" />
			<input type="hidden" name="WEBSITE_ID" value="{/data/website/id}" />
			<input type="hidden" name="TEMPLATE_ID" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="primary_navigation">
					<xsl:with-param name="SCREEN" select="'TEMPLATES'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group btn-toolbar">
					<a class="btn btn-default" href="javascript:createWebsiteTemplate();"><span class="fa fa-plus"><span class="hide">Plus</span></span> Create New Template</a>
				</div>
				<h2>Templates</h2>
				<xsl:call-template name="messages" />
				<xsl:call-template name="main" />
				<div class="btn-toolbar btn-actions">
					<a class="btn btn-danger" href="javascript:websiteList();">Back to Websites</a>
				</div>
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
					<th class="col-lg-7 col-md-7">Title</th>
					<th class="col-lg-1 col-md-1 text-center">View</th>
					<th class="col-lg-1 col-md-1 text-center">Edit</th>
					<th class="col-lg-1 col-md-1 text-center">Delete</th>
				</tr>
			</thead>
			<tbody>
				<xsl:choose>
					<xsl:when test="count(template) &gt; 0">
						<xsl:apply-templates select="template" />
					</xsl:when>
					<xsl:otherwise>
						<th class="font-normal" colspan="5">Click the <strong>Create New Template</strong> button above to get started.</th>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="template">
		<xsl:variable name="url" select="concat(/data/environment/serverName, '/sitebuilder/preview/', id, '?WEBSITE_ID=', ../id)" />
		<tr>
			<th class="text-center"><input type="checkbox" name="SKIN_ID_LIST" value="{id}" /></th>
			<td>
				<a href="javascript:editWebsiteTemplate('{id}');">
					<xsl:choose>
						<xsl:when test="string-length(title) &gt; 0">
							<xsl:value-of select="title" />
						</xsl:when>
						<xsl:otherwise>
							<span class="text-danger">Please add a title to this page</span>
						</xsl:otherwise>
					</xsl:choose>
				</a>
			</td>
			<td class="text-center"><a href="{$url}" target="_blank"><span class="fa fa-search" /></a></td>
			<td class="text-center"><a href="javascript:editWebsiteTemplate('{id}');"><span class="fa fa-edit" /></a></td>
			<td class="text-center"><a href="javascript:deleteWebsiteTemplate('{id}');"><span class="fa fa-trash" /></a></td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
