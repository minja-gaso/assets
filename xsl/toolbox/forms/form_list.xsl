<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/form_variables.xsl" />
	<xsl:include href="includes/form_nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="FORM_LIST" />
			<input type="hidden" name="FORM_ID" />
			<nav>
				<xsl:call-template name="list_nav">
					<xsl:with-param name="SCREEN" select="'EVENT_RECURRENCE'" />
				</xsl:call-template>
			</nav>
			<div class="col-lg-12 bordered-area">
				<div class="form-group" id="top-actions">
					<div class="btn-toolbar">
						<a class="btn btn-default" href="javascript:createForm();submitForm();"><span class="fa fa-plus"><span class="hide">Plus</span></span> Create New Form</a>
						<a class="btn btn-default"><span class="fa fa-trash"><span class="hide">Delete Form(s)</span></span> Delete Forms</a>
					</div>
				</div>
				<h2><xsl:value-of select="$formLabel" /></h2>
				<xsl:call-template name="messages" />
				<table class="table table-bordered table-condensed table-striped">
					<thead>
						<tr>
							<th class="col-lg-1 col-md-1 text-center">
								<input type="checkbox" onclick="toggleCheckboxes(this, 'FORM_ID_LIST');" />
							</th>
							<th class="col-lg-7 col-md-7">Title</th>
							<th class="col-lg-1 col-md-1 text-center">Submissions</th>
							<th class="col-lg-1 col-md-1 text-center">View</th>
							<th class="col-lg-1 col-md-1 text-center">Edit</th>
							<th class="col-lg-1 col-md-1 text-center">Delete</th>
						</tr>
					</thead>
					<tbody>
						<xsl:choose>
							<xsl:when test="count(form) &gt; 0">
								<xsl:apply-templates select="form" />
							</xsl:when>
							<xsl:otherwise>
								<tr>
									<th class="font-normal" colspan="6">Click the <strong>Create New Form</strong> button above to get started.</th>
								</tr>
							</xsl:otherwise>
						</xsl:choose>
					</tbody>
				</table>
			</div>
		</form>
	</xsl:template>
	<xsl:template match="form">
		<xsl:variable name="url" select="concat($baseUrl, prettyUrl)" />
		<tr>
			<th class="text-center"><input type="checkbox" name="FORM_ID_LIST" value="{id}" /></th>
			<td><a href="javascript:editForm('{id}');submitForm();"><xsl:value-of select="title" /></a></td>
			<td class="text-center"><xsl:value-of select="submissionCount" /></td>
			<td class="text-center"><a href="{$url}" target="_blank"><span class="fa fa-search" /></a></td>
			<td class="text-center"><a href="javascript:editForm('{id}');submitForm();"><span class="fa fa-edit" /></a></td>
			<td class="text-center"><a href="javascript:deleteForm('{id}');submitForm();"><span class="fa fa-trash" /></a></td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
