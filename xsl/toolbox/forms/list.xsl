<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="isSelfAssessment">
		<xsl:choose>
			<xsl:when test="/data/environment/componentId = 2">true</xsl:when>
			<xsl:otherwise>false</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="webformBaseUrl">
		<xsl:choose>
			<xsl:when test="$isSelfAssessment = 'true'">
				<xsl:value-of select="concat(/data/environment/serverName, '/webform/self-assessment/')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="concat(/data/environment/serverName, '/webform/public/')" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:template match="/">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="FORM_LIST" />
			<input type="hidden" name="FORM_ID" />
			<div class="btn-group">
				<a class="btn btn-default" href="javascript:createForm();"><span class="fa fa-plus"><span class="hide">Plus</span></span> Create New Form</a>
				<a class="btn btn-default"><span class="fa fa-trash"><span class="hide">Delete Form(s)</span></span> Delete Forms</a>
			</div>
			<div class="pull-right text-danger user-info text-right col-md-3 col-xs-12">Hello, <xsl:value-of select="concat(/data/user/firstName, ' ', /data/user/lastName)" /></div>
			<hr />
			<h2>
				<xsl:choose>
					<xsl:when test="/data/environment/componentId = 1">Standard Forms &amp; Surveys</xsl:when>
					<xsl:otherwise>Self-Assessment Surveys</xsl:otherwise>
				</xsl:choose>
			</h2>
			<xsl:if test="count(/data/message) &gt; 0">
				<xsl:for-each select="/data/message">
					<xsl:variable name="type">
						<xsl:choose>
							<xsl:when test="type='error'">danger</xsl:when>
							<xsl:when test="type='success'">success</xsl:when>
						</xsl:choose>
					</xsl:variable>
					<div class="alert alert-{$type}"><xsl:value-of select="label" /></div>
				</xsl:for-each>
			</xsl:if>
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
						<xsl:when test="count(/data/form) &gt; 0">
							<xsl:for-each select="/data/form">
								<xsl:variable name="webformById" select="concat($webformBaseUrl, id)" />
								<xsl:variable name="webformPrettyUrl" select="concat($webformBaseUrl, prettyUrl)" />
								<xsl:variable name="webformUrlToUse">
									<xsl:choose>
										<xsl:when test="string-length(prettyUrl) &gt; 0"><xsl:value-of select="$webformPrettyUrl" /></xsl:when>
										<xsl:otherwise><xsl:value-of select="$webformById" /></xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<tr>
									<th class="text-center"><input type="checkbox" name="FORM_ID_LIST" value="{id}" /></th>
									<td><xsl:value-of select="title" /></td>
									<td class="text-center"><xsl:value-of select="submissionCount" /></td>
									<td class="text-center"><a href="{$webformUrlToUse}" target="_blank"><span class="fa fa-search" /></a></td>
									<td class="text-center"><a href="javascript:editForm('{id}');"><span class="fa fa-edit" /></a></td>
									<td class="text-center"><a href="javascript:deleteForm('{id}');"><span class="fa fa-trash" /></a></td>
								</tr>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<th class="font-normal" colspan="6">Click the <strong>Create New Form</strong> button above to get started.</th>
						</xsl:otherwise>
					</xsl:choose>
				</tbody>
			</table>
		</form>
	</xsl:template>
</xsl:stylesheet>
