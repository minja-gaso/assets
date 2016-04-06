<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../global_util.xsl" />
	<xsl:include href="../includes/blog_variables.xsl" />
	<xsl:include href="../includes/blog_nav.xsl" />

	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="data">
		<form action="" method="post" name="portal_form">
			<input type="hidden" name="COMPONENT_ID" value="{/data/environment/componentId}" />
			<input type="hidden" name="ACTION" />
			<input type="hidden" name="SCREEN" value="LIST" />
			<input type="hidden" name="BLOG_ID" />
			<!-- survey content -->
			<nav>
				<xsl:call-template name="list_nav" />
			</nav>
			<div class="col-lg-12 bordered-area">
				<h2>My Blogs</h2>
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
						<input type="checkbox" onclick="toggleCheckboxes(this, 'BLOG_ID_LIST');" />
					</th>
					<th class="col-lg-7 col-md-7">Name</th>
					<th class="col-lg-1 col-md-1 text-center">View</th>
					<th class="col-lg-1 col-md-1 text-center">Edit</th>
					<th class="col-lg-1 col-md-1 text-center">Delete</th>
				</tr>
			</thead>
			<tbody>
				<xsl:choose>
					<xsl:when test="count(/data/blog) &gt; 0">
						<xsl:for-each select="/data/blog">
							<tr>
								<th class="text-center"><input type="checkbox" name="BLOG_ID_LIST" value="{id}" /></th>
								<td><a href="javascript:editBlog('{id}');submitForm();"><xsl:value-of select="title" /></a></td>
								<td class="text-center"><a href="{concat(/data/environment/serverName, '/blog/list/', prettyUrl)}" target="_blank"><span class="fa fa-search" /></a></td>
								<td class="text-center"><a href="javascript:editBlog('{id}');submitForm();"><span class="fa fa-edit" /></a></td>
								<td class="text-center">
									<xsl:choose>
										<xsl:when test="/data/user/emailAddress = 'minja.gaso@bswhealth.org'">
											<a href="javascript:deleteBlog('{id}');submitForm();"><span class="fa fa-trash" /></a>
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
						<th class="font-normal" colspan="5">Click the <strong>Create New Blog</strong> button above to get started.</th>
					</xsl:otherwise>
				</xsl:choose>
			</tbody>
		</table>
	</xsl:template>
</xsl:stylesheet>
