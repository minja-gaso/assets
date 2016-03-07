<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../global_util.xsl" />
	<xsl:include href="includes/variables.xsl" />
	<xsl:include href="includes/nav.xsl" />
	<xsl:template match="/">
		<textarea class="form-control" rows="12"><xsl:copy-of select="*" /></textarea>
		<br/><br/><br/>
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="SKIN_LIST" />
			<input type="hidden" name="SKIN_ID" />
			<div class="btn-toolbar">
				<a class="btn btn-default" href="javascript:createSkin();submitForm();"><span class="fa fa-plus"><span class="hide">Plus</span></span> Create New Skin</a>
				<a class="btn btn-default"><span class="fa fa-trash"><span class="hide">Delete Calendar(s)</span></span> Delete Skin(s)</a>
			</div>
			<div class="pull-right text-danger user-info text-right col-md-3 col-xs-12">Hello, <xsl:value-of select="concat(/data/user/firstName, ' ', /data/user/lastName)" /></div>
			<hr />
			<h2>Your Skins</h2>
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
							<xsl:for-each select="/data/skin">
								<tr>
									<th class="text-center"><input type="checkbox" name="SKIN_ID_LIST" value="{id}" /></th>
									<td><a href="javascript:editSkin('{id}');submitForm();"><xsl:value-of select="title" /></a></td>
									<td class="text-center"><a href="{$viewUrl}" target="_blank"><span class="fa fa-search" /></a></td>
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
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
							<th class="font-normal" colspan="5">Click the <strong>Create New Skin</strong> button above to get started.</th>
						</xsl:otherwise>
					</xsl:choose>
				</tbody>
			</table>
		</form>
	</xsl:template>
</xsl:stylesheet>