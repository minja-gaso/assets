<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/variables.xsl" />
	<xsl:include href="includes/nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="SKIN_LIST" />
			<input type="hidden" name="SKIN_ID" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="list_nav" />
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group btn-toolbar">
					<a class="btn btn-default" href="javascript:createSkin();submitForm();"><span class="fa fa-plus"><span class="hide">Plus</span></span> Create New Skin</a>
					<a class="btn btn-default"><span class="fa fa-trash"><span class="hide">Delete Calendar(s)</span></span> Delete Skin(s)</a>
				</div>
				<h2>Your Skins</h2>
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
					<th class="col-lg-7 col-md-7">Title</th>
					<th class="col-lg-1 col-md-1 text-center">View</th>
					<th class="col-lg-1 col-md-1 text-center">Edit</th>
					<th class="col-lg-1 col-md-1 text-center">Delete</th>
				</tr>
			</thead>
			<tbody>
				<xsl:choose>
					<xsl:when test="count(/data/skin) &gt; 0">
						<xsl:apply-templates select="skin" />
					</xsl:when>
					<xsl:otherwise>
						<th class="font-normal" colspan="5">Click the <strong>Create New Skin</strong> button above to get started.</th>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="skin">
		<xsl:variable name="url" select="concat(/data/environment/serverName, '/toolbox/skinPreview/', id)" />
		<tr>
			<th class="text-center"><input type="checkbox" name="SKIN_ID_LIST" value="{id}" /></th>
			<td><a href="javascript:editSkin('{id}');submitForm();"><xsl:value-of select="title" /></a></td>
			<td class="text-center"><a href="{$url}" target="_blank"><span class="fa fa-search" /></a></td>
			<td class="text-center"><a href="javascript:editSkin('{id}');submitForm();"><span class="fa fa-edit" /></a></td>
			<td class="text-center">
				<xsl:choose>
					<xsl:when test="/data/user/emailAddress = 'minja.gaso@bswhealth.org'">
						<a href="javascript:deleteSkin('{id}');submitForm();"><span class="fa fa-trash" /></a>
					</xsl:when>
					<xsl:otherwise>
						<span class="fa fa-trash fa-disabled" />
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
